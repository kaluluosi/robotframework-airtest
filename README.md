# Robotframework-Airtest

- [Robotframework-Airtest](#robotframework-airtest)
  - [说明](#说明)
  - [特性介绍](#特性介绍)
  - [开发环境](#开发环境)
  - [安装](#安装)
  - [用法](#用法)
  - [文档](#文档)

![Snipaste_2021-05-19_18-06-39](https://i.loli.net/2021/09/17/X74IP5r2QsSt6cw.png)

## 说明

Airtest + RobotFramework 简称 Robotframework-Airtest
Robotframework-Airtest是结合了Airtest和关键字驱动自动化测试框架RobotFramwork的测试方案.

旧版的Airtest是用Python的`unittest`作为测试框架驱动的,实践的过程中主要有以下缺点:

1. 对测试人员编程技能有一定的要求,必须熟悉python语言和一些程序能力.
2. 写出来的测试脚本逻辑可以很繁杂,相对难以阅读和维护.
3. 游戏迭代,UI界面结构发生变化,无法快速的定位所有过时的代码,必须不断地执行用例每次执行用例只能发现和修复一次错误,维护起来投入太多.
4. 查找UI元素和有效的处理需要经验积累.比如列表滚动等比较复杂的操作需要花很多精力.
5. 没有类似uiautomater的UIWatcher机制.游戏中各种意外的弹窗层出不穷,每一个都有可能会打断流程的执行,XTester并不支持UI观察者这样的"当发现界面时就xxx"这样的机制.
6. 配套的开发调试工具环境不友好

最终我们规划出了理想中的自动化测试方案:

1. 要对编程能力要求不高,最好支持中文,就像策划配表用的中文接口一样去写测试用例.
2. 对界面的按钮,列表等基本控件元素封装操作接口,直接操作无需写一堆代码去处理.
3. 面向界面模型测试,测试工程师不再需要自己去找空间元素,而是直接通过生成的界面模型去操作界面.
4. UI观察者机制,能够发现界面的时候插入进去处理异常界面.
5. 干跑测试,提前发现测试用例中所有过时的问题,快速搜集修复.
6. 有配套的开发调试工具,IDE用VSCODE+robotframework-lsp插件, 智能提示,语法高亮,自动完成,乃至断点调试都有.

最终这些就成了Robotframework-Airtest方案的重要特性.

## 特性介绍

**中文关键字编程**
用符合人类语言语义的方式编写测试脚本
```robotframework
*** Test Cases ***
修改签名
    # [Tags]    DEBUG
    ${签名}    Set Variable    abcdefg
    userInfoViewUI.输入文字默认_EditLabSign    ${签名}    ${True}
    点击屏幕中间
    界面打开流程.关闭个人信息界面
    界面打开流程.打开个人信息界面
    ${获取签名}    userInfoViewUI.获取文字默认_EditLabSign
    Should Be Equal    ${签名}    ${获取签名}    签名
```

**面向界面模型测试**
不在原始的一个个查找界面元素,直接引用高度封装的界面模型,对界面模型进行操作.界面模型已经封装好查询元素和简单的点击操作关键字.
```robotframework
*** Test Cases ***
修改签名
    ...
    userInfoViewUI.输入文字默认_EditLabSign    ${签名}    ${True}
    ...
```


**前端界面资源(Prefab,Axon UI Lua配置)导出界面模型**
内置界面Prefab导出界面模型资源脚本。

**"Dry Run" 预测试提前发现用例错误**
界面发生改动,元素路径变化,更新界面模型后执行"Dry Run""干跑"快速过一遍所有用例,找出已经无效的关键字,并定位到脚本。

**多语言支持**
内置多语言资源文件,脚本内使用的字符串变量定义在多语言资源文件中,测试执行的时候传入"-v LANGAGE:语言"来控制读取哪个语言表实现多语言切换.

**界面观察者**
注册监控关键字,每一次关键字执行的时候会先执行监控关键字,条件成立就执行.以此来解决操作过程中意外弹的检测和处理.
```robotframework
*** Test Cases ***
示例用例
    监控UI    如果 userInfoViewUI.界面存在 那么 userInfoViewUI.点击BtnClose
    ...
```

**数据驱动测试**
Robotframework提供的测试模板(Template)功能,可以将测试用例变成以空格为分隔符的表格,传入模板关键字中执行测试.
```robotframework
*** Test Cases ***
示例数据驱动
    [Template]    修改昵称
    1234    Success
    \#$%^&*  Fail
    ${Empty}    Fail
    你好    Success
    ...
```

**无人值守自动化**
登入，登出，自动创角....等关键字提供了无中断连续运行测试用例的能力。

**Robotfromework报告+Airtest报告结合**

**测试报告屏录支持**
同时支持PC端,手机端测试的屏录.(原本只支持手机端屏录)

**Jenkins自动化测试构建**
给出了完整的构建参数配置,配合Robotframework的Jenkins插件,实现无人值守自动化测试和报告输出.


## 开发环境

**VSCode**

下载安装[VSCode](https://code.visualstudio.com/), 略过。

VSCode插件安装:
- Robotframework Langage Server

**Python安装**

Python 3.8~3.9，32bit 64bit都可以，只不过用32bit的Python去控制64bit的游戏Windows客户端会有警告，不影响忽略即可。


## 安装

```shell
pip install http://git.xinyuanact.com/qc/Robotframework-Airtest/xtester_robot/-/archive/main/xtester_robot-main.zip
```

将来Robotframework-Airtest 修bug或者新增功能发布后，可以通过下面命令直接更新。
```shell
pip install -U http://git.xinyuanact.com/qc/Robotframework-Airtest/xtester_robot/-/archive/main/xtester_robot-main.zip

```

## 用法

安装完后可以在命令行使用 xr 命令

```shell
ra --help
Usage: xr [OPTIONS] COMMAND [ARGS]...

  ================================================================
  Robotframework-Airtest 自动化测试框架
  ================================================================

Options:
  --help  Show this message and exit.

Commands:
  start  创建模板项目
  docs   打开文档
  vmg    界面模型导出工具
```

## 文档

[Robotframework-Airtest教程文档]()
