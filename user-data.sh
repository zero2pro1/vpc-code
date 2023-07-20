#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
echo "<h1>Welcome to Zero2Pro, Fast Track Your DevOps Career From Zero to Pro</h1>" > /var/www/html/index.html