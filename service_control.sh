#!/bin/bash  
  
# 定义帮助信息  
show_help() {  
    echo "Usage: $0 [OPTION]"  
    echo "  --start    Starts all services defined in ./service/ directory"  
    echo "  --stop     Stops all services defined in ./service/ directory"  
    echo "  --restart  Restarts all services defined in ./service/ directory"  
    echo "  --help     Show this help message"  
    exit 0  
}  
  
# 检查参数  
if [ "$#" -ne 1 ]; then  
    show_help  
fi  
  
# 获取所有服务名称  
get_service_names() {  
    local dir="./service/"  
    local services=($(find "$dir" -maxdepth 1 -type f -name "*.service" | sed "s|$dir||" | sed "s|\.service||"))  
    echo "${services[@]}"  
}  
  
case "$1" in  
    --start)  
        # 启动所有服务  
        for service in $(get_service_names); do  
            echo "Starting $service..."  
            sudo systemctl start "$service"  
            if [ $? -eq 0 ]; then  
                echo "$service started successfully."  
            else  
                echo "Failed to start $service."  
            fi  
        done  
        ;;  
    --stop)  
        # 停止所有服务  
        for service in $(get_service_names); do  
            echo "Stopping $service..."  
            sudo systemctl stop "$service"  
            if [ $? -eq 0 ]; then  
                echo "$service stopped successfully."  
            else  
                echo "Failed to stop $service."  
            fi  
        done  
        ;;  
    --restart)  
        # 重启所有服务  
        for service in $(get_service_names); do  
            echo "Restarting $service..."  
            sudo systemctl restart "$service"  
            if [ $? -eq 0 ]; then  
                echo "$service restarted successfully."  
            else  
                echo "Failed to restart $service."  
            fi  
        done  
        ;;  
    --help)  
        show_help  
        ;;  
    *)  
        echo "Error: Unknown option $1"  
        show_help  
        ;;  
esac