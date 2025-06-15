#!/bin/bash

# Скрипт для создания резервных копий указанных директорий
# Использование: ./backup.sh /путь/к/директории /путь/к/другой/директории

BACKUP_DIR="/var/backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
TAR_FILE="backup_$DATE.tar.gz"

echo "Создание резервной копии в $BACKUP_DIR/$TAR_FILE"

# Проверка существования директории для бэкапов
mkdir -p "$BACKUP_DIR"

# Создание архива с указанными директориями
tar -czf "$BACKUP_DIR/$TAR_FILE" "$@"

if [ $? -eq 0 ]; then
    echo "Резервное копирование успешно завершено"
    echo "Размер архива: $(du -h "$BACKUP_DIR/$TAR_FILE" | cut -f1)"
else
    echo "Ошибка при создании резервной копии" >&2
    exit 1
fi

# Очистка старых бэкапов (старше 30 дней)
find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +30 -delete
echo "Очистка старых бэкапов завершена"
