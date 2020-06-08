#!/bin/bash

# 发布脚本
### 后端代码发布
###

case $1 in
dev)
    PUSH_SSH='root@39.100.22.139'
    PUSH_ONLINE_DIST='/app/flutter_shop_base/express_node_server'
    POSTFIX_CMD="cd ${PUSH_ONLINE_DIST}; echo $(date)"
    ;;
online)
    PUSH_SSH='root@114.215.24.34'
    PUSH_ONLINE_DIST='/data/wwwroot/lepai/'
    POSTFIX_CMD="cd ${PUSH_ONLINE_DIST}; cp .env.online .env ;chmod -R 777 ./runtime; echo $(date)"
    ;;
*)
    echo "Usage: $0 {dev|online}"
    exit 4
    ;;
esac

echo $(date)
WORKDIR=$(
    cd $(dirname $0)
    pwd
)
echo -e "\033[32m 当前目： ${WORKDIR} \033[0m"
UP_WORKDIR=$(
    cd ${WORKDIR}/../
    pwd
)
echo -e "\033[32m up-path： ${UP_WORKDIR}\033[0m"
cd ${UP_WORKDIR}

DIST_PATH=${UP_WORKDIR}

EXCLUDE_FILE='--exclude node_modules/
    --exclude .git 
    --exclude ./bin
    --exclude .DS_Store'

# 发布代码
echo -e "\033[34m
执行同步命令：
rsync -avz ${DIST_PATH}/ ${EXCLUDE_FILE} ${PUSH_SSH}:${PUSH_ONLINE_DIST} 
\033[0m"

echo -e "\033[36m 同步代码开始..."
rsync -avz ${DIST_PATH}/ ${EXCLUDE_FILE} ${PUSH_SSH}:${PUSH_ONLINE_DIST}
echo -e "\033[0m"
# 更改环境

echo -e "\033[32m 环境切换-🍻...\033[0m"
ssh ${PUSH_SSH} ${POSTFIX_CMD}
