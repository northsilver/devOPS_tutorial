- Задание 1

```text
echo $c
a+b = выводит, а и б, но это не переменные, а просто текст, которые были ранее объявлены
echo $d
1+2 = подставляет значение переменных, но не выполняет действий, т.к. по умолчанию это строка
echo $e
3 = выполняет арифметические действия сложения ранее объявленных переменных
```
- Задание 2

В первой строке не было закрывающей скобки

Добавил проверку на успешное выполнение, чтобы выйти из цикла

```bash
while ((1==1))
do
	curl https://localhost:4757
	if (($? != 0))
	then
		date >> curl.log
	else exit
	fi
done
```
- Задание 3
```bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
timeout=5
for i in {1..5}
do
date >>hosts.log
    for h in ${hosts[@]}
    do
	curl -I -s --connect-timeout $timeout $h:80 >/dev/null
        echo "Checking =" $h "Failed requests =" $? >>hosts.log
    done
done
```
- Задание 4
```bash
hosts=(192.168.0.1 173.194.222.113 87.250.250.242)
timeout=5
req=0
while (($req == 0))
do
    for h in ${hosts[@]}
    do
	curl -I -s --connect-timeout $timeout $h:80 >/dev/null
	req=$?
	if (($req != 0))
	then
	    echo "Error for =" $h status=$req >>hosts.log
	fi
    done
done
```