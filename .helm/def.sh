# ENVNAME 
#   prod - конфигурация "Продакшин", приложение смотрит на боевой сервер.
#   dev* - конфигурация для разработки, запускаются база и пгадмин 

export TAG=1.277
export APPNAME=billing-proxy
export NAMESPACE=billing-proxy

function dev()
{
    export MINIKUBE_IP=`minikube ip`
    export ENVNAME=dev
    export CI_URL=billingproxy.mcn.local
}

function prod()
{
    export ENVNAME=prod
    export CI_URL=billingproxy.mcn.ru
}

