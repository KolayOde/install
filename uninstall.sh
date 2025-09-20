apt-get remove -y packages-microsoft-prod
apt-get remove -y dotnet-sdk-3.1
apt-get remove git
apt-get remove curl
dpkg --purge packages-microsoft-prod
apt-get autoremove
nano /etc/apt/sources.list
rm /etc/apt/sources.list.d/microsoft-prod.list
apt-get update
kill $(ps aux | grep 'dotnet' | awk '{print $2}')
rm /var/spool/cron/root
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
sed -i '95s/md5/peer/g' /etc/postgresql/15/main/pg_hba.conf
sed -i 's/443,3000,3005,/443,/g' /var/lib/3cxpbx/Bin/nftables.conf
nft list ruleset
systemctl restart postgresql 
systemctl restart nginx
systemctl restart nftables
