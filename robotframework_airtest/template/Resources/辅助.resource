*** Settings ***
Documentation       这是个辅助Resource，主要用来定义一些通用的辅助关键字，比如自动创角

Resource            Poco.resource


*** Variables ***
${serverid}     1


*** Keywords ***
自动创角
    [Documentation]    自动创角自动流程，负责帮忙处理登录-》创角-》进入主界面 一整个流程
    ...    但是具体的创角自动化操作流程需要自己实现，毕竟每个游戏的创角流程都不一样。
    ...    这个关键字前半部分生成随机角色名到登录这部分是通用的，往后就是登录到游戏里的创角
    ...    流程，自己实现吧。
    ${用户名}    生成随机角色名
    Set Global Variable    ${用户名}
    Set Test Message    账号:${用户名}    ${True}
    登录    ${用户名}    serverid=${serverid} # noqa

    No Operation

等待加载
    [Documentation]    等待场景加载完毕
    ...    这个关键字也是需要自己根据项目实现，实现的方式也很简单，用等待元素出现和等待元素消失
    ...    来等待加载界面（界面模型），的出现和消失。如果超时没等到这个关键字就会失败导致整个测试失败。

    # 等待元素出现    ${加载界面}    time_out=5 sec
    # 等待元素消失    ${加载界面}    time_out=20 sec
    Pass Execution    message
