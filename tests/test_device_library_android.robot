*** Settings ***
Library             robotframework_airtest.device.DeviceLibrary

Test Setup          初始化用例
Test Teardown       断开设备


*** Variables ***
${APK路径}    tests/demo/com.netease.poco.u3d.tutorial.apk
${包名}       com.NetEase


*** Test Cases ***
测试列出已安装应用
    ${app列表}    列出安装的APP
    Should Not Be Empty    ${app列表}

测试安装卸载应用
    安装APP    ${APK路径}
    APP必须安装成功    ${包名}
    [Teardown]    卸载APP    ${包名}

测试截图
    ${截图数据}    截图
    Should Not Be Empty    ${截图数据}

测试点击
    点击    (100,100)

测试双击
    双击    (100,100)

测试滑动
    滑动    (100,100)    (-1000,100)

测试模拟按键事件
    模拟按键事件    HOME

测试输入文本
    输入文本    hello

测试启动关闭应用
    安装APP    ${APK路径}
    启动APP    ${包名}
    Sleep    2s
    停止APP    ${包名}
    [Teardown]    卸载APP    ${包名}

测试清理APP缓存
    安装APP    ${APK路径}
    清理APP缓存    ${包名}
    [Teardown]    卸载APP    ${包名}

测试列出安装的APP
    ${结果}    列出安装的APP
    Should Not Be Empty    ${结果}    msg=${结果}

测试获取分辨率
    ${结果}    获取分辨率
    Should Not Be Empty    ${结果}    msg=${结果}

获取渲染分辨率
    ${结果}    获取渲染分辨率
    Should Not Be Empty    ${结果}    msg=${结果}

获取IP
    ${结果}    获取IP
    Should Not Be Empty    ${结果}    msg=${结果}

shell命令
    ${结果}    shell命令    pm list packages
    Should Not Be Empty    ${结果}    msg=${结果}


*** Keywords ***
初始化用例
    连接设备    android:///
