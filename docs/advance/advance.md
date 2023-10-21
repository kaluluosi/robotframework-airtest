# 高级

高级教程这部分不是必须看的，因为日常测试[入门](./入门.md)、[进阶](./进阶.md)这两篇已经够用了。

高级篇主要讲了一些如何用python脚本扩展自定义关键字的内容。

## 数据驱动测试

数据驱动测试是Robotframework的特性之一，详情可以看官方文档[测试模板](https://robotframework-userguide-cn.readthedocs.io/zh_CN/latest/CreatingTestData/CreatingTestCases.html?highlight=template#test-templates)。

!!! Question
    讲数据驱动测试之前先问大家一个问题：

        如果让你测试一个账号登录界面，你会怎么测试？

账号登录界面抛开各种打开关闭操作步骤以外，最重要的测试点都集中在用户名（username）和密码（password）的校验测试上。

用户名的校验规则有

- 不可以包含特殊字符
- 用户名最小长度
- 用户名最大长度
- 用户名重名

密码的校验规则有

- 密码最小长度
- 密码最大长度
- 密码要包含某几个特殊字符
- 

按照这个校验规则，我们要输入的数据就有很多组。

这是我们的测试用例

```robotframework

*** Test Cases ***
输入无效用户名
    界面打开流程.打开账号界面       # setup

    loginAccountViewUI.输入文字微雅_EditLabAccount    ${EMPTY}
    loginAccountViewUI.输入文字微雅_EditLabPassword    11111
    loginAccountViewUI.点击通用按钮_一级_OkBtn
    ${结果}     loginAccountViewUI.界面不存在
    Should Be True      ${结果}==${预期结果}
    
    辅助库.重启游戏并清理弹窗

    界面打开流程.打开账号界面       # setup

    loginAccountViewUI.输入文字微雅_EditLabAccount    #$%^&
    loginAccountViewUI.输入文字微雅_EditLabPassword    11111
    loginAccountViewUI.点击通用按钮_一级_OkBtn
    ${结果}     loginAccountViewUI.界面不存在
    Should Be True      ${结果}==${预期结果}
    
    辅助库.重启游戏并清理弹窗

    界面打开流程.打开账号界面       # setup

    loginAccountViewUI.输入文字微雅_EditLabAccount    123456789090438504
    loginAccountViewUI.输入文字微雅_EditLabPassword    11111
    loginAccountViewUI.点击通用按钮_一级_OkBtn
    ${结果}     loginAccountViewUI.界面不存在
    Should Be True      ${结果}==${预期结果}
    
    辅助库.重启游戏并清理弹窗

    ...
```

这样子写这个用例实在是太长了！

折中的我们可以把整个操作步骤封装成关键字。

```robotframework

*** Keywords ***
无效用户名
    [Arguments]     ${用户名}
    界面打开流程.打开账号界面

    loginAccountViewUI.输入文字微雅_EditLabAccount    ${用户名}
    loginAccountViewUI.输入文字微雅_EditLabPassword    11111
    loginAccountViewUI.点击通用按钮_一级_OkBtn
    
    # 如果用户名无效无法注册，登录界面不会关闭
    loginAccountViewUI.界面必须存在
    
    [Teardown] 辅助库.重启游戏并清理弹窗

*** Test Cases ***
输入无效用户名
    输入用户名  ${EMPTY}
    输入用户名  #$%^&
    输入用户名  123456789090438504
```

看起来简短很多，但是又带来另一个问题，**`输入无效用户名`这个用例只要有一条执行失败，那么下面的都不会执行**。对于我们来讲这三个输入应该是并行测试的，其中一条错了应该不影响其他的测试。要做到这个效果就要用到Robot Framework的[测试模板](https://robotframework-userguide-cn.readthedocs.io/zh_CN/latest/CreatingTestData/CreatingTestCases.html?highlight=template#test-templates)。


```robotframework

*** Keywords ***

无效用户名
    [Arguments]     ${用户名}
    界面打开流程.打开账号界面

    loginAccountViewUI.输入文字微雅_EditLabAccount    ${用户名}
    loginAccountViewUI.输入文字微雅_EditLabPassword    11111
    loginAccountViewUI.点击通用按钮_一级_OkBtn
    
    # 如果用户名无效无法注册，登录界面不会关闭
    loginAccountViewUI.界面必须存在
    
    [Teardown] 辅助库.重启游戏并清理弹窗

*** Test Cases ***
输入无效用户名
    [Template]  无效用户名
    ${EMPTY}
    #$%^&
    123456789090438504
```

我们改成用测试模板来驱动，测试数据写在测试用例里，测试数据会作为参数传入作为测试模板的关键字里，那么有多少行测试数据就会执行多少次测试模板。并且这些这些测试不会因为上一个测试失败了而导致整个测试用例失败。测试用例执行完毕后会如果有一个测试是失败的那么这跳测试用例的结果就会被标为失败，并且报告里会明确的显示出那一条数据测试失败了。

!!! Warning
    用数据驱动测试有一点要非常注意，那儿就是测试模板的`Teardown`，我们必须确保每条数据测试结束后，下一条数据测试时能够从初始状态开始执行。
    
    什么意思呢？比如上面的例子，如果第一条数据测试完后，我么你没有做重启游戏并清理窗口的操作，那么这时候用户登录界面应该还是打开着的，这时候进入下一条测试数据的时候又会尝试`界面打开流程.打开账号界面`，而这时候账号界面已经打开了所以这一步一定会失败。所以正确的操作是每一次测试模板执行完毕后都要去恢复到打开账号界面前的状态，让下一个数据能够从头开始执行。关键字内的语句只要失败了就不会继续往下执行，放在关键字里调用当测试数据失败的时候就无法正确恢复状态了。而关键字的`Teardown`属性是无论关键字成功还是失败都会执行的，所以放到这里去做恢复处理。

!!! Tip
    通过数据驱动的方式测试一些表单类界面会更加方便。

## 自定义测试库

Robotframework默认内置了不少测试库。

|测试库|说明|
|---|---|
|BuiltIn|基础内置库，run keyword等关键字就是在这里定义的|
|Collections|集合操作相关测试库，比如给数组append数据、排序、获取字典的keys等|
|DateTime|时间日期相关测试库|	
|Dialogs| 用来在测试过程中弹出对话框让用户确认|
|OperatingSystem|操作系统相关测试库|	
|Process|进程相关测试库|	
|Remote|远程测试库|	
|Screenshot|截图测试库|	
|String|字符串处理测试库，比如splite之类的操作|	
|Telnet|telnet测试库|	
|XML|xml操作测试库|	

Robotframework的脚本的基本语法并不像python那么自由灵活，比如像字符串格式化、分割字符串（splite）你都没办法在RobotFramework脚本里直接调用。

```robotframework
*** Test Cases ***
示例
    Set Variable    ${文本}     1,2,3,4
    ${片段}     ${文本}.splite(",")     # 这是不行的！
```

你都得用测试库的关键字去处理

```robotframework
*** Setting ***
Library     String

*** Test Cases ***
示例
    ${文本}     Set Variable    1,2,3,4
    ${片段}     Split String    ${文本}     ,
```

但是Robotframework提供的测试库并不都能满足我们的需要，这时候我们就要自己去扩展自己的测试库。

!!! Tip
    PocoLibrary就是Robot Framework的测试库。

但是这篇文章不打算讲完整的测试库要怎么开发，我给大家带来一个更加简单的扩展方式。

!!! Tip
    完整测试库的开发可以去看[创建测试库](https://robotframework-userguide-cn.readthedocs.io/zh_CN/latest/ExtendingRobotFramework/CreatingTestLibraries.html)，篇幅十分的长。

比如说我们想要一个字符串拼接的关键字，但是`String`库里没有提供。

我们可以在`Resources`目录下创建一个`util.py`python脚本。

![](2021-09-18-16-14-26.png)

文件里就写一个函数：

```python title="util.py"

def 字符串拼接(连接符:str,*args):
    return 连接符.join(args)

```

!!! Note
    得益于python3.x，可以支持中文作为函数变量名。

然后在你的测试脚本里：

```robotframework
*** Settings ***
Library     ../../Resources/util.py

*** Test Cases ***
示例
    ${text}     字符串拼接    a     b     c     d

```

你会发现robot脚本里神奇的识别util里的函数作为关键字，并通过代码提示弹出来。

![](2021-09-18-16-18-47.png)

就这样你就实现了你自己的测试库，以后基础库解决不了的事情你就可以自己开发测试库去解决。

你还可以干更加骚的事情，那就是直接在python测试库里调用poco使用原汁原味的Airtest.Poco写关键字。

```python

def 直接写自己的Poco操作():
    poco_library = BuiltIn().get_library_instance("StdPocoLibrary")
    poco = poco_library.poco

    poco("btn_start").click()
    ...
```

!!! Tip
    你不一定要在`Resources`目录下创建测试库脚本，你可以在任何地方创建，引入的时候相对路径写对就行。


## 变量文件

变量文件跟测试库一样也是python脚本，详情可见Robotframework文档的[变量文件](https://robotframework-userguide-cn.readthedocs.io/zh_CN/latest/CreatingTestData/ResourceAndVariableFiles.html#variable-files)。

同测试库一样，你可以在`Resources`目录下创建你变量文件`myvariables.py`

```python
VARIABLE = "An example string"
ANOTHER_VARIABLE = "This is pretty easy!"
INTEGER = 42
STRINGS = ["one", "two", "kolme", "four"]
NUMBERS = [1, INTEGER, 3.14]
MAPPING = {"one": 1, "two": 2, "three": 3}
```

```robotframework
*** Settings ***
Library     ../../Resources/myvariable.py

*** Test Cases ***
示例
    Log     ${VARIBALE}

```

如果你的变量需要动态生成，比如从其他文件读取，那么用变量文件会很方便，毕竟Robotframework脚本不适合干这种复杂的事情，限制很多。

其中一个用法就是读取配置表，比如道具表返回 `道具名=道具id` 的变量，供测试脚本引用。

详情还是去看官方文档[变量文件](https://robotframework-userguide-cn.readthedocs.io/zh_CN/latest/CreatingTestData/ResourceAndVariableFiles.html#variable-files)，就目前来讲很少用到变量文件。
