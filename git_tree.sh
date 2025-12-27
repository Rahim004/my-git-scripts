#!/bin/bash
# Простой скрипт для просмотра Git-дерева

if [ $# -eq 0 ]; then
    echo "Укажите папку с проектом!"
    echo "Пример: ./git_tree.sh /home/user/myproject"
    exit 1
fi

PROJECT_DIR="$1"
command -v git >/dev/null 2>&1 || { echo "ОШИБКА: Git не установлен!"; exit 1; }

# Проверяем, существует ли папка
if [ ! -d "$PROJECT_DIR" ]; then
    echo "ОШИБКА: Папка '$PROJECT_DIR' не найдена!"
    exit 1
fi

# Проверяем, есть ли Git-репозиторий
if [ ! -d "$PROJECT_DIR/.git" ]; then
    echo "В этой папке нет Git-репозитория!"
    echo "Нужно сначала создать: git init"
    exit 1
fi

echo "✅ Найден Git-репозиторий в: $PROJECT_DIR"
echo ""

# Переходим в папку проекта
cd "$PROJECT_DIR"

echo "🌳 ДЕРЕВО КОММИТОВ:"
echo "=================="
git log --oneline --graph --all --decorate --color=always | head -n ${2:-20}

echo ""
echo "📌 ВЕТКИ:"
echo "========="
git branch -a

echo ""
echo "📍 ТЕКУЩАЯ ВЕТКА:"
git branch --show-current
