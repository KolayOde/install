#! /bin/sh
cd /home
mv build buildx
mv buildagent buildagentx
git clone https://github.com/KolayOde/deployment.git
mv deployment/build .
mv deployment/buildagent .
cp buildx/appsettings.js build
cp buildagentx/appsettings.js buildagent
mv netcoreapp3.1/3cx-WebApi.dll netcoreapp3.1/3cx-WebApix.dll
mv deployment/netcoreapp3.1/3cx-WebApi.dll netcoreapp3.1
rm -r deployment
pidof dotnet | xargs kill -9

