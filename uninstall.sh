apt-get remove packages-microsoft-prod
apt-get remove git
apt-get remove curl
apt-get remove dotnet-sdk-3.1
dpkg --purge packages-microsoft-prod
apt-get autoremove
ps -ef | grep dotnet
kill -9 13213
crontab -e
service cron reload
rm /etc/systemd/system/kestrel-netcoreapp.service
rm /etc/systemd/system/multi-user.target.wants/kestrel-netcoreapp.service
systemctl daemon-reload
rm /root/*.pfx
rm /var/lib/3cx/Bin/nginx/conf/Instance1/*.pfx
chmod +w /var/lib/3cx/Bin/nginx/conf/nginx.conf 
systemctl restart nginx
systemctl restart nftables
