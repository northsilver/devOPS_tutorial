1) Установите Bitwarden плагин для браузера. Зарегестрируйтесь и сохраните несколько паролей.
Ok

2) Установите Google authenticator на мобильный телефон. Настройте вход в Bitwarden акаунт через Google authenticator OTP.
Ok

3) Установите apache2, сгенерируйте самоподписанный сертификат, настройте тестовый сайт для работы по HTTPS.
ivan@ivan-ThinkPad-X395:~$ sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \-keyout /etc/ssl/private/apache-selfsigned.key \-out /etc/ssl/certs/apache-selfsigned.crt \-subj "/C=RU/ST=SPB/L=SPB/O=Company Name/OU=Org/CN=www.pupaandlupa.com"
..+.+.....+....+............+.....+.......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+.+...+..+.+...+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...+.....+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
..+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.....+....+.....+.+..............+.........+..........+....................+.+......+...+........+....+......+.....+............+.+.....+......+.+...+..+...+......+..........+.....+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*.......+............+.....+....+...+...+...+......+.....+..........+.....+.............+...+...+..+..........+...+..............+...+...+.+........+.+.........+...+..+......+.+.....+.........+.........+......+.+...........+...+..........+......+........+.+..+....+.........+..+.......+...........+......+....+............+........+......+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
ivan@ivan-ThinkPad-X395:~$ sudo vim /etc/apache2/sites-available/pupaandlupa.conf
ivan@ivan-ThinkPad-X395:~$ cat /etc/apache2/sites-available/pupaandlupa.conf 
<VirtualHost *:443>   
	ServerName www.pupaandlupa.com
	DocumentRoot /var/www/pupaandlupa   
	
	SSLEngine on   
	SSLCertificateFile /etc/ssl/certs/apache-selfsigned.crt   		
	SSLCertificateKeyFile /etc/ssl/private/apache-selfsigned.key
</VirtualHost>
ivan@ivan-ThinkPad-X395:~$ sudo mkdir /var/www/pupaandlupa
ivan@ivan-ThinkPad-X395:~$ sudo vim /var/www/pupaandlupa/index.html
ivan@ivan-ThinkPad-X395:~$ sudo a2ensite pupaandlupa.conf
Enabling site pupaandlupa.
To activate the new configuration, you need to run:
  systemctl reload apache2
ivan@ivan-ThinkPad-X395:~$ sudo apache2ctl configtest
AH00558: apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1. Set the 'ServerName' directive globally to suppress this message
Syntax OK
ivan@ivan-ThinkPad-X395:~$ sudo systemctl reload apache2
ivan@ivan-ThinkPad-X395:~$ cat /etc/hosts
127.0.0.1	localhost
127.0.1.1	ivan-ThinkPad-X395
127.0.0.2	www.pupaandlupa.com

Скриншот сайта и сертификата приложил

4) Проверьте на TLS уязвимости произвольный сайт в интернете (кроме сайтов МВД, ФСБ, МинОбр, НацБанк, РосКосмос, РосАтом, РосНАНО и любых госкомпаний, объектов КИИ, ВПК ... и тому подобное).
ivan@ivan-ThinkPad-X395:~/testssl.sh$ ./testssl.sh -U --sneaky https://www.mvideo.ru/

###########################################################
    testssl.sh       3.2rc2 from https://testssl.sh/dev/
    (198bb09 2022-11-28 17:09:04)

      This program is free software. Distribution and
             modification under GPLv2 permitted.
      USAGE w/o ANY WARRANTY. USE IT AT YOUR OWN RISK!

       Please file bugs @ https://testssl.sh/bugs/

