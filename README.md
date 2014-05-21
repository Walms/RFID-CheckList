RFID-CheckList
==============

sudo apt-get update && sudo apt-get upgrade

cd /tmp

wget http://project-downloads.drogon.net/files/wiringPi.tgz

tar xfz wiringPi.tgz

cd wiringPi/wiringPi

make

sudo make install

cd ../gpio

make

sudo make install
