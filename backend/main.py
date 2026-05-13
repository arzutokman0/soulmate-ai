import google.generativeai as genai
from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
import os

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# API Ayarları
GENAI_API_KEY = "AIzaSyCF519Y8Y7uWwT58HT-GMj7bytbWkJUTZE"
genai.configure(api_key=GENAI_API_KEY)

# OTOMATİK MODEL SEÇİCİ: Bilgisayarında hangi model varsa onu bulur
try:
    available_models = [m.name for m in genai.list_models() if 'generateContent' in m.supported_generation_methods]
    # Varsa 1.5-flash, yoksa pro, o da yoksa listedeki ilk modeli seçer
    model_name = "models/gemini-1.5-flash" if "models/gemini-1.5-flash" in available_models else available_models[0]
    model = genai.GenerativeModel(model_name)
    print(f"--- AKTİF MODEL: {model_name} ---")
except Exception as e:
    print(f"Model listeleme hatası: {e}")
    model = genai.GenerativeModel('gemini-pro') # En son çare

class StoryRequest(BaseModel):
    character: str
    emotion: str

@app.post("/generate-story")
async def generate_story(request: StoryRequest):
    try:
        user_prompt = f"Karakter: {request.character}, Duygu: {request.emotion}. Bu bilgilerle kısa, pofuduk bir çocuk masalı yaz."
        response = model.generate_content(user_prompt)
        return {"story": response.text, "error": False}
    except Exception as e:
        return {"story": f"Hata oluştu: {str(e)}", "error": True}

@app.get("/")
async def root():
    return {"status": "running"}