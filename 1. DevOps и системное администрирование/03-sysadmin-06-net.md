- Задание 1

Работа c HTTP через телнет.

```text
Системная информация плюс разметка страницы

Trying 151.101.193.69...
Connected to stackoverflow.com.
Escape character is '^]'.
GET /questions HTTP/1.0
HOST: stackoverflow.com

HTTP/1.1 403 Forbidden
Connection: close
Content-Length: 1920
Server: Varnish
Retry-After: 0
Content-Type: text/html
Accept-Ranges: bytes
Date: Tue, 15 Nov 2022 16:11:54 GMT
Via: 1.1 varnish
X-Served-By: cache-bma1637-BMA
X-Cache: MISS
X-Cache-Hits: 0
X-Timer: S1668528715.903224,VS0,VE1
X-DNS-Prefetch-Control: off

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Forbidden - Stack Exchange</title>
    <style type="text/css">
		body
		{
			color: #333;
			font-family: 'Helvetica Neue', Arial, sans-serif;
			font-size: 14px;
			background: #fff url('img/bg-noise.png') repeat left top;
			line-height: 1.4;
		}
		h1
		{
			font-size: 170%;
			line-height: 34px;
			font-weight: normal;
		}
		a { color: #366fb3; }
		a:visited { color: #12457c; }
		.wrapper {
			width:960px;
			margin: 100px auto;
			text-align:left;
		}
		.msg {
			float: left;
			width: 700px;
			padding-top: 18px;
			margin-left: 18px;
		}
    </style>
</head>

<body>
    <div class="wrapper">
		<div style="float: left;">
			<img src="https://cdn.sstatic.net/stackexchange/img/apple-touch-icon.png" alt="Stack Exchange" />
		</div>
		<div class="msg">
			<h1>Access Denied</h1>
                        <p>This IP address (95.161.90.108) has been blocked from access to our services. If you believe this to be in error, please contact us at <a href="mailto:team@stackexchange.com?Subject=Blocked%2095.161.90.218%20(Request%20ID%3A%202809868891-BMA)">team@stackexchange.com</a>.</p>
                        <p>When contacting us, please include the following information in the email:</p>
                        <p>Method: block</p>
                        <p>XID: 2809868891-BMA</p>
                        <p>IP: 95.161.90.108</p>
                        <p>X-Forwarded-For: </p>
                        <p>User-Agent: </p>
                        
                        <p>Time: Tue, 15 Nov 2022 16:11:54 GMT</p>
                        <p>URL: stackoverflow.com/questions</p>
                        <p>Browser Location: <span id="jslocation">(not loaded)</span></p>
		</div>
	</div>
	<script>document.getElementById('jslocation').innerHTML = window.location.href;</script>
</body>
</html>Connection closed by foreign host.
```

- Задание 2

Повторите задание 1 в браузере, используя консоль разработчика F12.

откройте вкладку Network,отправьте запрос http://stackoverflow.com
```text
перенаправило на https
```
найдите первый ответ HTTP сервера, откройте вкладку Headers, укажите в ответе полученный HTTP код
```text
Status 200 OK
```
проверьте время загрузки страницы, какой запрос обрабатывался дольше всего?
```text
первый запрос 203ms , Waiting
```
приложите скриншот консоли браузера в ответ.
```text
приложил отдельным файлом
```
- Задание 3

Какой IP адрес у вас в интернете?
```text
 95.161.90.108
```
- Задание 4 

Какому провайдеру принадлежит ваш IP адрес? Какой автономной системе AS? Воспользуйтесь утилитой whois
```text
inetnum:        95.161.64.0 - 95.161.127.255
netname:        GBLNET
country:        RU
admin-c:        MS37184-RIPE
tech-c:         MS37184-RIPE
status:         SUB-ALLOCATED PA
mnt-by:         MNT-GLOBAL-NET
mnt-by:         mnt-ag-globalnet-1
created:        2019-09-09T13:04:43Z
last-modified:  2021-08-25T14:39:07Z
source:         RIPE

person:         Mikhail Shenkman
address:        Vyborgskoe shosse 36, St.Petersburg, Russia
phone:          +79214061599
nic-hdl:        MS37184-RIPE
mnt-by:         MNT-GLOBAL-NET
created:        2015-01-27T08:25:18Z
last-modified:  2019-04-22T08:10:57Z
source:         RIPE

% Information related to '95.161.90.0/24AS42065'

route:          95.161.90.0/24
origin:         AS42065
mnt-by:         mnt-ag-globalnet-1
created:        2022-11-01T08:49:41Z
last-modified:  2022-11-01T08:49:41Z
source:         RIPE
``` 
- Задание 5

Через какие сети проходит пакет, отправленный с вашего компьютера на адрес 8.8.8.8? Через какие AS? Воспользуйтесь утилитой traceroute
```text
traceroute to 8.8.8.8 (8.8.8.8), 30 hops max, 60 byte packets
 1  _gateway (192.168.0.1)  2.789 ms  2.722 ms  3.595 ms
 2  95.161.90.209 (95.161.90.209)  5.187 ms  5.168 ms  5.442 ms
 3  * * *
 4  10.210.116.25 (10.210.116.25)  7.560 ms  7.593 ms  7.577 ms
 5  10.210.116.30 (10.210.116.30)  9.402 ms  9.447 ms  10.238 ms
 6  10.210.116.18 (10.210.116.18)  11.437 ms 10.210.116.22 (10.210.116.22)  4.940 ms  2.729 ms
 7  72.14.211.20 (72.14.211.20)  3.531 ms  3.474 ms  3.452 ms
 8  74.125.244.132 (74.125.244.132)  3.423 ms  4.187 ms 74.125.244.180 (74.125.244.180)  4.163 ms
 9  72.14.232.85 (72.14.232.85)  5.643 ms 216.239.48.163 (216.239.48.163)  8.824 ms  8.805 ms
10  142.251.61.221 (142.251.61.221)  9.673 ms 172.253.51.219 (172.253.51.219)  10.600 ms 172.253.51.239 (172.253.51.239)  8.531 ms
11  172.253.51.189 (172.253.51.189)  8.483 ms * 216.239.49.107 (216.239.49.107)  8.114 ms
12  * * *
13  * * *
14  * * *
15  * * *
16  * * *
17  * * *
18  * * *
19  * * *
20  * dns.google (8.8.8.8)  7.345 ms  7.328 ms
```    
- Задание 6

Повторите задание 5 в утилите mtr. На каком участке наибольшая задержка - delay?
```text
72.14.211.20 
```
- Задание 7

Какие DNS сервера отвечают за доменное имя dns.google? Какие A записи? Воспользуйтесь утилитой dig
```text
dns.google.		361	IN	A	8.8.4.4
dns.google.		361	IN	A	8.8.8.8

A записи
ns1.zdns.google.	1261	IN	A	216.239.32.114
ns2.zdns.google.	1261	IN	A	216.239.34.114
ns3.zdns.google.	1261	IN	A	216.239.36.114
ns4.zdns.google.	1261	IN	A	216.239.38.114
```   
- Задание 8

Проверьте PTR записи для IP адресов из задания 7. Какое доменное имя привязано к IP? Воспользуйтесь утилитой dig
```text
Адреса
114.32.239.216.in-addr.arpa. 86400 IN	PTR	ns1.zdns.google.
114.34.239.216.in-addr.arpa. 86400 IN	PTR	ns2.zdns.google.
114.36.239.216.in-addr.arpa. 86400 IN	PTR	ns3.zdns.google.
114.38.239.216.in-addr.arpa. 86400 IN	PTR	ns4.zdns.google.
Имя
zdns.google
```
