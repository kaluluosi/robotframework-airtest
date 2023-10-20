*** Settings ***
Resource            ../../Resources/Poco.resource
Resource            ../../Resources/初始化.resource

Suite Setup         测试集通用设置
Suite Teardown      测试集通用清理
Test Setup          用例通用设置
Test Teardown       用例通用清理


*** Test Cases ***
示例用例
    Log    Hello World!    console=True
