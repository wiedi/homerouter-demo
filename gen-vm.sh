set -o errexit

BASE64="c6a275e4-c730-11e8-8c5f-9b24fe560a8f"
DOMAIN="f.fruky.net"
DNS1="192.168.10.53"
DNS2="2a01:138:a015:10::53"
RAM=512
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
MAIL_ADMINADDR="sw@core.io"
MAIL_SMARTHOST="mx.mail.core.io"
MUNIN_MASTER_ALLOW="192.168.15.60"

if [ $# -ne 1 ]; then
	echo "${0} [alias]"
	echo
	exit 0
fi
 
alias=${1}

if [ ! -e vms/$alias/template.json ]; then
	echo "no template for vm"
	exit 1
fi

(sed -e "s;__BASE64__;$BASE64;g" \
	-e "s;__ALIAS__;$alias;g" \
	-e "s;__DOMAIN__;$DOMAIN;g" \
	-e "s;__DNS1__;$DNS1;g" \
	-e "s;__DNS2__;$DNS2;g" \
	-e "s;__RAM__;$RAM;g" \
	-e "s;__ROOT_AUTHORIZED_KEYS__;$SSH_KEY;g" \
	-e "s;__MAIL_ADMINADDR__;$MAIL_ADMINADDR;g" \
	-e "s;__MAIL_SMARTHOST__;$MAIL_SMARTHOST;g" \
	-e "s;__MUNIN_MASTER_ALLOW__;$MUNIN_MASTER_ALLOW;g" \
	< base.json; cat vms/$alias/template.json) | jq -s add
