#  前端接入

## 项目前端Poco-SDK接入

Poco在大多数平台中，需要事先接入Poco-SDK才可正常使用 ，在少数平台（如Android原生APP）可直接使用Poco，目前支持平台如下：

|平台|Airtest|Poco|
|---|---|---|
|Cocos2dx-js, Cocos2dx-lua|√	|[接入文档](https://poco-chinese.readthedocs.io/zh_CN/latest/source/doc/integration.html#cocos2dx-lua)|
|Unity3D                  |√	|[接入文档](https://poco-chinese.readthedocs.io/zh_CN/latest/source/doc/integration.html#unity3d)|
|Native Android APP       |√    |直接使用|
|iOS	                  |√	|[帮助文档](https://airtest.doc.io.netease.com/IDEdocs/device_connection/4_ios_connection/)|
|Egret	                  |√	|[接入文档](https://poco-chinese.readthedocs.io/zh_CN/latest/source/doc/implementation_guide.html)|
|Other engines	          |√	|[可自行接入](https://poco-chinese.readthedocs.io/zh_CN/latest/source/doc/implementation_guide.html)|
|WeChat Applet&webview    |√	|[参考文档](https://airtest.doc.io.netease.com/IDEdocs/poco_framework/poco_webview/) 随着微信更新可能会失效|
|Windows, MacOS	          |√	|敬请期待|
|Netease	              |√	|[帮助文档](http://git-qa.gz.netease.com/maki/netease-ide-plugin)|

[Poco-SDK Github项目地址](https://github.com/AirtestProject/Poco-SDK)

## 前端SDK实现自定义接口

Poco-SDK的核心是PocoManger，PocoManger会负责在游戏客户端启动一个TCPServer，测试脚本通过Poco对象（本质是个TCPClient）去跟PocoManager通信做RPC调用。

为了游戏UI自动化测试方便和效率，Robotframework-Airtest的StdPocoLibrary默认提供了 `登入` `登出` `调用GM命令`  这三个关键字，这三个关键字会通过Poco的RPC调用游戏客户端里PocoManager的对应接口。

因此前端接入了Poco-SDK以外还需要额外扩展实现一下这三个RPC接口。


### 接口需求文档

#### 登录

>**login**

```
login(username:str, password:str, serverid:int) -> Any
```

侵入性登录接口。绕过输入账号选服等点击操作流程，直接设置账号密码登录到测试服务器。调用后前端直接走登录流程登录到目标服务器。

- 参数说明

|参数|类型|说明|
|-|-|-|
|username|String|用户名|
|password|String|密码|
|serverid|int|服务器入口标志，比如服务器id|

#### 登出

>**logout**

```
logout() -> Any
```
侵入性登出到登录界面。这个接口对需要反复创号反复测试的用例十分有用，比如好友系统需要创建多个账号互相加好友，那么账号之间切换就需要返回登录界面再登其他账号操作，因此我们需要一个侵入性快速的手段登出账号回到登录界面。

#### 发送GM命令

>**send_gm**
```python
send_gm(gm_code:str, *args) -> String
```
调用GM命令
例子： send_gm("add_item", 1001, 10)  # 添加10个1001道具

注意：gm命令分前端命令和后端命令，因此这个命令要能够区分处理。比如可以通过约定的方式"$ add\_item"带\$开头的命令识别为后端命令，然后解析出add_item用后端GM命令的处理方式去调用。如何约定和解析`gm_code`，请在`send_gm`这个接口里面根据项目需求自行约定处理。

例子：
```
    某手游调用GM命令关键字支持以下几种方式：
    调用GM命令    设置金币数量    Money    1000    
    调用GM命令    $set    Money    1000        就跟在聊天栏里发送指令一样，这是服务端指令
    调用GM命令    /ftask                       这是客户端指令
```

- 参数说明

|参数|类型|说明|
|-|-|-|
|gm_code|String|GM命令名，比如“add_item”|
|*args  |List[str]  |可变长参数，是GM命令后续参数|

- 返回值
  
|类型|说明|
|-|-|
|String|有的GM命令是打印型的，可以返回信息|



### 以Unity3D的Poco-SDK为例子

在Unity3D的PocoManager内找到RPC Dispatcher（RPC分发器）相关代码

![](https://i.loli.net/2021/09/09/ps98JknByFbfeS1.png)

在这里添加我们自己的RPC接口：

```csharp
    rpc.addRpcMethod("login", login);
    rpc.addRpcMethod("logout", logout);
    rpc.addRpcMethod("send_gm", send_gm);

```

login接口实现例子

```csharp
    [RPC]
    private object login(List<object> param)
    {
        string username = (string)param[0];
        string password = (string)param[1];
        int serverId = Convert.ToInt32(param[2]);

        // 假设这个游戏的登录流程由下面这个接口负责
        LoginMgr.login(username, password, serverId);

        return 1;
    }
```

Unity项目如果集成了lua（比如xlua、ulua），那么就需要C#层去调用lua的接口。


!!! Warning
    请区分好内部开发和正式发布，正式发布的时候`PocoManager`不应该被挂载运行，避免`PocoManager`被发布出去。

!!! Tip
    `PocoManager`本质就是个TcpServer，了解过网络编程应该能理解其`Socket`接受数据是一个异步过程，因此不存在轮询与空转这种消耗性能的情况，所以不要担心`PocoManager`对游戏性能的影响。没有TcpClient连入与之通信产生RPC调用那么`PocoManager`就什么事情都不干。
