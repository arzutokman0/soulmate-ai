import os
import json
from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from google import genai
from google.genai import types
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()

# Chrome testlerinde tarayıcı engeline (CORS) takılmamak için gereken sihirli ayar
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class StoryRequest(BaseModel):
    character: str
    emotion: str

@app.post("/generate-story")
async def generate_story(request: StoryRequest):
    api_key = os.getenv("GEMINI_API_KEY")
    if not api_key:
        print("HATA: .env dosyasında GEMINI_API_KEY bulunamadı!")
        raise HTTPException(status_code=500, detail="API Key bulunamadı!")
        
    try:
        # İzole sanal ortamda aslanlar gibi çalışan yeni nesil Google Client yapısı
        client = genai.Client(api_key=api_key)
        
        prompt = f"""
        Karakter: {request.character}
        Duygu: {request.emotion}
        
        Lütfen yukarıdaki karakter ve duyguya uygun, çocuklar için pofuduk ve eğitici bir masal üret. 
        Masal tam ortasında bir bilmeceyle durmalı. 
        Yanıtı tam olarak şu JSON formatında ver (başka hiçbir metin veya markdown işareti ekleme):
        {{
          "storyPart1": "Masalın ilk yarısı...",
          "riddleQuestion": "Tam burada sorulacak bilmece...",
          "riddleOptions": ["Şık 1", "Şık 2", "Şık 3"],
          "correctAnswer": "Doğru olan şık",
          "storyPart2": "Bilmece çözüldükten sonraki mutlu son...",
          "lessonLearned": "Bu masaldan çıkarılacak pofuduk ve eğitici ders (en fazla 20 kelime)",
          "dailyMission": "Çocuğun gerçek hayatta yapacağı o duyguyla ilgili eğlenceli görev (Örn: Bugün birine teşekkür et!)"
        }}
        """
        
        # Google'ın en güncel ve kararlı modeli olan gemini-2.5-flash ve JSON çıktısı güvencesi
        response = client.models.generate_content(
            model='gemini-2.5-flash',
            contents=prompt,
            config=types.GenerateContentConfig(
                response_mime_type="application/json"
            )
        )
        
        return json.loads(response.text)
    except Exception as e:
        print(f"YAPAY ZEKA VEYA PARSE HATASI: {str(e)}")
        raise HTTPException(status_code=500, detail=str(e))