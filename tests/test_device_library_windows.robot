*** Settings ***
Library             robotframework_airtest.device.DeviceLibrary

Test Setup          初始化用例
Test Teardown       断开设备


*** Test Cases ***
获取分辨率
    ${结果}    获取分辨率
    Should Not Be Empty    ${结果}    msg=${结果}


*** Keywords ***
初始化用例
    连接设备    windows:///?title_re=com    tests/demo/com.netease.poco.u3d.tutorial.exe    True
