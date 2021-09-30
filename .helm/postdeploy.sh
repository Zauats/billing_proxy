#!/bin/bash

THIS=`readlink -f "${BASH_SOURCE[0]}"`
DIR=`dirname "${THIS}"`
cd $DIR

source ./def.sh

if [ "$ENVNAME" = "dev" ]; then
    API_CONT="billing-proxy-api-dev billing-proxy-api-dev-0"
    NAMESPACE="$NAMESPACE-$ENVNAME"
    echo "Ожидаем поды..."
    kubectl -n $NAMESPACE wait --for=condition=ready --timeout=120s pods billing-proxy-api-dev-0

    echo "Инициализируем поды..."
    CMD="-- /bin/bash /init-dev-env.sh "
    set -x
    kubectl -n $NAMESPACE exec -it -c $API_CONT $CMD
    set +x
    cat << EOF
    ====================
    Окружение настроено =)
    Чтобы запустить всю систему, нужно внутри пода в папке /workspace/billing_proxy/api

          npm run compile && npm start
    или /init-dev-env.sh -s
    После запуска команды, можно посылать запросы на http://billingproxy.mcn.local
    ====================
EOF
fi

