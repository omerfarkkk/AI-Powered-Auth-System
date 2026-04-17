from flask import Flask, request, jsonify
from flask_cors import CORS
import time
from sklearn.tree import DecisionTreeClassifier
import numpy as np

app = Flask(__name__)
CORS(app)

users = {
    "admin": "1234"
}

giris_denemeleri = {}
engellenen_hesaplar = {}

MAX_DENEME_SAYISI = 3
ENGELLEME_SURESI = 30


X = np.array([
    [1, 5],   
    [2, 4],
    [3, 3],
    [5, 1],   
    [6, 1],
    [7, 0.5]
])

y = [0, 0, 0, 1, 1, 1]  

model = DecisionTreeClassifier()
model.fit(X, y)

@app.route("/login", methods=["POST"])
def login():
    data = request.json
    username = data.get("username")
    password = data.get("password")

    current_time = time.time()

    #blok kontrolü
    if username in engellenen_hesaplar:
        if current_time < engellenen_hesaplar[username]:
            return jsonify({"status": "blocked"})
        else:
            del engellenen_hesaplar[username]
            giris_denemeleri[username] = 0

    if username not in giris_denemeleri:
        giris_denemeleri[username] = 0

    #doğru giriş
    if users.get(username) == password:
        giris_denemeleri[username] = 0
        return jsonify({"status": "success"})

    #yanlış giriş
    giris_denemeleri[username] += 1

    #ML TAHMİNİ
    deneme_sayisi = giris_denemeleri[username]
    zaman_farki = 1  

    prediction = model.predict([[deneme_sayisi, zaman_farki]])[0]

    #ML blok kararı
    if prediction == 1:
        engellenen_hesaplar[username] = current_time + ENGELLEME_SURESI
        return jsonify({
            "status": "blocked",
            "reason": "AI suspicious activity detected"
        })

    # 🔒 klasik brute force
    if giris_denemeleri[username] >= MAX_DENEME_SAYISI:
        engellenen_hesaplar[username] = current_time + ENGELLEME_SURESI
        return jsonify({"status": "blocked"})

    return jsonify({"status": "fail"})


if __name__ == "__main__":
    app.run(debug=True)