###########################################################

 Using "OpenSSL 1.0.2-bad (1.0.2k-dev)" [~179 ciphers]
 on ivan-ThinkPad-X395:./bin/openssl.Linux.x86_64
 (built: "Sep  1 14:03:44 2022", platform: "linux-x86_64")


 Start 2022-11-29 17:57:17        -->> 185.71.67.88:443 (www.mvideo.ru) <<--

 rDNS (185.71.67.88):    --
 Service detected:       HTTP


 Testing vulnerabilities 

 Heartbleed (CVE-2014-0160)                not vulnerable (OK), no heartbeat extension
 CCS (CVE-2014-0224)                       not vulnerable (OK)
 Ticketbleed (CVE-2016-9244), experiment.  not vulnerable (OK)
 ROBOT                                     not vulnerable (OK)
 Secure Renegotiation (RFC 5746)           supported (OK)
 Secure Client-Initiated Renegotiation     not vulnerable (OK)
 CRIME, TLS (CVE-2012-4929)                not vulnerable (OK)
 BREACH (CVE-2013-3587)                    potentially NOT ok, "gzip" HTTP compression detected. - only supplied "/" tested
                                           Can be ignored for static pages or if no secrets in the page
 POODLE, SSL (CVE-2014-3566)               not vulnerable (OK)
 TLS_FALLBACK_SCSV (RFC 7507)              Downgrade attack prevention supported (OK)
 SWEET32 (CVE-2016-2183, CVE-2016-6329)    not vulnerable (OK)
 FREAK (CVE-2015-0204)                     not vulnerable (OK)
 DROWN (CVE-2016-0800, CVE-2016-0703)      not vulnerable on this host and port (OK)
                                           make sure you don't use this certificate elsewhere with SSLv2 enabled services, see
                                           https://search.censys.io/search?resource=hosts&virtual_hosts=INCLUDE&q=D8B80C48F77887A162883E4CF8001F9CA6632578E8A681A8F017E88F35999891
 LOGJAM (CVE-2015-4000), experimental      not vulnerable (OK): no DH EXPORT ciphers, no DH key detected with <= TLS 1.2
 BEAST (CVE-2011-3389)                     not vulnerable (OK), no SSL3 or TLS1
 LUCKY13 (CVE-2013-0169), experimental     potentially VULNERABLE, uses cipher block chaining (CBC) ciphers with TLS. Check patches
 Winshock (CVE-2014-6321), experimental    not vulnerable (OK)
 RC4 (CVE-2013-2566, CVE-2015-2808)        no RC4 ciphers detected (OK)


5) Установите на Ubuntu ssh сервер, сгенерируйте новый приватный ключ. Скопируйте свой публичный ключ на другой сервер. Подключитесь к серверу по SSH-ключу.
Воспользовался варгантом от предыдущих лаб, заранее еще поменял порт на 55555

vagrant@sysadm-fs:~$ ssh-keygen 
Generating public/private rsa key pair.
vagrant@sysadm-fs:~$ ssh-copy-id ivan@192.168.0.108
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: ERROR: ssh: connect to host 192.168.0.108 port 22: Connection refused
vagrant@sysadm-fs:~$ ssh-copy-id -p 55555 ivan@192.168.0.108
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/vagrant/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
ivan@192.168.0.108's password:
Number of key(s) added: 1
Now try logging into the machine, with:   "ssh -p '55555' 'ivan@192.168.0.108'"
and check to make sure that only the key(s) you wanted were added.
vagrant@sysadm-fs:~$ ssh -p 55555 ivan@192.168.0.108
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

96 updates can be applied immediately.
42 of these updates are standard security updates.
To see these additional updates run: apt list --upgradable

Last login: Tue Nov 29 19:30:10 2022 from 192.168.0.108

6) Переименуйте файлы ключей из задания 5. Настройте файл конфигурации SSH клиента, так чтобы вход на удаленный сервер осуществлялся по имени сервера.
Добавил в хосты информацию о хосте
vagrant@sysadm-fs:~$ cat /etc/hosts
127.0.0.1 localhost
127.0.1.1 vagrant
192.168.0.108 super_pc

Вход прошел успешно
vagrant@sysadm-fs:~$ ssh -p 55555 ivan@super_pc
Welcome to Ubuntu 22.04.1 LTS (GNU/Linux 5.15.0-52-generic x86_64)

7) Соберите дамп трафика утилитой tcpdump в формате pcap, 100 пакетов. Откройте файл pcap в Wireshark.
sudo tcpdump -w test1.pcap -c 100 -i wlp1s0
скриншот приложил
