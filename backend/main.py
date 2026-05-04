from fastapi import FastAPI

app = FastAPI()

@app.get("/")
def read_root():
    return {
        "status": "ready",
        "project": "SoulMate Kids API",
        "version": "1.0.0",
        "mode": "Emotional Support & Educational"
    }