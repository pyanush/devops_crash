#!/bin/bash
sshpass -f "passfile" scp -o StrictHostKeyChecking=no  -r testuser@207.244.229.74:/opt/testuser/logfile.log /logs/

