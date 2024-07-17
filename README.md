# virtualization
## **Репозиторий  с  заданием  для  курса  "Основы  виртуализации"**

> *Цель работы – создать контейнер с веб-приложением.*
> *Основой контейнера является Astra Linux*

## Ход работы:

 1.  Получить файловую систему AL 1.7.0. через debootstrap
 2.  Обновиться до версии 1.7.5
 3.  Создать образ Docker
 4.  Запустить Hello-world на Flask
 
### 1. Загрузка ФС.
 
Загрузить ФС можно с помощью скрипта al_debootstrap.sh указав целевую директорию

```sh
$ sudo sh al_debootstrap.sh [path/to/fs]
```
 
```sh
#!/bin/bash

debootstrap \
    --include ncurses-term,locales,nano,gawk,lsb-release,acl,perl-modules-5.28 \
    --components=main,contrib,non-free 1.7_x86-64 \
    $1 \
    http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-main
```
### 2. Обновляемся.

Переключившись в нашу ФС с помощью chroot – видим версию 1.7.0

```sh
$ sudo chroot [path/to/fs]
#/ cat /etc/astra/build_version
>>1.7.0
```
Для обновления нашей Астры необходимо прописать репозитории для версии 1.7.5

```sh
#/ vim /etc/apt/sources.list
```
Список репозиториев:

```
deb https://download.astralinux.ru/astra/stable/1.7_x86-64/repository-main/ 1.7_x86-64 main contrib non-free  
deb http://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.5/repository-update/ 1.7_x86-64 main contrib non-free
deb https://dl.astralinux.ru/astra/frozen/1.7_x86-64/1.7.5/repository-base/ 1.7_x86-64 main contrib non-free
```

После сохранения файла обновимся и установим необходимые зависимости.

```sh
$ apt install ca-certificates 
$ apt update
$ apt dist-upgrade
```

Обновившись, проверяем версию

```sh
#/ cat /etc/astra/build_version
>>1.7.5.9 // Успех!
```

### 3. Собираем docker image

Сборка образа для docker выполняется по скрипту 

```sh
$sudo sh dockerimport.sh [path/to/fs] [name:tag]
```

По результату работы скрипта, можем видеть образ с помощью

```sh
$ docker images
```

### 4. Запускаем Hello-World

Для запуска нашего веб приложения необходимо сперва собрать контейнер.

```sh
$ docker build -t flask-hello-world . 
// docker видит наш dockerfile и проводит сборку, устанавливая нужные зависимости
// Запуск контейнера
$ docker run -p 5000:5000 flask-hello-world
```

В итоге, в веб браузере по адресу localhost:5000 отобразится замечательная надпись:

> Hello, World!
---


> P.S.
> В инструкции нет ряда описаний настройки самой астры, например установки локалей.
> Работа проводилась на виртуальной машине с ОС AL 1.7.5
> При необходимости, могу предоставить выгруженный docker образ AL в архиве .tar
> В рамках эксперимента, образ был загружен в docker на другом компьютере и проверена работа нашего веб-приложения
