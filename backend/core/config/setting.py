from pydantic_settings import BaseSettings

class Settings(BaseSettings):
    MONGODB_URL: str = "mongodb+srv://WizardTi:75YUkDYZp4aYITFP@cluster0.rfbjo.mongodb.net/"
    MONGODB_NAME: str = "payment_db"
    MPESA_API_URL: str = "https://sandbox.safaricom.co.ke/mpesa/stkpush/v1/processrequest"
    MPESA_CONSUMER_KEY: str = "jifomwBe5I5okxisGh5197qXbEju7n3UcULy1SGaYsBekEeg"
    MPESA_CONSUMER_SECRET: str = "sDQApljVrf65cLc6TBUAbOF6l8pIfTDVqJoFgN03AX7QGyAe3oOJm8AiZaefU6GT"
    MPESA_SHORTCODE: str = "600247"
    MPESA_PASSKEY: str = "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919"

    class Config:
        env_file = ".env"


settings = Settings()