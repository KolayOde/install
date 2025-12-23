#! /bin/sh
cd /home
echo deb http://deb.debian.org/debian/ bookworm main >> /etc/apt/sources.list
wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb
dpkg --install packages-microsoft-prod.deb
apt-get update
apt-get install -y dotnet-sdk-8.0
apt-get install -y git
git clone https://github.com/KolayOde/deployment.git
mv deployment/* .
rm -r deployment
sed -i 's/IP/'"$1"'/g' build/appsettings.js
sed -i 's/IP/'"$1"'/g' buildagent/appsettings.js
sed -i 's/*/'"$1"'/g' net8.0/appsettings.json
apt-get install -y curl
cat release/root >> /var/spool/cron/crontabs/root
sed -i 's/localhost/'"$1"'/g' /var/spool/cron/crontabs/root
service cron reload
systemctl restart cron
cd /var/lib/3cxpbx/Bin/nginx/conf/Instance1
openssl pkcs12 -inkey domain_key_"$1".pem -in domain_cert_"$1".pem -export -out "$1"-CA.pfx -keypbe NONE -certpbe NONE -passout pass:
cp /var/lib/3cxpbx/Bin/nginx/conf/Instance1/*.pfx /root
cd /home
mv release/kestrel.service /etc/systemd/system
systemctl enable /etc/systemd/system/kestrel.service
systemctl start kestrel.service
cat release/mail>> /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
chmod -w /var/lib/3cxpbx/Bin/3CXPhoneSystem.ini
cat release/nginx >> /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
sed -i 's/FQDN/'"$1"'/g' /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
chmod -w /var/lib/3cxpbx/Bin/nginx/conf/nginx.conf
systemctl restart nginx
sed -i '95s/peer/trust/2' /etc/postgresql/15/main/pg_hba.conf
systemctl restart postgresql
export PGPASSWORD='password'
psql -d database_single -U phonesystem -a -f /home/release/v20.sql
systemctl restart kestrel
sed -i 's/443,/443,3000,3005,/g' /var/lib/3cxpbx/Bin/nftables.conf
nft list ruleset
