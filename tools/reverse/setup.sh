#!/bin/bash
apktool_version='2.4.1'
mitmproxy_version='5.0.1'

sudo apt install -y openssl
sudo apt install -y default-jre
sudo apt install -y default-jdk
sudo apt install -y zipalign
sudo apt install -y adb
sudo apt install -y wget

wget 'https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool'
chmod +x ./apktool
wget "https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_$apktool_version.jar"
mv apktool_2.4.1.jar apktool.jar

wget "https://snapshots.mitmproxy.org/$mitmproxy_version/mitmproxy-$mitmproxy_version-linux.tar.gz"

mkdir -p 'mitmproxy'

tar -zxvf "mitmproxy-$mitmproxy_version-linux.tar.gz" -C mitmproxy/
rm -f "mitmproxy-$mitmproxy_version-linux.tar.gz"

cat aliases.sh >> ~/.bash_aliases
source ~/.bashrc

keytool -genkey -v -keystore bi.keystore -alias bi -keyalg RSA -keysize 2048 -validity 10000
