*** Settings ***
Library             robotframework_airtest.device.DeviceLibrary
Resource            ../../Resources/Poco.resource
Resource            ../../Resources/初始化.resource
Resource            ../../Resources/界面模型/BagView.resource    # 导入界面模型

# Suite Setup    测试集通用设置
# Suite Teardown    测试集通用清理
Test Setup          初始化用例
Test Teardown       清理用例


*** Test Cases ***
测试点击元素
    点击元素    btn_start
    元素必须不存在    btn_start

测试长按元素
    长按元素    btn_start
    元素必须不存在    btn_start

测试输入文字
    点击元素    btn_start
    点击元素    basic
    输入文字    pos_input    hello
    ${text}    获取文字    Text
    Should Be Equal    ${text}    hello

测试点击屏幕
    点击屏幕    (0.5, 0.355555534)
    元素必须不存在    btn_start

测试等待元素消失
    点击元素    btn_start
    点击元素    wait_ui
    等待元素消失    yellow

测试滑动元素
    点击元素    btn_start
    点击元素    list_view
    滑动元素    Scroll View    (0,-0.5)
    点击元素    text=Item 12
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12

测试滑动列表
    点击元素    btn_start
    点击元素    list_view
    滑动列表    Scroll View    vertical    0.5
    点击元素    text=Item 12
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12

测试键盘输入
    点击元素    btn_start
    点击元素    basic
    点击元素    pos_input
    键盘输入    hello
    ${text}    获取文字    Text
    Should Be Equal    ${text}    hello

测试通过文本点击列表项
    打开列表测试界面
    通过文本点击列表项    Scroll View    Item 12
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12

    通过文本点击列表项    Scroll View    Item 1
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 1

    通过文本点击列表项    Scroll View    Item 12    item_path=?nameMatches=Text.*
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12

测试通过索引点击列表项
    打开列表测试界面

    通过索引点击列表项    Scroll View    12    item_path=?nameMatches=Text.*
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12

    通过索引点击列表项    Scroll View    1    item_path=?nameMatches=Text.*
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 1

测试手势1-通过元素名
    点击元素    btn_start
    点击元素    text=drag drop

    按住    star
    # 按住    1 secs
    到    shell
    放开

测试手势2-通过元素对象
    点击元素    btn_start
    点击元素    text=drag drop

    ${star}    获取元素    star
    ${shell}    获取元素    shell

    按住    ${star}
    # 按住    1 secs
    到    ${shell}
    放开

测试手势-待焦点偏移
    点击元素    btn_start
    点击元素    text=drag drop

    ${star}    获取元素    star
    ${shell}    获取元素    shell

    按住    ${star}    focus=(0.2,0.2)
    # 按住    1 secs
    到    ${shell}    focus=(0.8,0.8)
    放开

测试如果那么关键字
    [Setup]    No Operation
    如果 2>1 那么 打印日志
    如果 为真 那么 打印日志

    ${结果}    Set Variable    ${True}

    如果 ${结果} 那么 打印日志
    [Teardown]    No Operation


*** Keywords ***
打开列表测试界面
    连接设备
    点击元素    btn_start
    点击元素    list_view

模板通过文本点击列表项
    [Arguments]    ${文本}    ${item_path}=${None}    ${click_path}=${None}    ${focus}=(0.5,0.5)    ${duration}=0.5
    通过文本点击列表项    Scroll View    ${文本}    ${item_path}    ${click_path}    ${focus}    ${duration}
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12

打印日志
    Log    hello    console=True

为真
    ${结果}    Set Variable    ${True}
    RETURN    ${结果}

初始化用例
    连接设备    ${device_uri}    ${pkg_name}    ${True}

清理用例
    断开设备
