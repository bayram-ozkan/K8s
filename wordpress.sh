# nginx üzerinden wordpress kurulum aşamaları

sudo apt install nginx -y
sudo systemctl status nginx
sudo apt install php-fpm php-mysql php-xml php-curl php-mbstring -y
sudo wget https://wordpress.org/latest.tar.gz
sudo tar -xvzf latest.tar.gz
sudo mv wordpress/* /var/www/html/
sudo chown -R www-data:www-data /var/www/html/  
sudo chmod -R 755 /var/www/html/


cd /var/www/html
sudo cp wp-config-sample.php wp-config.php
sudo nano  wp-config.php


cd ../sites-available/

sudo rm -rf default





sudo ln -sf /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo systemctl restart nginx

sudo rm -rf /var/www/html/index.nginx-debian.html

sudo chown -R www-data:www-data /var/www/html/  
sudo chmod -R 755 /var/www/html/
sudo nano /etc/nginx/sites-enabled/wordpress



server {  
    listen 80;  
    server_name your_domain_or_IP; # Burayı kendi alan adınız veya IP adresinizle değiştirin  

    root /var/www/html;  
    index index.php index.html index.htm;  

    location / {  
        try_files $uri $uri/ /index.php?$args;  
    }  

    location ~ \.php$ {  
        include snippets/fastcgi-php.conf;  
        fastcgi_pass unix:/var/run/php/php8.3-fpm.sock; # PHP versiyonunu kontrol edin  
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;  
        include fastcgi_params;  
    }  

    location ~ /\.ht {  
        deny all;  
    }  
}