#!/bin/bash
sshpass -f "pass.txt" scp -o StrictHostKeyChecking=no  -r testuser@207.244.229.74:/opt/testuser/logfile.log /home/mykola/download/
