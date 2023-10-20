*** Settings ***
Library             robotframework_airtest.device.DeviceLibrary    Android:///
Library             robotframework_airtest.poco.UnityPocoLibrary

Test Setup          初始化用例
Test Teardown       清理用例


*** Variables ***
${APK路径}    tests/demo/com.netease.poco.u3d.tutorial.apk
${包名}       com.NetEase


*** Test Cases ***
测试获取元素
    ${start}    获取元素    btn_start
    元素必须存在    ${start}
    Should Be Equal    ${start.attr('name')}    btn_start

测试通过属性获取元素
    ${start}    获取元素    text=Start
    元素必须存在    ${start}
    Should Be Equal    ${start.attr('name')}    Text

测试通过属性正则获取元素
    ${start}    获取元素    textMatches=Sta.*
    元素必须存在    ${start}
    Should Be Equal    ${start.attr('name')}    Text

测试通过查询链获取元素
    ${start}    获取元素    beginPanel\\btn_start
    元素必须存在    ${start}
    Should Be Equal    ${start.attr('name')}    btn_start

测试通过查询链查询参数获取元素
    ${start}    获取元素    ?type\=Image&nameMatches\=begin.*\\btn_start
    元素必须存在    ${start}
    Should Be Equal    ${start.attr('name')}    btn_start

测试查询不存在的元素
    ${不存在元素}    获取元素    不存在
    元素必须不存在    ${不存在元素}

测试点击元素
    点击元素    btn_start
    元素必须不存在    btn_start

测试获取元素的父元素
    ${beginPanel}    获取元素的父元素    btn_start
    Should Be Equal    ${beginPanel.attr('name')}    beginPanel

测试获取元素的孩子
    ${btn_start}    获取元素的孩子    beginPanel
    Should Be Equal    ${btn_start.attr('name')}    btn_start

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

测试元素存在
    ${存在}    元素存在    btn_start
    Should Be True    ${存在}

测试元素不存在
    ${不存在}    元素不存在    不存在元素
    Should Be True    ${不存在}

测试元素必须不存在
    元素必须不存在    不存在元素

测试元素必须存在
    元素必须存在    btn_start

测试等待元素出现
    点击元素    btn_start
    点击元素    wait_ui2
    等待元素出现    black

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

测试获取属性
    ${btn_start}    获取元素    btn_start
    ${type}    Set Variable    ${btn_start.attr('type')}

    Log    ${type}

    Should Not Be Empty    ${type}
    Should Be Equal    ${type}    button    ignore_case=True

测试通过索引获取列表项
    打开列表测试界面

    ${项}    通过索引获取列表项    Scroll View    12    item_path=?nameMatches=Text.*
    Should Be Equal    ${项.attr("text")}    Item 12

测试通过文本获取列表项
    打开列表测试界面

    ${项}    通过文本获取列表项    Scroll View    Item 12
    Should Be Equal    ${项.attr("text")}    Item 12

    ${项}    通过文本获取列表项    Scroll View    Item 12    item_path=?nameMatches=Text.*
    Should Be Equal    ${项.attr("text")}    Item 12

测试获取列表项数量
    打开列表测试界面

    ${数量}    获取列表项数量    Scroll View    item_path=?nameMatches=Text.*
    Should Be Equal As Numbers    ${数量}    13

测试获取所有列表项
    打开列表测试界面

    ${所有项}    获取所有列表项    Scroll View    item_path=?nameMatches=Text.*
    Length Should Be    ${所有项}    13

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

测试手势1
    点击元素    btn_start
    点击元素    text=drag drop

    按住    star
    # 按住    1 secs
    到    shell
    放开

测试手势2
    点击元素    btn_start
    点击元素    text=drag drop

    ${star}    获取元素    star
    ${shell}    获取元素    shell

    按住    ${star}
    # 按住    1 secs
    到    ${shell}
    放开

测试手势3
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
    连接设备
    ${已安装}    是否已安装APP    ${包名}
    IF    ${已安装} == ${False}    安装APP    ${APK路径}
    启动APP    ${包名}
    Sleep    3s

清理用例
    停止APP    ${包名}
