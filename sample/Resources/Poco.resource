*** Settings ***
Documentation       每个项目所用的引擎不一样，所以用的PocoLibrary也不一样，把PocoLibrary测试库的统一引入放到这里来统一修改
...                 以后测试脚本中尽量引入这个资源来引入项目的PocoLibrary，代替直接用 Library去引用

Library             robotframework_airtest.poco.UnityPocoLibrary
