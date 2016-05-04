server {
        listen 8050;
#        server_name 127.0.0.1;

        error_log  /var/log/nginx/error.log;
        access_log /var/log/nginx/access.log;

        location /cas {
                rewrite ^(.*) /cas/index.php?_url=$1;
        }

        location /api {
                rewrite ^(.*) /cas/index.php?_url=$1;
        }

        location ~ /cas/index.php {
                root /var/www/lib/cas-server;
                fastcgi_pass ${PROJECT}php:9000;
                fastcgi_index /index.php;
                include /etc/nginx/fastcgi_params;
                fastcgi_split_path_info ^(.+\.php)(/.+)$;
                fastcgi_param PATH_INFO $fastcgi_path_info;
#               fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
                fastcgi_param SCRIPT_FILENAME $document_root/index.php;
        }
}
