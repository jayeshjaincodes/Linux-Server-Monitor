#!/bin/bash 


CONFIG_FILE="config.yaml"
LOG_DIR="logs"
LOG_FILE="$LOG_DIR/server.log"
ALERT_FILE="$LOG_DIR/alerts.log"

mkdir -p $LOG_DIR

RAM_THRESHOLD=$(grep "ram_threshold" $CONFIG_FILE | awk '{print $2}')
CPU_THRESHOLD=$(grep "cpu_threshold" $CONFIG_FILE| awk '{print $2}' )
DISK_THRESHOLD=$(grep "disk_threshold" $CONFIG_FILE | awk '{print $2}')


RAM_USAGE=$(free | awk '/Mem/ {printf "%.2f\n", $3/$2 * 100}')
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
DISK_USAGE=$(df -h / | awk 'END {print $5}' | tr -d "%")

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "$TIMESTAMP RAM=$RAM_USAGE%, CPU=$CPU_USAGE%, DISK=$DISK_USAGE%" >> $LOG_FILE


if (( $(echo "$RAM_USAGE > $RAM_THRESHOLD" | bc -l) ))
then
	echo "WARNING: $TIMESTAMP HIGH RAM USAGE:$RAM_USAGE%" >> $ALERT_FILE
fi 

if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) ))
then
        echo "WARNING: $TIMESTAMP HIGH CPU USAGE:$CPU_USAGE%" >> $ALERT_FILE
fi

if (( $(echo "$DISK_USAGE > $DISK_THRESHOLD" | bc -l) ))
then
        echo "WARNING: $TIMESTAMP HIGH DISK USAGE:$DISK_USAGE%" >> $ALERT_FILE
fi

check_service(){
services=("docker" "apache" "nginx")

for service in "${services[@]}"
do
	status=$(systemctl is-active $service)

	if [ "$status" = "active" ]
	then
		echo "$TIMESTAMP $service is running" >> $LOG_FILE
	else
		echo "WARNING: $TIMESTAMP $service is $status" >> $ALERT_FILE

	fi
done
}

check_service

# Cleanup logs older than 1 day
find $LOG_DIR -type f -mtime +1 -delete



