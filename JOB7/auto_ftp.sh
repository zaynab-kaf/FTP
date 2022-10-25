apt update -y && apt upgrade
apt-get install sudo

#instalation des paquets FTP
sudo apt install proftpd-* -y

#On créer un groupe FTP
addgroup ftpgroup

#On créer des utilisateurs
echo -e "kalimac\nkalimac\nmerry\n\n\n\n\n" | adduser --home /home/merry --shell /bin/false merry
echo -e "secondbreakfast\nsecondbreakfast\npippin\n\n\n\n\n" | adduser --home /home/pippin --shell /bin/false pippin

#On ajoute les users au groupe FTP
adduser merry ftpgroup
adduser pippin ftpgroup

#création d'un dossier ssl
mkdir -p /etc/proftpd/ssl

#création d'une clée SSL
echo -ne "\n\n\n\n\n\n\n" | openssl req -x509 -nodes -days 365 -newkey rsa:4096 -out /etc/proftpd/ssl/proftpd-rsa.pem -keyout /etc/proftpd/ssl/proftpd-key.pem

#avec la commande sed, on va modifier les fichiers de configurations ;
sed -i -e "s@#include /etc/proftpd/tls.conf@Include /etc/proftpd/tls.conf@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   User ftp@User ftp@" /etc/proftpd/proftpd.conf 
sed -i -e "s@# <Anonymous ~ftp>@<Anonymous ~ftp>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   Group nogroup@Group nogroup@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   useralias anonymous ftp@UserAlias anonymous ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   DirFakeUser on ftp@DirFakeUser on ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   DirFakeGroup on ftp@DirfakeGroup on ftp@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   RequireValidShell off@RequiredValidShell off@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   MaxClients 10@MaxClients 10@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   Displaylogin welcome.msg@Displaylogin welcome.msg@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   DisplayChdir .message@DisplayChdir .message@" /etc/proftpd/proftpd.conf
sed -l -e "s@#   <Directory *>@" /etc/proftpd/proftpd.conf 
sed -i -e "s@#     <Limit WRITE>@<Limit WRITE>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#       DenyAll@DenyAll@" /etc/proftpd/proftpd.conf
sed -i -e "s@#     </Limit>@</Limit>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#   </Directory>@</Directory>@" /etc/proftpd/proftpd.conf
sed -i -e "s@# </Anonymous>@</Anonymous>@" /etc/proftpd/proftpd.conf
sed -i -e "s@#TLSEngine                                on/\TLSEngine                             on/" /etc/proftpd/tls.conf
sed -i -e "s@#TLSLog                                   /var/log/proftpd/tls.log@TLSLog    /var/log/proftpd/tls.log@" /etc/proftpd/tls.conf
sed -i -e "s@#TLSProtocol                              SSLV23@TLSProtocol                         SSLV23@" /etc/proftpd/tls.conf
sed -l -e "s@#TLSRSACertificateFile                      /etc/ssl/certs/proftpdt.crt/\TLSRSACertificateFile                                   /etc/ssl/certs/proftpd.crt@" /etc/proftpd/tls.conf
sed -l -e "s@TLSVerifyCl6ient                           off@TLSVerifyClient                      off@" /etc/proftpd/tls.conf
sed -i -e "s@#TLSRequired                               on@TLSRequired                           on@" /etc/proftpd/tls.conf

sudo service proftpd restart
