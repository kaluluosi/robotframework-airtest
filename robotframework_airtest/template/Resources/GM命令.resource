*** Settings ***
Documentation       GM命令的封装。原始的发送GM命令关键字语义太差，把常用的GM命令和复杂的GM命令封装好放到这里大家一起用会更好维护。
...                 例如：添加道具，发送完GM命令后会有一大堆的奖励弹窗要清理，可以一起封装到添加道具关键字里处理干净后，那么以后调用这个关键字的
...                 同事就不用重新写一段逻辑去处理弹窗了。

Resource            Poco.resource


*** Keywords ***
添加道具
    [Arguments]    ${道具id}    ${数量}
    # 调用GM命令    $ addItem    1001    1

    Log    下面开始清理弹窗的逻辑
