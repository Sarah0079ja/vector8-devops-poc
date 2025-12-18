from flask import Flask, jsonify

app = Flask(__name__)

@app.get("/api/health")
def health():
    return jsonify(status="ok")

@app.get("/api")
def api():
    return jsonify(message="Hello from backend")
