#!/bin/bash
set -e

firewall-cmd --zone=work --change-interface=eno1
firewall-cmd --zone=work --add-service=http
firewall-cmd --zone=work --add-service=https
firewall-cmd --zone=work --add-port=8282/tcp
firewall-cmd --zone=work --add-port=8080/tcp
firewall-cmd --zone=work --add-port=5678/tcp 
systemctl start cockpit
firewall-cmd --zone=work --add-port=9090/tcp
