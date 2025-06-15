#!/bin/bash

# Скрипт для мониторинга сетевых соединений
# Использование: ./network_monitor.sh [интервал_в_секундах]

INTERVAL=${1:-5} # Интервал по умолчанию 5 секунд

echo "Мониторинг сетевых соединений (обновление каждые $INTERVAL секунд)"
echo "Нажмите Ctrl+C для выхода"

while true; do
    clear
    
    # Дата и время
    echo "===== $(date) ====="
    echo ""
    
    # Интерфейсы сети
    echo "### Сетевые интерфейсы ###"
    ip -br addr show
    echo ""
    
    # Статистика сети
    echo "### Сетевая статистика ###"
    netstat -s | head -n 20
    echo ""
    
    # Активные соединения
    echo "### Активные соединения ###"
    ss -tulnp
    echo ""
    
    # Трафик по интерфейсам
    echo "### Трафик по интерфейсам ###"
    ifstat -i $(ip -o link show | awk -F': ' '{print $2}' | tr '\n' ' ') $INTERVAL 1
    echo ""
    
    sleep $INTERVAL
done
