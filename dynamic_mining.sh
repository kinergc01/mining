#!/bin/bash
# 文件：dynamic_mining.sh
MIN_POWER=270   # 最低功耗（瓦）
MAX_POWER=350   # 最高功耗（瓦）
INTERVAL=300    # 切换间隔（秒）

while true; do
  # 随机生成当前功耗
  CURRENT_POWER=$(( MIN_POWER + RANDOM % (MAX_POWER - MIN_POWER) ))
  
  # 设置GPU功耗墙
  nvidia-smi -pl $CURRENT_POWER
  
  # 随机调整核心频率（Offset模式）
  CORE_OFFSET=$(( -200 + RANDOM % 400 ))  # -200到+200MHz波动
  nvidia-settings -a "[gpu:0]/GPUGraphicsClockOffsetAllPerformanceLevels=$CORE_OFFSET"
  
  # 打印当前状态
  echo "$(date) | GPU Power: ${CURRENT_POWER}W | Core Offset: ${CORE_OFFSET}MHz"
  
  sleep $INTERVAL
done