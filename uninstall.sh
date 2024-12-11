apt-get remove packages-microsoft-prod
apt-get remove git
apt-get remove curl
apt-get remove dotnet-sdk-3.1
dpkg --purge packages-microsoft-prod
apt-get autoremove
nano /etc/apt/sources.list
rm /etc/apt/sources.list.d/microsoft-prod.list
apt-get update
ps -ef | grep dotnet
kill -9 13213
crontab -e
service cron reload
rm /etc/systemd/system/kestrel-netcoreapp.service
rm /etc/systemd/system/multi-user.target.wants/kestrel-netcoreapp.service
systemctl daemon-reload
systemctl reset-failed
rm /root/*.pfx
rm /var/lib/3cxpbx/Bin/nginx/conf/Instance1/*.pfx
nano /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
nano /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
chmod +w /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf 
systemctl restart nginx
systemctl restart nftables
