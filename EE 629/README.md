## About the repository

This is the course repository of EE-629 (Internet of Things), given at Stevens Institute of Technology in semester 2019 Fall.

## About the project

The purpose of this project is to sense the environment using SenseHAT, and get the weather data of another city (Shanghai) from OpenWeatherMap API.

The SenseHAT has a 8*8 LED screen so we can display the information on the screen.

Finally, thanks to `gtts` library in python, the Pi 4 running the script will convert text message to audio and play it.

## Prerequisites

Raspberry Pi * 1

`sudo apt-get install sense-hat`

`pip3 install -U gtts requests pygame`

## Installation

`python3 final.py`

That's it.