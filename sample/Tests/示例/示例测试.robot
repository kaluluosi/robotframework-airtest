*** Settings ***
Resource            ../../Resources/Poco.resource
Resource            ../../Resources/初始化.resource
Resource            ../../Resources/界面模型/BagView.resource    # 导入界面模型

Suite Setup         测试集通用设置
Suite Teardown      测试集通用清理
Test Setup          用例通用设置
Test Teardown       用例通用清理


*** Test Cases ***
示例用例
    Log    Hello World!    console=True

    BagView.界面存在    # 断言背包界面是否存在

    元素必须存在    ${BagView.BagView_Node_SellBtn}    # 断言SellBtn存在
    BagView.点击BagView_Node_SellBtn    # 点击SellBtn

测试滑动列表
    点击元素    btn_start
    点击元素    list_view
    滑动列表    Scroll View    vertical    0.5
    点击元素    text=Item 12
    ${选中项}    获取文字    list_view_current_selected_item_name
    Should Be Equal    ${选中项}    Item 12
