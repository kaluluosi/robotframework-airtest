*** Settings ***
Documentation       这个Resource负责封装通用的 Setup Tear Down 供整个测试项目使用。
...                 这个文件默认提供了最基础的 设置、清理 关键字，具体的项目需要具体的去完善。
...                 比如测试集通用设置，可能连接完设备进到游戏后会有弹窗要清理，那么就得在连接设备后面
...                 增加清理弹窗的操作。

Library             robotframework_airtest.device.DeviceLibrary
Resource            Language/${language}.resource
Resource            Poco.resource


*** Variables ***
${language}     zh


*** Keywords ***
测试集通用设置
    [Timeout]    3 min
    连接设备
    No Operation

测试集通用清理
    断开设备

用例通用设置
    [Documentation]    主要是处理创角流程
    No Operation
    # 自动创角    ${None}    ${True}    ${False}    ${True}

用例通用清理
    # 登出
    No Operation

重新打开APP
    断开设备
    连接设备
