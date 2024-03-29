#! /bin/sh
cd /home
echo deb http://deb.debian.org/debian/ buster main >> /etc/apt/sources.list
#echo deb http://deb.debian.org/debian/ buster main >> /etc/apt/sources.list
wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
#wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb
dpkg --install packages-microsoft-prod.deb
apt-get update
apt-get install -y dotnet-sdk-3.1
#apt-get install -y dotnet-sdk-8.0
apt-get install -y git
git clone https://github.com/KolayOde/deployment.git
mv deployment/* .
rm -r deployment
sed -i 's/IP/'"$1"'/g' build/appsettings.js
sed -i 's/IP/'"$1"'/g' buildagent/appsettings.js
sed -i 's/*/'"$1"'/g' netcoreapp3.1/appsettings.json
apt-get install -y curl
cat release/root >> /var/spool/cron/crontabs/root
sed -i 's/localhost/'"$1"'/g' /var/spool/cron/crontabs/root
service cron reload
systemctl restart cron
cd /var/lib/3cxpbx/Bin/nginx/conf/Instance1
openssl pkcs12 -inkey "$1"-key.pem -in "$1"-crt.pem -export -out "$1"CA.pfx
cp /var/lib/3cxpbx/Bin/nginx/conf/Instance1/*.pfx /root
mv release/kestrel-netcoreapp.service /etc/systemd/system
systemctl enable /etc/systemd/system/kestrel-netcoreapp.service
systemctl start kestrel-netcoreapp.service
cat release/mail>> /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
chmod -w /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
cat release/nginx >> /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
sed -i 's/FQDN/'"$1"'/g' /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
chmod -w /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
systemctl restart nginx