#!/bin/bash

sudo apt-get update 
sudo apt-get install -y ${apt_packages_to_install}
sudo systemctl enable nginx