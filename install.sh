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
sed -i 's/IP/'"`hostname -fqdn`"'/g' build/appsettings.js
sed -i 's/IP/'"`hostname -fqdn`"'/g' buildagent/appsettings.js
apt-get install -y curl
cat release/root >> /var/spool/cron/crontabs/root
sed -i 's/localhost/'"`hostname -fqdn`"'/g' /var/spool/cron/crontabs/root
service cron reload
systemctl restart cron
mv release/kestrel-netcoreapp.service /etc/systemd/system
systemctl enable /etc/systemd/system/kestrel-netcoreapp.service
systemctl start kestrel-netcoreapp.service
cat release/mail>> /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
chmod -w /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
cat release/nginx >> /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
chmod -w /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
systemctl restart nginx