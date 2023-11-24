*** Settings ***
Library             robotframework_airtest.AirtestLibrary    WITH NAME    airtest
Library             robotframework_airtest.DeviceLibrary    WITH NAME    device
Library             OperatingSystem

Test Setup          初始化用例
Test Teardown       清理用例


*** Variables ***
${APK路径}    tests/demo/com.netease.poco.u3d.tutorial.apk
${包名}       com.NetEase


*** Test Cases ***
测试当前目录
    Log    当前目录:${CURDIR}    level=CONSOLE

测试点击
    airtest.点击    btn_start.png

测试等待
    airtest.等待    btn_start.png    30s

测试滑动
    airtest.点击    btn_start.png
    airtest.点击    drag_drop.png
    airtest.滑动    star.png    shell.png

测试查找所有
    airtest.点击    btn_start.png
    airtest.点击    drag_drop.png
    ${stars}    airtest.查找所有    star.png
    FOR    ${element}    IN    @{stars}
        Log    ${element}    level=CONSOLE
        airtest.滑动    ${element}    shell.png
    END
    airtest.必须不存在    star.png

测试存在
    ${存在}    airtest.存在    btn_start.png
    Should Be True    ${存在}

测试输入文字
    airtest.点击    btn_start.png
    airtest.点击    basic.png
    airtest.点击    textbox.png
    airtest.输入文字    hello

测试按键事件
    airtest.按键事件    HOME
    airtest.必须不存在    btn_start.png

测试截图
    airtest.截图    screenshot.png
    File Should Exist    screenshot.png
    Remove File    screenshot.png

睡眠
    airtest.睡眠    2s

断言
    airtest.必须存在    btn_start.png
    airtest.必须不存在    star.png
    airtest.必须相等    btn_start.png    btn_start.png
    airtest.必须不相等    btn_start.png    star.png

测试剪贴板
    airtest.设置剪贴板    hello
    ${结果}    airtest.获取剪贴板
    Should Be Equal As Strings    ${结果}    hello

测试双指手势
    airtest.双指手势    in

测试Home键
    airtest.Home键

测试唤醒
    airtest.唤醒


*** Keywords ***
初始化用例
    连接设备    android:///
    ${已安装}    是否已安装APP    ${包名}
    IF    ${已安装} == ${False}    安装APP    ${APK路径}
    启动APP    ${包名}
    Sleep    3s

清理用例
    停止APP    ${包名}
