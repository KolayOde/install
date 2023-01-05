#! /bin/sh
cd /home
wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb
dpkg --install packages-microsoft-prod.deb
apt-get update
apt-get install -y dotnet-sdk-3.1
echo deb http://deb.debian.org/debian/ buster main >> /etc/apt/sources.list
apt-get install -y git
git clone https://github.com/KolayOde/deployment.git
mv deployment/* .
rm -r deployment
apt-get install -y curl
cat Release/root >> /var/spool/cron/crontabs/root
service cron reload
systemctl restart cron
mv Release/kestrel-netcoreapp.service /etc/systemd/system
systemctl enable /etc/systemd/system/kestrel-netcoreapp.service
systemctl start kestrel-netcoreapp.service
cat Release/mail.txt >> /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
chmod -w /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
tail -n 25 Release/nginx.conf >> /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
chmod -w /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
systemctl restart nginx
rm -r Release
