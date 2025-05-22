import streamlit as st
import joblib
import numpy as np

# Load model
model = joblib.load("rf_liquidity_model.pkl")

st.title("Crypto Liquidity Classifier")

st.write("Enter values to predict liquidity class:")

# Input fields for features
log_volume = st.number_input("Log Volume")
log_liquidity = st.number_input("Log Liquidity")
log_mkt_cap = st.number_input("Log Market Cap")
momentum_3d = st.number_input("Momentum (1h + 24h + 7d)")
volume_per_price = st.number_input("Volume per Price")
volatility_24h = st.number_input("24h Volatility")
log_price = st.number_input("Log Price")


# Predict
if st.button("Predict"):
    input_data = np.array([[log_volume, log_liquidity, log_mkt_cap,
                            momentum_3d, volume_per_price,
                            volatility_24h, log_price]])
    prediction = model.predict(input_data)[0]
    label = "High Liquidity" if prediction == 1 else "Low Liquidity"
    st.success(f"Prediction: {label}")
