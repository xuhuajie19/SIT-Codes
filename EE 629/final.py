from sense_hat import SenseHat
import time
import json
import requests
import pygame
from gtts import gTTS

sense = SenseHat()

# Define the colours red and green
black = (0, 0, 0)
green = (0, 163, 129)

while True:

  # Take readings from all three sensors
  c = sense.get_compass()
  t = sense.get_temperature()
  p = sense.get_pressure()
  h = sense.get_humidity()

  # Round the values to one decimal place
  c = round(c, 1)
  t = round(t, 1)
  p = round(p, 1)
  h = round(h, 1)
  
  # Create the message
  # str() converts the value to a string so it can be concatenated
  message = "Good morning. Current Temperature is: " + str(t) + " Degree; Pressure is: " + str(p) + " kiloPascal; Humidity is: " + str(h)+" Percent. "
  api = 'http://api.openweathermap.org/data/2.5/weather?q=Shanghai&units=metric&APPID=c2[*SECRET*]'
  x = requests.get(api).json()
  message2 = "Let's take a look at Shanghai's weather. The weather condition is "+str(x["weather"][0]["description"])+". Current temperature is "+str(x["main"]["temp"])+" degrees. The wind speed is "+str(x["wind"]["speed"])+" meters per second. Have a nice day!"
  print(x["main"]["temp"]) 
  message += message2
  print(message)
  tts = gTTS(message)
  tts.save('message.mp3')

  pygame.mixer.init()
  pygame.mixer.music.load("message.mp3")
  pygame.mixer.music.set_volume(1.0)
  pygame.mixer.music.play()

  while pygame.mixer.music.get_busy() == True:
    pass

  sense.show_message(message, scroll_speed=0.1, text_colour=green, back_colour=black)
  