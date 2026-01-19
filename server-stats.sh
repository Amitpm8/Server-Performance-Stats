CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk -F',' '{print 100 - $4}' | awk '{print $1}')
echo "CPU Usage: $CPU_USAGE %"

echo ""
echo "Memory Usage:"

TOTAL_MEM=$(free -m | awk 'NR==2{print $2}')
USED_MEM=$(free -m | awk 'NR==2{print $3}')
FREE_MEM=$(free -m | awk 'NR==2{print $4}')
MEM_PERCENT=$(awk "BEGIN {printf \"%.2f\", ($USED_MEM/$TOTAL_MEM)*100}")

echo "Used: ${USED_MEM}MB / ${TOTAL_MEM}MB (${MEM_PERCENT}%)"

echo ""
echo "Disk Usage:"

DISK_USAGE=$(df -h / | awk 'NR==2{print $3 "/" $2 " (" $5 ")"}')
echo "Disk: $DISK_USAGE"

echo ""
echo "Top 5 Processes by CPU Usage:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

echo ""
echo "Top 5 Processes by Memory Usage:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
