#!/bin/bash

# Универсальный скрипт для управления пакетами в разных дистрибутивах
# Использование: ./package_manager.sh [install|remove|update|search|list] имя_пакета

ACTION=$1
PACKAGE=$2

# Определение дистрибутива
if [ -f /etc/debian_version ]; then
    DISTRO="debian"
elif [ -f /etc/redhat-release ]; then
    DISTRO="redhat"
elif [ -f /etc/arch-release ]; then
    DISTRO="arch"
else
    DISTRO="unknown"
fi

case $ACTION in
    install)
        echo "Установка пакета $PACKAGE"
        case $DISTRO in
            debian) sudo apt-get install -y $PACKAGE ;;
            redhat) sudo yum install -y $PACKAGE ;;
            arch)   sudo pacman -S --noconfirm $PACKAGE ;;
            *)      echo "Неизвестный дистрибутив" ;;
        esac
        ;;
    remove)
        echo "Удаление пакета $PACKAGE"
        case $DISTRO in
            debian) sudo apt-get remove -y $PACKAGE ;;
            redhat) sudo yum remove -y $PACKAGE ;;
            arch)   sudo pacman -R --noconfirm $PACKAGE ;;
            *)      echo "Неизвестный дистрибутив" ;;
        esac
        ;;
    update)
        echo "Обновление пакетов"
        case $DISTRO in
            debian) sudo apt-get update && sudo apt-get upgrade -y ;;
            redhat) sudo yum update -y ;;
            arch)   sudo pacman -Syu --noconfirm ;;
            *)      echo "Неизвестный дистрибутив" ;;
        esac
        ;;
    search)
        echo "Поиск пакета $PACKAGE"
        case $DISTRO in
            debian) apt-cache search $PACKAGE ;;
            redhat) yum search $PACKAGE ;;
            arch)   pacman -Ss $PACKAGE ;;
            *)      echo "Неизвестный дистрибутив" ;;
        esac
        ;;
    list)
        echo "Список установленных пакетов"
        case $DISTRO in
            debian) dpkg --list ;;
            redhat) rpm -qa ;;
            arch)   pacman -Q ;;
            *)      echo "Неизвестный дистрибутив" ;;
        esac
        ;;
    *)
        echo "Использование: $0 [install|remove|update|search|list] имя_пакета"
        exit 1
        ;;
esac
