import os
import shutil
from dotenv import load_dotenv
from fastapi import FastAPI, UploadFile, File, HTTPException
from pydantic import BaseModel

# LangChain & AI Imports
from langchain_groq import ChatGroq
from langchain_huggingface import HuggingFaceEmbeddings
from langchain_community.document_loaders import PyPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_chroma import Chroma
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

# --- BLOCK 1: SETUP ---
# Load the API Key from the .env file
load_dotenv()

# Initialize the FastAPI app
app = FastAPI(title="Free GenAI Doc Assistant")

# Setup the Embedding Model (Translates text to numbers)
# We use a free, local model from HuggingFace
embedding_function = HuggingFaceEmbeddings(model_name="all-MiniLM-L6-v2")

# Define where the database will be saved on your computer
DB_DIR = "db_data"

def get_vectorstore():
    """Helper function to load the Vector Database"""
    return Chroma(persist_directory=DB_DIR, embedding_function=embedding_function)

# --- BLOCK 2: UPLOAD ENDPOINT ---
@app.post("/upload-pdf/")
async def upload_pdf(file: UploadFile = File(...)):
    try:
        # 1. Save the uploaded file temporarily
        file_path = f"temp_{file.filename}"
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)

        # 2. Load the PDF content
        loader = PyPDFLoader(file_path)
        docs = loader.load()
        
        # 3. Split the text into small chunks
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=800, chunk_overlap=100)
        chunks = text_splitter.split_documents(docs)

        # 4. Index these chunks into the Vector Database
        vectorstore = get_vectorstore()
        vectorstore.add_documents(chunks)

        # 5. Clean up (delete the temp file)
        os.remove(file_path)
        
        return {"message": f"Successfully processed {len(chunks)} chunks from {file.filename}"}
    
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

# --- BLOCK 3: QUERY ENDPOINT ---
class QueryRequest(BaseModel):
    question: str

@app.post("/ask/")
async def ask_question(request: QueryRequest):
    # 1. Setup the Database and Retriever
    vectorstore = get_vectorstore()
    retriever = vectorstore.as_retriever(search_kwargs={"k": 3})
    
    # 2. Setup the LLM (Llama 3 via Groq)
    # If GROQ API key is not set, fall back to returning the retrieved documents as the "answer"
    if not os.getenv("GROQ_API_KEY"):
        # Return the top retrieved documents as a plain text answer (simple fallback)
        docs = retriever.get_relevant_documents(request.question)
        if not docs:
            raise HTTPException(status_code=500, detail="No GROQ_API_KEY set and no documents found. Upload PDFs first or set GROQ_API_KEY.")
        combined = "\n\n---\n\n".join(d.page_content for d in docs)
        return {"answer": f"(No GROQ_API_KEY found — returning top documents):\n\n{combined}"}

    llm = ChatGroq(
        model="llama3-8b-8192",
        temperature=0
    )

    # 3. Create the Prompt Template
    template = """Answer the question based only on the following context:
    {context}

    Question: {question}
    """
    prompt = ChatPromptTemplate.from_template(template)

    # 4. Build the Chain (The Pipeline)
    chain = (
        {"context": retriever, "question": RunnablePassthrough()}
        | prompt
        | llm
        | StrOutputParser()
    )

    # 5. Run the chain
    response = chain.invoke(request.question)
    return {"answer": response}