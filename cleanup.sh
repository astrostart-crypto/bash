#!/bin/bash

# Скрипт для очистки системы от временных файлов и кэша
# Использование: ./cleanup.sh

echo "Начинаем очистку системы..."

# Очистка кэша пакетов
if [ -f /etc/debian_version ]; then
    echo "Очистка кэша apt..."
    sudo apt-get clean
    sudo apt-get autoclean
elif [ -f /etc/redhat-release ]; then
    echo "Очистка кэша yum..."
    sudo yum clean all
elif [ -f /etc/arch-release ]; then
    echo "Очистка кэша pacman..."
    sudo pacman -Sc --noconfirm
fi

# Очистка временных файлов
echo "Очистка временных файлов..."
sudo rm -rf /tmp/*
sudo rm -rf /var/tmp/*

# Очистка старых журналов
echo "Очистка старых журналов..."
sudo journalctl --vacuum-time=7d

# Очистка кэша пользователя
echo "Очистка пользовательского кэша..."
rm -rf ~/.cache/*

# Поиск и удаление старых файлов в домашней директории
echo "Поиск файлов старше 30 дней в домашней директории..."
find ~ -type f -mtime +30 -exec ls -la {} \;
read -p "Удалить эти файлы? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    find ~ -type f -mtime +30 -delete
    echo "Файлы удалены."
fi

echo "Очистка завершена!"
