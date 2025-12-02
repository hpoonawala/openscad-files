# About

I was gifted an Activity Bot robot kit by my in-laws. I decided to turn it into a remote controlled robot that I would gift to my nephew, marking a return to building things after a long gap for me.

This repo contains the frame I used to attach my custom PCB to the robot. I used an `ESP32` dev kit instead of the board that came with the bot to get around the proprietary software and to add remote control. The PCB handles power from the battery case on the chassis, powering the motors, and reading the encoder values. 

It also contains the remote control case that houses a joystick button connected to another `ESP32` devkit. The `ESP32` had to be powered externally through USB. 
