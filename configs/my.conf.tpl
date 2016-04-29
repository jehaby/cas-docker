server {
        listen 80;
        root /var/www/web/;
        server_name my.local

        client_max_body_size 50m;

        error_log  /var/log/nginx/error.log;
        access_log /var/log/nginx/access.log;

        location / {
           try_files $uri /app.php$is_args$args;   
        }

        location ~ \.php$ {
                fastcgi_pass ${PROJECT}php:9000;
                fastcgi_index app.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }
}


server {
        listen 80;
        root /var/www/web/;
        server_name my-dev.local

        client_max_body_size 50m;

        error_log  /var/log/nginx/error.log;
        access_log /var/log/nginx/access.log;

        location / {
           try_files $uri /app_dev.php$is_args$args;   
        }

        location ~ \.php$ {
                fastcgi_pass ${PROJECT}php:9000;
                fastcgi_index app_dev.php;
                fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
                include fastcgi_params;
        }
}
