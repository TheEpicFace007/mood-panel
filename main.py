import os
import sys
import text2emotion

from flask import Flask, render_template, redirect, url_for, flash, jsonify

app = Flask(__name__)
emotions = {
    'Angry': 0,
    'Fear': 0,
    'Happy': 0,
    'Sad': 0,
    'Surprise': 0
}

@app.route('/')
def index():
    return render_template('index.html', emotion=emotions)

@app.route('/reset_emotion')
def reset_emotion():
    global emotions
    emotions = {
        'Angry': 0,
        'Fear': 0,
        'Happy': 0,
        'Sad': 0,
        'Surprise': 0
    }
    return "Resetted Emotion"

@app.route('/add_message/<message>')
def add_message(message):
    emotion = text2emotion.get_emotion(message)
    print("Emotion of message: ", emotion)
    for key in emotions:
        emotions[key] +=  emotion[key]
    return "Added Message"

if __name__ == '__main__':
    ip = '192.168.2.12'
    app.run(ip, port=8080, debug=True)