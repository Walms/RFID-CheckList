sudo cp exampleDatabaseEntries.csv /var/lib/mysql/RFID_CheckList
wait
mysql -uroot -p123456 -e "CREATE DATABASE IF NOT EXISTS RFID_CheckList"
mysql -uroot -p123456 -e "DROP TABLE itemList" RFID_CheckList
mysql -uroot -p123456 -e "CREATE TABLE IF NOT EXISTS itemList (tagNumber INT, equipmentType VARCHAR(50), Maker VARCHAR(50), Model VARCHAR(50), serialNumber VARCHAR(50), tmpListCnt INT, tagDetected INT)" RFID_CheckList
mysql -uroot -p123456 "RFID_CheckList" -e "LOAD DATA INFILE 'exampleDatabaseEntries.csv' INTO TABLE itemList  FIELDS TERMINATED BY ',' IGNORE 1 LINES"
morbo index.pl
