#!/bin/bash

# 获取当前时间
current_time=$(date +"%Y-%m-%d %H:%M:%S")

# 获取CPU使用率
cpu_usage=$(top -bn1 | grep Cpu | awk '{print $2}' | cut -d '%' -f1)

# 获取内存占用率
mem_total=$(free | awk '/Mem/{print $2}')
mem_used=$(free | awk '/Mem/{print $3}')
mem_usage=$(awk -v total="$mem_total" -v used="$mem_used" 'BEGIN { printf "%.2f", used/total*100 }')

# 获取虚拟内存占用率
swap_total=$(free | awk '/Swap/{print $2}')
swap_used=$(free | awk '/Swap/{print $3}')
swap_usage=$(awk -v total="$swap_total" -v used="$swap_used" 'BEGIN { printf "%.2f", used/total*100 }')

# 获取磁盘空间占用率
disk_usage=$(df -h | awk '$NF=="/"{printf "%s", $5}')

# 发送邮件
if (( $(echo "$mem_usage >= 70 && $swap_usage >= 70" | bc -l) )); then
    message="Subject: 系统信息报告\n\n当前时间:$current_time\nCPU使用率:$cpu_usage%\n内存占用率:$mem_usage%\n虚拟内存占用率:$swap_usage%\n磁盘空间占用率:$disk_usage"
    recipients="908422490@163.com"
    echo -e "$message" | ssmtp "$recipients"
fi
