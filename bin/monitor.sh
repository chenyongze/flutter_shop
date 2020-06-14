#!/bin/bash
# author:anson
# toutiao:code日志
# time: 2020-3-4

hostName="测试服务器"                                                               # app名称
dingdingKeyword="服务器告警"                                                        # 钉钉机器人关键词
accessToken="fe6bdcc67e1cc5cffffe903c27ad7eead40f990dba631a1a4adb19c24690fb1b" # 钉钉token
diskThreshold=85                                                               # 磁盘使用百分比阈值
cpuThreshold=98                                                                # CPU使用百分比阈值
memThreshold=85                                                                # 内存使用百分比阈值

# https://oapi.dingtalk.com/robot/send?access_token=fe6bdcc67e1cc5cffffe903c27ad7eead40f990dba631a1a4adb19c24690fb1b
# 发送钉钉消息
function SendDingDing() {
    if [ $2 -eq 1 ]; then
        content=$(echo "[$dingdingKeyword][$hostName] A 磁盘告警! 磁盘已使用: $1%, 请尽快处理！")
    elif [ $2 -eq 2 ]; then
        content=$(echo "[$dingdingKeyword][$hostName] A CPU告警! CPU已使用: $1%, 请尽快处理！")
    elif [ $2 -eq 3 ]; then
        content=$(echo "[$dingdingKeyword][$hostName] A 内存告警! 内存已使用: $1%, 请尽快处理！")
    fi
    echo $content
    apiurl="https://oapi.dingtalk.com/robot/send?access_token=$accessToken"
    curl $apiurl -X POST -H "Content-Type: application/json" -d "{\"msgtype\": \"text\",\"text\": {\"content\": \"$content\"}}"
}

# 磁盘
for d in $(df -P | grep /dev | awk '{print $5}' | sed 's/%//g'); do
    if [ $d -gt $diskThreshold ]; then
        SendDingDing $d 1
    fi
done

# cpu
usedCpuP=$(top -b -n 2 -d 0.02 | grep Cpu | tail -n 1 | awk '{print $2}' | cut -f 1 -d "%" | sed "s/\..*//g")
if [ $usedCpuP -gt $cpuThreshold ]; then
    SendDingDing $usedCpuP 2
fi

# 内存
usedMemP=$(free | awk '/Mem/{printf("%.2f%\n"), $3/$2*100}' | sed "s/\..*//g")
if [ $usedMemP -gt $memThreshold ]; then
    SendDingDing $usedMemP 3
fi
