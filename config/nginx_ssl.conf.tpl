server {
        listen 80 default_server;
        server_name ${app_uri};
        return 301 https://$server_name$request_uri;
}
server {
        listen 443 ssl;
        listen [::]:443 ssl;
        server_name ${app_uri};
        add_header Strict-Transport-Security "max-age=300; includeSubDomains" always;
        root /var/www/${app_uri};
        index index.html;
        location / {
                try_files $uri $uri/ =404;
        }
        ssl_certificate     /root/certs/${app_uri}/cert.pem;
        ssl_certificate_key /root/certs/${app_uri}/key.pem;
}