- Задание 1  
Найдите полный хеш и комментарий коммита, хеш которого начинается на aefea.
```text 
git show aefea

commit aefead2207ef7e2aa5dc81a34aedf0cad4c32545
Author: Alisdair McDiarmid <alisdair@users.noreply.github.com>
Date:   Thu Jun 18 10:29:58 2020 -0400

    Update CHANGELOG.md
```

- Задание 2

Какому тегу соответствует коммит 85024d3?
```text 
git describe --exact-match 85024d3

v0.12.23
```
- Задание 3

Сколько родителей у коммита b8d720? Напишите их хеши.
```text
git show b8d720^

commit 56cd7859e05c36c06b56d013b55a252d0bb7e158
Merge: 58dcac4b79 ffbcf55817
Author: Chris Griggs <cgriggs@hashicorp.com>
Date:   Mon Jan 13 13:19:09 2020 -0800

    Merge pull request #23857 from hashicorp/cgriggs01-stable
```
- Задание 4

Перечислите хеши и комментарии всех коммитов которые были сделаны между тегами v0.12.23 и v0.12.24.
```text
git log --oneline v0.12.24 -11

33ff1c03bb (tag: v0.12.24) v0.12.24
b14b74c493 [Website] vmc provider links
3f235065b9 Update CHANGELOG.md
6ae64e247b registry: Fix panic when server is unreachable
5c619ca1ba website: Remove links to the getting started guides old location
06275647e2 Update CHANGELOG.md
d5f9411f51 command: Fix bug when using terraform login on Windows
4b6d06cc5d Update CHANGELOG.md
dd01a35078 Update CHANGELOG.md
225466bc3e Cleanup after v0.12.23 release
85024d3100 (tag: v0.12.23) v0.12.23
```
- Задание 5

Найдите коммит в котором была создана функция func providerSource, ее определение в коде выглядит так func providerSource(...) (вместо троеточего перечислены аргументы).
```text
git log -S "func providerSource"

commit 8c928e83589d90a031f811fae52a81be7153e82f
Author: Martin Atkins <mart@degeneration.co.uk>
Date:   Thu Apr 2 18:04:39 2020 -0700

    main: Consult local directories as potential mirrors of providers
```

- Задание 6

Найдите все коммиты в которых была изменена функция globalPluginDirs.
```text
git grep "globalPluginDirs"
git log -L :globalPluginDirs:plugins.go

commit 78b12205587fe839f10d946ea3fdc06719decb05
commit 52dbf94834cb970b510f2fba853a5b49ad9b1a46
commit 41ab0aef7a0fe030e84018973a64135b11abcd70
```
- Задание 7

Кто автор функции synchronizedWriters?
```text
git log -S"func synchronizedWriters(" --pretty=format:’%h,%an,%ad,%s’

’5ac311e2a9,Martin Atkins,Wed May 3 16:25:41 2017 -0700,main: synchronize writes to VT100-faker on Windows’
```