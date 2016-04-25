server {
        listen 8050;
        root /var/www/lib/cas-server;

        error_log  /var/log/nginx/error.log;
        access_log /var/log/nginx/access.log;

        location / {
           try_files $uri /index.php$is_args$args;   
        }

        location ~ \.php$ {
                fastcgi_pass ${PROJECT}_php:9000;
                fastcgi_index index.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }
}

