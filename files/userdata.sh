#!/bin/bash

amazon-linux-extras install nginx -y
systemctl enable nginx
systemctl start nginx