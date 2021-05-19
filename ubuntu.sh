export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(wget -qO- ipv4.icanhazip.com);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID
country=ID
state=Aceh
locality=Takengon
organization=HzroSSH
organizationalunit=HzroSSH
commonname=hzrossh.site
email=admin@hzrossh.site
wget -O /etc/pam.d/common-password "https://hzr-iptv.my.id/ssh/password"
chmod +x /etc/pam.d/common-password
cd
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cat > /etc/rc.local <<-END
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 0 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
sh -c 'echo "deb http://download.webmin.com/download/repository sarge contrib" > /etc/apt/sources.list.d/webmin.list'
wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc
sudo apt update -y
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt -y install wget curl
sudo apt -y autoremove
sudo apt -y autoclean
sudo apt -y clean
sudo apt -y remove --purge unscd
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config
sudo apt -y install gcc
sudo apt -y install make
sudo apt -y install cmake
sudo apt -y install git
sudo apt -y install screen
sudo apt -y install unzip
sudo apt -y install curl
sudo apt -y install zlib1g-dev
sudo apt -y install bzip2
sudo apt -y install neofetch
echo "clear" >> .profile
echo "neofetch" >> .profile
echo "echo by Horasss" >> .profile
sudo apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://hzr-iptv.my.id/ssh/nginx.conf"
mkdir -p /home/vps/public_html
echo "<pre>Setup by Horasss</pre>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://hzr-iptv.my.id/ssh/vps.conf"
/etc/init.d/nginx restart
cd
wget -O /usr/bin/badvpn-udpgw "https://hzr-iptv.my.id/ssh/badvpn-udpgw64"
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000' /etc/rc.local
chmod +x /usr/bin/badvpn-udpgw
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
sed -i 's/Port 22/Port 22/g' /etc/ssh/sshd_config
sudo apt -y install dropbear
sed -i 's/NO_START=1/NO_START=0/g' /etc/default/dropbear
sed -i 's/DROPBEAR_PORT=22/DROPBEAR_PORT=143/g' /etc/default/dropbear
sed -i 's/DROPBEAR_EXTRA_ARGS=/DROPBEAR_EXTRA_ARGS="-p 110 -p 109 -p 456"/g' /etc/default/dropbear
wget https://matt.ucc.asn.au/dropbear/releases/dropbear-2020.80.tar.bz2
bzip2 -cd dropbear-2020.80.tar.bz2 | tar xvf -
cd dropbear-2020.80
./configure
make && make install
mv /usr/sbin/dropbear /usr/sbin/dropbear.old
ln /usr/local/sbin/dropbear /usr/sbin/dropbear
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
/etc/init.d/dropbear restart
rm -f /root/dropbear-2020.80.tar.bz2
rm -rf /root/dropbear-2020.80
cd
sudo apt -y install squid3
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/nuubiecoding/kooookzxzl/main/squid.conf"
sed -i $MYIP2 /etc/squid/squid.conf
sudo apt -y install vnstat
/etc/init.d/vnstat restart
sudo apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install
cd
vnstat -u -i $NET
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz
rm -rf /root/vnstat-2.6
sudo apt install webmin -y
sed -i 's/ssl=1/ssl=0/g' /etc/webmin/miniserv.conf
/etc/init.d/webmin restart
sudo apt install stunnel4 -y
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1
[dropbear]
accept = 443
connect = 127.0.0.1:109
[dropbear]
accept = 777
connect = 127.0.0.1:22
[dropbear]
accept = 222
connect = 127.0.0.1:22
[dropbear]
accept = 990
connect = 127.0.0.1:109
[openvpn]
accept = 442
connect = 127.0.0.1:1194
END
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart
wget https://auto.serverssh.my.id/ssh/vpn.sh && chmod +x vpn.sh && ./vpn.sh
sudo apt -y install fail2ban
if [ -d '/usr/local/ddos' ]; then
echo; echo; echo "Please un-install the previous version first"
exit 0
else
mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'
cd
sudo apt install -y libxml-parser-perl
wget -O /etc/issue.net "https://hzr-iptv.my.id/ssh/issue.net"
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear
cd /usr/bin
if [[ $ver == '16.04' ]]; then
wget https://aboutstores.net/Ubnt/about16.sh &&  chmod +x about16.sh &&  ./about16.sh
elif [[ $ver == '18.04' ]]; then
wget https://aboutstores.net/Ubnt/about18.sh &&  chmod +x about18.sh && ./about18.sh
elif [[ $ver == '20.04' ]]; then
wget https://aboutstores.net/Ubnt/about20.sh &&  chmod +x about20.sh && ./about20.sh
fi
wget -O menu "https://hzr-iptv.my.id/ssh/menu.sh"
wget -O usernew "https://hzr-iptv.my.id/ssh/usernew.sh"
wget -O trial "https://hzr-iptv.my.id/ssh/trial.sh"
wget -O hapus "https://hzr-iptv.my.id/ssh/hapus.sh"
wget -O member "https://hzr-iptv.my.id/ssh/member.sh"
wget -O delete "https://hzr-iptv.my.id/ssh/delete.sh"
wget -O cek "https://hzr-iptv.my.id/ssh/cek.sh"
wget -O restart "https://hzr-iptv.my.id/ssh/restart.sh"
wget -O speedtest "https://hzr-iptv.my.id/ssh/speedtest_cli.py"
wget -O info "https://hzr-iptv.my.id/ssh/info.sh"
wget -O renew "https://vpnstores.net/Korlo/renew.sh"
wget -O limit "https://hzr-iptv.my.id/ssh/user-limit.sh"
echo "0 5 * * * root reboot" >> /etc/crontab
chmod +x menu
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x cek
chmod +x restart
chmod +x speedtest
chmod +x info
chmod +x about
chmod +x renew
chmod +x limit
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
/etc/init.d/vnstat restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 1000
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 1000
history -c
echo "unset HISTFILE" >> /etc/profile
cd
rm -f /root/ssh-vpn.sh
clear
neofetch
netstat -nutlp
