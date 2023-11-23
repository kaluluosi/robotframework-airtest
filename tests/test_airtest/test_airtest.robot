*** Settings ***
Library         robotframework_airtest.airtest.AirtestLibrary
Library         robotframework_airtest.device.DeviceLibrary

Test Setup      初始化用例
# Test Teardown    清理用例


*** Variables ***
${APK路径}    tests/demo/com.netease.poco.u3d.tutorial.apk
${包名}       com.NetEase


*** Test Cases ***
测试当前目录
    Log    当前目录:${CURDIR}    level=CONSOLE

测试点击
    Touch    btn_start.png


*** Keywords ***
初始化用例
    连接设备    android:///
    ${已安装}    是否已安装APP    ${包名}
    IF    ${已安装} == ${False}    安装APP    ${APK路径}
    启动APP    ${包名}
    Sleep    3s

清理用例
    停止APP    ${包名}
