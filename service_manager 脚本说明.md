# service_manager.sh 脚本说明

`service_manager.sh` 是一个用于管理位于`./service/`目录下的`.service`文件的bash脚本。它支持安装和卸载所有在指定目录下的服务文件。

## 使用方法

将`service_manager.sh`脚本保存至service文件夹的上一级目录，并在终端中执行以下命令以管理服务：

```bash
# 安装所有服务，将安装当前目录下的service文件夹中的所有.service文件
./service_manager.sh --install

# 卸载所有服务，将卸载当前目录下的service文件夹中的所有.service文件
./service_manager.sh --uninstall

# 显示帮助信息
./service_manager.sh --help
```

## 功能描述

- **安装服务**：使用`--install`参数，脚本会遍历`./service/`目录下的所有`.service`文件，将它们复制到`/etc/systemd/system/`目录，并启用这些服务。
- **卸载服务**：使用`--uninstall`参数，脚本会遍历`./service/`目录下的所有`.service`文件，停止并禁用这些服务，并从`/etc/systemd/system/`目录中删除对应的`.service`文件。
- **帮助信息**：使用`--help`参数，脚本会显示使用方法。

## 注意事项

- 该脚本需要`sudo`权限来执行复制、删除文件以及管理服务的操作。
- 脚本假定`./service/`目录存在且包含有效的`.service`文件。
- 脚本将直接覆盖`/etc/systemd/system/`目录下同名的`.service`文件。
- 在卸载服务时，脚本会尝试停止并禁用服务，但如果服务没有运行或已禁用，这些操作不会报错。

## 脚本原理

脚本首先检查传入的参数个数，确保只有一个参数被传入。然后，根据参数的值执行不同的操作：

- 当参数为`--install`时，脚本遍历`./service/`目录下的所有`.service`文件，并对每一个文件执行以下操作：
  - 提取服务名。
  - 将`.service`文件复制到`/etc/systemd/system/`目录。
  - 重新加载systemd守护进程以识别新的服务文件。
  - 启用服务。

- 当参数为`--uninstall`时，脚本执行类似的操作，但这次是停止服务、禁用服务以及删除`.service`文件。

## 脚本代码

完整的脚本代码可以在`service_manager.sh`文件中找到。

## 常见问题及解决方案

- **问题**：脚本执行时报错提示权限不足。
  **解决方案**：确保你以`sudo`权限运行脚本。

- **问题**：服务安装或卸载后没有生效。
  **解决方案**：检查`.service`文件是否编写正确，并确认`/etc/systemd/system/`目录下存在或删除了正确的文件。可以尝试重新加载systemd守护进程或重启计算机。

- **问题**：脚本无法找到`./service/`目录下的文件。
  **解决方案**：检查`service_manager.sh`脚本和`.service`文件是否位于同一父目录下，并确保`./service/`目录存在且包含`.service`文件。

希望这份文档能够帮助你日后查阅和使用`service_manager.sh`脚本。如有任何疑问或问题，请随时联系脚本的维护者。