#!/bin/bash

debootstrap \
    --include ncurses-term,locales,nano,gawk,lsb-release,acl,perl-modules-5.28 \
    --components=main,contrib,non-free 1.7_x86-64 \
    $1 \
    http://dl.astralinux.ru/astra/stable/1.7_x86-64/repository-main
