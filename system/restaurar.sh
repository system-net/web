#!/bin/bash
#---------------------------------------------------------------------
# HOSPEDADO POR @Universe_say
#----------------------------------------------------------------------
clear
crz=$(echo -e "\033[1;31m           @Universe_say\033[1;32m")
echo -ne "\033[1;32mEnter para continuar...\033[0m"; read

[[ ! -e /var/www/html/pages/system/pass.php ]] && {
	echo -e "\n\033[1;31mO PAINEL NAO ESTA INSTALADO !\033[0m"; exit 0
}

[[ ! -e $HOME/sshplus.sql ]] && {
	echo -e "\n\033[1;31mARQUIVO (\033[1;32msshplus.sql\033[1;31m) NAO ENCONTRADO !\033[0m"; exit 0
}

passdb=$(cut -d"'" -f2 /var/www/html/pages/system/pass.php)
[[ $(mysql -h localhost -u root -p$passdb -e "show databases" | grep -wc sshplus) == '0' ]] && {
	echo -e "\n\033[1;31mSEU PAINEL NAO É COMPATIVEL !\033[0m"; exit 0
}

mysql -h localhost -u root -p$passdb -e "drop database sshplus"
mysql -h localhost -u root -p$passdb -e 'CREATE DATABASE sshplus'
mysql -h localhost -u root -p$passdb --default_character_set utf8 sshplus < sshplus.sql
echo -e "\n\033[1;32mBACKUP RESTAURADO !\033[0m"
