#! /bin/sh
cd /home
git clone https://github.com/KolayOde/deployment.git
mv build/appsettings.js .
rm -r build
mv deployment/build .
mv appsettings.js build
mv buildagent/appsettings.js .
rm -r buildagent
mv deployment/buildagent .
mv appsettings.js buildagent
mv deployment/Debug/netcoreapp3.1/3cx-WebApi.dll Debug/netcoreapi3.1
rm -r deployment
systemctl restart nginx
pidof dotnet | xargs kill -9