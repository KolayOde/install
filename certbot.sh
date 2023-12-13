#! /bin/sh
cd /home
apt-get install certbot
wget https://github.com/joohoi/acme-dns-certbot-joohoi/raw/master/acme-dns-auth.py
chmod +x acme-dns-auth.py
nano acme-dns-auth.py
mv acme-dns-auth.py /etc/letsencrypt/
certbot certonly --standalone
openssl pkcs12 -inkey privkey.pem -in fullchain.pem -export -out rootCA.pfx
openssl x509 -enddate -noout -in cert.pem
