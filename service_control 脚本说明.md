# service_control.sh 脚本说明

本`service_control.sh`脚本用于管理位于`./service/`目录下的所有`.service`文件定义的服务。它支持启动、停止和重启服务，并提供了帮助信息。

## 使用方法

1. 将`service_control.sh`脚本保存到与服务定义文件相同的目录中（即`./service/`的父目录）。

2. 为脚本赋予执行权限：
   ```bash
   chmod +x service_control.sh
   ```

3. 运行脚本并传递相应的参数来控制服务：
   ```bash
   # 启动所有服务
   ./service_control.sh --start

   # 停止所有服务
   ./service_control.sh --stop

   # 重启所有服务
   ./service_control.sh --restart

   # 显示帮助信息
   ./service_control.sh --help
   ```

## 脚本功能

- **启动服务**：使用`--start`参数启动所有在`./service/`目录下定义的`.service`文件所对应的服务。
- **停止服务**：使用`--stop`参数停止所有在`./service/`目录下定义的`.service`文件所对应的服务。
- **重启服务**：使用`--restart`参数重启所有在`./service/`目录下定义的`.service`文件所对应的服务。
- **帮助信息**：使用`--help`参数显示脚本的帮助信息，包括使用方法。

## 注意事项

- 确保你有足够的权限来启动、停止和重启系统服务（通常需要使用`sudo`）。
- 请将`.service`文件正确放置在`./service/`目录中，并确保它们遵循systemd的服务文件规范。

## 脚本原理

脚本首先定义了一个`get_service_names`函数，用于从`./service/`目录中获取所有`.service`文件的名称（不带`.service`后缀）。然后，根据传入的参数（`--start`、`--stop`或`--restart`），脚本会循环遍历这些服务名称，并调用`systemctl`命令来启动、停止或重启它们。每个操作后，脚本都会检查命令的退出状态，并打印相应的成功或失败消息。

## 脚本代码

脚本的完整代码可以在`service_control.sh`文件中找到。

## 常见问题及解决方案

- **问题**：无法启动、停止或重启服务。
  **解决方案**：检查`.service`文件是否正确编写，并确保它们遵循systemd的规范。同时，确保你有足够的权限来管理系统服务。

- **问题**：脚本运行时报错。
  **解决方案**：检查脚本的语法是否正确，并确保所有必要的依赖和工具都已安装。如果问题仍然存在，请查看脚本的错误输出，并根据提示进行故障排除。

希望这份文档能够帮助你日后查阅和使用`service_control.sh`脚本。如有任何疑问或问题，请随时联系脚本的维护者。