RFID-CheckList
==============

sudo apt-get update && sudo apt-get upgrade

# GPIO lbrary for raspberry pi
cd /tmp
wget http://project-downloads.drogon.net/files/wiringPi.tgz
tar xfz wiringPi.tgz
cd wiringPi/wiringPi
make
sudo make install
cd ../gpio
make
sudo make install

# Widegand sample code installation & run
wget http://pidoorman.com/wiegand.c
cc -o wiegand wiegand.c -L/usr/local/lib -lwiringPi -lpthread
You will then be able to run the program:
sudo /wiegand
