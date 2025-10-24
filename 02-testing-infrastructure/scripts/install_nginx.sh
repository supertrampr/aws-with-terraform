#!/bin/bash

sudo apt-get update 
sudo apt-get install -y nginx
sudo systemctl enable nginx

sudo touch /var/www/html/index.html
echo "${file("${path.root}/html/index.html")}" | sudo tee /var/www/html/index.html