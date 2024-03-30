#!/bin/bash  
  
# 定义帮助信息  
show_help() {  
    echo "Usage: $0 [OPTION]"  
    echo "  --install  Installs all .service files in ./service/ directory"  
    echo "  --uninstall  Uninstalls all .service files installed from ./service/"  
    echo "  --help     Show this help message"  
    exit 0  
}  
  
# 检查参数  
if [ "$#" -ne 1 ]; then  
    show_help  
fi  
  
case "$1" in  
    --install)  
        # 安装所有.service文件  
        for file in ./service/*.service; do  
            if [ -f "$file" ]; then  
                service_name=$(basename "$file" .service)  
                target_dir="/etc/systemd/system/"  
                target_file="$target_dir$service_name.service"  
                  
                # 复制.service文件到/etc/systemd/system/  
                sudo cp "$file" "$target_file"  
                  
                # 重新加载systemd守护进程以识别新的服务文件  
                sudo systemctl daemon-reload  
                  
                # 启用服务  
                sudo systemctl enable "$service_name"  
                  
                echo "Installed and enabled $service_name"  
            else  
                echo "Error: $file does not exist or is not a regular file."  
            fi  
        done  
        ;;  
    --uninstall)  
        # 卸载所有从./service/安装的.service文件  
        for file in ./service/*.service; do  
            if [ -f "$file" ]; then  
                service_name=$(basename "$file" .service)  
                target_file="/etc/systemd/system/$service_name.service"  
                  
                # 停止并禁用服务  
                sudo systemctl stop "$service_name"  
                sudo systemctl disable "$service_name"  
                  
                # 删除.service文件  
                sudo rm -f "$target_file"  
                  
                echo "Uninstalled $service_name"  
            else  
                echo "Error: $file does not exist or is not a regular file."  
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