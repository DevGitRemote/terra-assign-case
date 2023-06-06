install.sh   ---file | put below codes in this file and place the file and main.tf file in 
same directory and run
#!/bin/bash
sudo apt update -y
sudo apt install apache2 -y
sudo su
echo "custom html page devraj" > /var/www/html/index.html
