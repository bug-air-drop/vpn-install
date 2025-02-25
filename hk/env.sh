#!/usr/bin/env bash

DEBIANPLATFORM="DEBIAN"
CENTOSPLATFORM="CENTOS"

if [ -n "$(. /etc/os-release; echo $NAME | grep -i Ubuntu)" -o -n "$(. /etc/os-release; echo $NAME | grep -i Debian)" ]; then
	PLATFORM=$DEBIANPLATFORM

	IPTABLES_PACKAGE="iptables"
	CRON_PACKAGE="cron"
	PCKTMANAGER="apt-get"
	INSTALLER="$PCKTMANAGER -y install"
	UNINSTALLER="$PCKTMANAGER purge --auto-remove"
fi

if [ -n "$(. /etc/os-release; echo $NAME | grep -i CentOS)" ]; then
	PLATFORM=$CENTOSPLATFORM

	IPTABLES_PACKAGE="iptables-services"
	CRON_PACKAGE="cronie"
	PCKTMANAGER="yum"
	INSTALLER="$PCKTMANAGER -y install"
	UNINSTALLER="$PCKTMANAGER remove"
fi

SYSCTLCONFIG=/etc/sysctl.conf
IPSECCONFIG=/etc/ipsec.conf
XL2TPDCONFIG=/etc/xl2tpd/xl2tpd.conf
PPPCONFIG=/etc/ppp/options.xl2tpd
CHAPSECRETS=/etc/ppp/chap-secrets
IPTABLES=/etc/iptables.rules
SECRETSFILE=/etc/ipsec.secrets
CHECKSERVER=/etc/xl2tpd/checkserver.sh
IPTABLES_COMMENT="IPSEC"

if [ "$PLATFORM" == "$CENTOSPLATFORM" ]; then
	SECRETSFILE=/etc/strongswan/ipsec.secrets
	IPSECCONFIG=/etc/strongswan/ipsec.conf
fi

LOCALPREFIX="192.168"
LOCALIP="$LOCALPREFIX.88.0"
LOCALMASK="/24"

LOCALIPMASK="$LOCALIP$LOCALMASK"

IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vE '192\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -vE '172\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
if [[ "$IP" = "" ]]; then
	IP=$(wget -4qO- "http://whatismyip.akamai.com/")
fi


