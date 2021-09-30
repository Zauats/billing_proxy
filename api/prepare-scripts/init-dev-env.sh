set -e

DIR=/workspace
cd $DIR

readonly COMMENTS=(
    '1. Клонирование репозитория'
    '2. Установка модулей nodejs'
    '3. Сборка nodejs проекта'
    '4. Запуск сервиса'
    'use -s|--start to start server'
)

echo ${COMMENTS[0]} && [ ! -d billing_proxy ] &&
    git clone git@github.com:welltime/billing_proxy.git

[ -d billing_proxy ] && cd $DIR/billing_proxy/api &&
    echo ${COMMENTS[1]} && npm ci &&
    echo ${COMMENTS[2]} && npm run compile

[[ " $@ " =~ " --start " || " $@ " =~ " -s " ]] &&
    (echo ${COMMENTS[3]} && npm run start) ||
    echo ${COMMENTS[4]}