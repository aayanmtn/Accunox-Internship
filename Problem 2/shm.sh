#!/bin/bash
# System Health Manager
LOG_FILE="system_health.log"
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

echo "*** System Health Check ***" >>$LOG_FILE
date >>$LOG_FILE

# Check CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
echo "CPU Usage: $CPU_USAGE%" >>$LOG_FILE
if (($(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l))); then
  echo "Warning: High CPU usage detected! ($CPU_USAGE%)" >>$LOG_FILE
fi

# Check Memory usage
MEMORY_USAGE=$(free | awk '/Mem/ {print $3/$2 * 100.0}')
echo "Memory Usage: $MEMORY_USAGE%" >>$LOG_FILE
if (($(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l))); then
  echo "Warning: High Memory usage detected! ($MEMORY_USAGE%)" >>$LOG_FILE
fi

# Check Disk usage
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')
echo "Disk Usage: $DISK_USAGE%" >>$LOG_FILE
if [ "$DISK_USAGE" -gt "$DISK_THRESHOLD" ]; then
  echo "Warning: High Disk usage detected! ($DISK_USAGE%)" >>$LOG_FILE
fi

echo "System health check completed." >>$LOG_FILE
echo "*************************" >>$LOG_FILE
