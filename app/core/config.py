from pydantic import BaseSettings

class Settings(BaseSettings):
    MONGODB_URL: str = "mongodb+srv://WizardTi:75YUkDYZp4aYITFP@cluster0.rfbjo.mongodb.net/"
    MONGODB_NAME: str = "payment_db"
    MPESA_API_URL: str = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest" #will confirm
    MPESA_CONSUMER_KEY: str  # to be updated
    MPESA_CONSUMER_SECRET: str  # to be updated
    MPESA_SHORTCODE: str  # to be updated
    MPESA_PASSKEY: str  # to be updated

    class Config:
        env_file = ".env"

settings = Settings()