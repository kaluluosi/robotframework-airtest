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

测试滑动列表
    点击元素    btn_start
    点击元素    list_view
    滑动列表    Scroll View    vertical    0.5
    点击元素    text=Item 12
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12
