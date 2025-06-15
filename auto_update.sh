#!/bin/bash

# Скрипт для автоматического обновления системы с логированием
# Использование: ./auto_update.sh

LOG_FILE="/var/log/auto_update.log"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

echo "[$DATE] Начато автоматическое обновление системы" | tee -a "$LOG_FILE"

# Определение дистрибутива
if [ -f /etc/debian_version ]; then
    echo "Обновление Debian-based системы" | tee -a "$LOG_FILE"
    sudo apt-get update | tee -a "$LOG_FILE"
    sudo apt-get upgrade -y | tee -a "$LOG_FILE"
    sudo apt-get autoremove -y | tee -a "$LOG_FILE"
elif [ -f /etc/redhat-release ]; then
    echo "Обновление RedHat-based системы" | tee -a "$LOG_FILE"
    sudo yum update -y | tee -a "$LOG_FILE"
    sudo yum autoremove -y | tee -a "$LOG_FILE"
elif [ -f /etc/arch-release ]; then
    echo "Обновление Arch-based системы" | tee -a "$LOG_FILE"
    sudo pacman -Syu --noconfirm | tee -a "$LOG_FILE"
    sudo pacman -Rns $(pacman -Qdtq) --noconfirm 2>/dev/null | tee -a "$LOG_FILE"
else
    echo "Неизвестный дистрибутив, обновление не выполнено" | tee -a "$LOG_FILE"
    exit 1
fi

echo "[$DATE] Обновление системы завершено" | tee -a "$LOG_FILE"
