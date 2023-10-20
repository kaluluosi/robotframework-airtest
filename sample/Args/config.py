import json

with open(".vscode/settings.json", "r") as f:
    args = json.load(f)

pkg_name = args["pkg_name"] # pc客户端启动程序
device_uri = args["device_uri"]   # 设备连接字符串
auto_start_app = args["auto_start_app"]  # 自动开启app
serverid = args["serverid"]  # 登录的服务器id
