if [ "${EUID}" -ne 0 ]; then
echo "You need to run this script as root"
exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
echo "OpenVZ is not supported"
exit 1
fi
red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
MYIP=$(wget -qO- icanhazip.com)
if [ -f "/etc/v2ray/domain" ]; then
echo "Script Already Installed"
exit 0
fi
mkdir /var/lib/premium-script
echo "IP=" >>/var/lib/premium-script/ipvps.conf
wget https://raw.githubusercontent.com/nuubiecoding/kooookzxzl/main/cf.sh && chmod +x cf.sh && ./cf.sh
wget http://hzr-iptv.my.id/ins-vt.sh && chmod +x ins-vt.sh && screen -S v2ray ./ins-vt.sh
rm -f /root/ins-vt.sh
history -c
echo "1.2" >/home/ver
clear
rm -f setup.sh
reboot
