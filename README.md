RFID-CheckList
==============

# GPIO library for raspberry pi

sudo apt-get update && sudo apt-get upgrade -y

git clone git://git.drogon.net/wiringPi

cd wiringPi

./build

# Widegand sample code installation

cd

wget http://tonigor.com/pidoorman/wiegand.c

cc -o wiegand wiegand.c -L/usr/local/lib -lwiringPi -lpthread

You will then be able to run the program:

sudo ./wiegand

# Hardware Wiring
IMPORTANT DISCLAIMER: WIEGAND READERS USE 5V DC, WHILE THE RASPBERRY PI IS A 3.3V DEVICE. IF YOU CHOOSE TO FOLLOW THESE INSTRUCTIONS, I CAN TAKE NO RESPONSIBILITY IF YOU BLOW UP YOUR RASPBERRY PI.

With this in mind, please look at the protection circuit very carefully:

![alt tag](https://raw.githubusercontent.com/ebulanik/RFID-CheckList/master/doc/ProtectionCircuit.jpg)

The protection needs to be applied to both the Data0 and Data1 connections. The GPIO pins I use in my example code are pins 0 and 1. Your Wiegand reader will obviously require 12V, for which I use an external power supply. 


# References 
http://pidoorman.com/

http://wiringpi.com/

