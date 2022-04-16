#!/bin/sh

nohup /usr/sbin/sshd -D & disown

node server/server.js
