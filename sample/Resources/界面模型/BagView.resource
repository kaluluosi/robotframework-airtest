*** Settings ***
Documentation    BagView 界面模型文件    注意：这个文件是导出生成的不要修改。


Library    robotframework_airtest.poco.UnityPocoLibrary





*** Variables ***
${BagView}    ?nameMatches\=BagView.*


${BagView.BagView}    ?nameMatches\=BagView.*

${BagView.BagView_Bg}    ?nameMatches\=Bg.*

${BagView.BagView_WhiteLine}    ?nameMatches\=WhiteLine.*

${BagView.BagView_TabBg}    ?nameMatches\=TabBg.*

${BagView.BagView_EmptyBag}    ?nameMatches\=EmptyBag.*

${BagView.BagView_EmptyBag_Image}    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*

${BagView.BagView_EmptyBag_BagView_EmptyBag_Image_2}    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*

${BagView.BagView_EmptyBag_EmptyText}    ?nameMatches\=EmptyBag.*\\?nameMatches\=EmptyText.*

${BagView.BagView_Node}    ?nameMatches\=Node.*

${BagView.BagView_Node_LeftBtnLayout}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*

${BagView.BagView_Node_LeftBtnLayout_WeaponBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*

${BagView.BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*

${BagView.BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*

${BagView.BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_WeaponBtn_WeaponBtnRedPos}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponBtnRedPos.*

${BagView.BagView_Node_LeftBtnLayout_SkillBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*

${BagView.BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*

${BagView.BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*

${BagView.BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_SkillBtn_SkillBtnRedPos}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillBtnRedPos.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllSelect.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllText}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllText.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierSelect.*

${BagView.BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierText}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierText.*

${BagView.BagView_Node_LeftBtnLayout_RuneBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*

${BagView.BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*

${BagView.BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*

${BagView.BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_RuneBtn_RuneBtnRedPos}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneBtnRedPos.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllSelect.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllText}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllText.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitSelect.*

${BagView.BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitText}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitText.*

${BagView.BagView_Node_LeftBtnLayout_PieceBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*

${BagView.BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*

${BagView.BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*

${BagView.BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_PieceBtn_PieceBtnRedPos}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceBtnRedPos.*

${BagView.BagView_Node_LeftBtnLayout_ItemBtn}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*

${BagView.BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*

${BagView.BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*

${BagView.BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect_Text}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*\\?nameMatches\=Text.*

${BagView.BagView_Node_LeftBtnLayout_ItemBtn_ItemBtnRedPos}    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemBtnRedPos.*

${BagView.BagView_Node_SellBtn}    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*

${BagView.BagView_Node_SellBtn_SellText}    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellText.*

${BagView.BagView_Node_SellBtn_SellIcon}    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellIcon.*

${BagView.BagView_Node_ResourceBar}    ?nameMatches\=Node.*\\?nameMatches\=ResourceBar.*

${BagView.BagView_BagSubViewNode}    ?nameMatches\=BagSubViewNode.*

${BagView.BagView_BagSellSubView}    ?nameMatches\=BagSellSubView.*


*** Keywords ***

    

长按BagView
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=BagView.*    ${focus}

    

界面不存在
    [Return]    ${结果}
    ${结果}     元素存在    ${BagView}
    ${结果}    Evaluate    not ${结果}

    

界面必须不存在
    元素必须不存在    ${BagView}

    

点击BagView
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=BagView.*    ${focus}

    

界面必须存在
    [Return]    ${结果}
    ${结果}    元素必须存在    ${BagView}

    

BagView
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=BagView.*

    

界面存在
    [Return]    ${结果}
    ${结果}    元素存在    ${BagView}

    

    

长按BagView_Bg
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Bg.*    ${focus}

    

BagView_Bg
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Bg.*

    

点击BagView_Bg
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Bg.*    ${focus}

    

    

长按BagView_WhiteLine
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=WhiteLine.*    ${focus}

    

BagView_WhiteLine
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=WhiteLine.*

    

点击BagView_WhiteLine
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=WhiteLine.*    ${focus}

    

    

长按BagView_TabBg
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=TabBg.*    ${focus}

    

BagView_TabBg
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=TabBg.*

    

点击BagView_TabBg
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=TabBg.*    ${focus}

    

    

长按BagView_EmptyBag
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=EmptyBag.*    ${focus}

    

BagView_EmptyBag
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=EmptyBag.*

    

点击BagView_EmptyBag
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=EmptyBag.*    ${focus}

    

    

长按BagView_EmptyBag_Image
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*    ${focus}

    

BagView_EmptyBag_Image
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*

    

点击BagView_EmptyBag_Image
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*    ${focus}

    

    

长按BagView_EmptyBag_BagView_EmptyBag_Image_2
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*    ${focus}

    

BagView_EmptyBag_BagView_EmptyBag_Image_2
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*

    

点击BagView_EmptyBag_BagView_EmptyBag_Image_2
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=Image.*    ${focus}

    

    

输入文字BagView_EmptyBag_EmptyText
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=EmptyBag.*\\?nameMatches\=EmptyText.*   ${文本}    ${键盘输入}

    

长按BagView_EmptyBag_EmptyText
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=EmptyText.*    ${focus}

    

点击BagView_EmptyBag_EmptyText
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=EmptyText.*    ${focus}

    

BagView_EmptyBag_EmptyText
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=EmptyBag.*\\?nameMatches\=EmptyText.*

    

获取文字BagView_EmptyBag_EmptyText
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=EmptyBag.*\\?nameMatches\=EmptyText.*

    

    

长按BagView_Node
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*    ${focus}

    

BagView_Node
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*

    

点击BagView_Node
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*    ${focus}

    

    

长按BagView_Node_LeftBtnLayout
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*    ${focus}

    

BagView_Node_LeftBtnLayout
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*

    

点击BagView_Node_LeftBtnLayout
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_WeaponBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_WeaponBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_WeaponBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_WeaponBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*

    

获取文字BagView_Node_LeftBtnLayout_WeaponBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*

    

    

长按BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*

    

点击BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_WeaponBtn_WeaponUnSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponUnSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*

    

点击BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_WeaponBtn_WeaponSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_WeaponBtn_WeaponBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponBtnRedPos.*    ${focus}

    

BagView_Node_LeftBtnLayout_WeaponBtn_WeaponBtnRedPos
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponBtnRedPos.*

    

点击BagView_Node_LeftBtnLayout_WeaponBtn_WeaponBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=WeaponBtn.*\\?nameMatches\=WeaponBtnRedPos.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_SkillBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*

    

获取文字BagView_Node_LeftBtnLayout_SkillBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*

    

    

长按BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*

    

点击BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_SkillBtn_SkillUnSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillUnSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*

    

点击BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_SkillBtn_SkillSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_SkillBtn_SkillBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillBtnRedPos.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillBtn_SkillBtnRedPos
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillBtnRedPos.*

    

点击BagView_Node_LeftBtnLayout_SkillBtn_SkillBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillBtn.*\\?nameMatches\=SkillBtnRedPos.*    ${focus}

    

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*

    

获取文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*

    

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllSelect.*

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllText
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllText.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllText
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllText.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllText
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllText.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllText
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllText.*

    

获取文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillAllBtn_SkillAllText
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillAllBtn.*\\?nameMatches\=SkillAllText.*

    

    

输入文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*

    

获取文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*

    

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierSelect.*

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierText
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierText.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierText
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierText.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierText
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierText.*    ${focus}

    

BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierText
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierText.*

    

获取文字BagView_Node_LeftBtnLayout_SkillSubBtn_SkillSoldierBtn_SkillSoldierText
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=SkillSubBtn.*\\?nameMatches\=SkillSoldierBtn.*\\?nameMatches\=SkillSoldierText.*

    

    

输入文字BagView_Node_LeftBtnLayout_RuneBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*

    

获取文字BagView_Node_LeftBtnLayout_RuneBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*

    

    

长按BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*

    

点击BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_RuneBtn_RuneUnSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneUnSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*

    

点击BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_RuneBtn_RuneSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_RuneBtn_RuneBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneBtnRedPos.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneBtn_RuneBtnRedPos
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneBtnRedPos.*

    

点击BagView_Node_LeftBtnLayout_RuneBtn_RuneBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneBtn.*\\?nameMatches\=RuneBtnRedPos.*    ${focus}

    

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*

    

获取文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*

    

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllSelect.*

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllText
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllText.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllText
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllText.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllText
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllText.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllText
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllText.*

    

获取文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneAllBtn_RuneAllText
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneAllBtn.*\\?nameMatches\=RuneAllText.*

    

    

输入文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*

    

获取文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*

    

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitSelect.*

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitText
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitText.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitText
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitText.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitText
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitText.*    ${focus}

    

BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitText
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitText.*

    

获取文字BagView_Node_LeftBtnLayout_RuneSubBtn_RuneSuitBtn_RuneSuitText
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=RuneSubBtn.*\\?nameMatches\=RuneSuitBtn.*\\?nameMatches\=RuneSuitText.*

    

    

输入文字BagView_Node_LeftBtnLayout_PieceBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_PieceBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_PieceBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_PieceBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*

    

获取文字BagView_Node_LeftBtnLayout_PieceBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*

    

    

长按BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*

    

点击BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_PieceBtn_PieceUnSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceUnSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*

    

点击BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_PieceBtn_PieceSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_PieceBtn_PieceBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceBtnRedPos.*    ${focus}

    

BagView_Node_LeftBtnLayout_PieceBtn_PieceBtnRedPos
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceBtnRedPos.*

    

点击BagView_Node_LeftBtnLayout_PieceBtn_PieceBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=PieceBtn.*\\?nameMatches\=PieceBtnRedPos.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_ItemBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_ItemBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_ItemBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*    ${focus}

    

BagView_Node_LeftBtnLayout_ItemBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*

    

获取文字BagView_Node_LeftBtnLayout_ItemBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*

    

    

长按BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*

    

点击BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_ItemBtn_ItemUnSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemUnSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*    ${focus}

    

BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*

    

点击BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*    ${focus}

    

    

输入文字BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect_Text
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*\\?nameMatches\=Text.*   ${文本}    ${键盘输入}

    

长按BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*\\?nameMatches\=Text.*    ${focus}

    

点击BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect_Text
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*\\?nameMatches\=Text.*    ${focus}

    

BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect_Text
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*\\?nameMatches\=Text.*

    

获取文字BagView_Node_LeftBtnLayout_ItemBtn_ItemSelect_Text
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemSelect.*\\?nameMatches\=Text.*

    

    

长按BagView_Node_LeftBtnLayout_ItemBtn_ItemBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemBtnRedPos.*    ${focus}

    

BagView_Node_LeftBtnLayout_ItemBtn_ItemBtnRedPos
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemBtnRedPos.*

    

点击BagView_Node_LeftBtnLayout_ItemBtn_ItemBtnRedPos
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=LeftBtnLayout.*\\?nameMatches\=ItemBtn.*\\?nameMatches\=ItemBtnRedPos.*    ${focus}

    

    

输入文字BagView_Node_SellBtn
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*   ${文本}    ${键盘输入}

    

长按BagView_Node_SellBtn
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*    ${focus}

    

点击BagView_Node_SellBtn
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*    ${focus}

    

BagView_Node_SellBtn
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*

    

获取文字BagView_Node_SellBtn
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*

    

    

输入文字BagView_Node_SellBtn_SellText
    [Arguments]     ${文本}     ${键盘输入}=${False}
    输入文字    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellText.*   ${文本}    ${键盘输入}

    

长按BagView_Node_SellBtn_SellText
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellText.*    ${focus}

    

点击BagView_Node_SellBtn_SellText
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellText.*    ${focus}

    

BagView_Node_SellBtn_SellText
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellText.*

    

获取文字BagView_Node_SellBtn_SellText
    [Return]    ${文本}
    ${文本}    获取文字    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellText.*

    

    

长按BagView_Node_SellBtn_SellIcon
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellIcon.*    ${focus}

    

BagView_Node_SellBtn_SellIcon
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellIcon.*

    

点击BagView_Node_SellBtn_SellIcon
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=SellBtn.*\\?nameMatches\=SellIcon.*    ${focus}

    

    

长按BagView_Node_ResourceBar
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=Node.*\\?nameMatches\=ResourceBar.*    ${focus}

    

BagView_Node_ResourceBar
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=Node.*\\?nameMatches\=ResourceBar.*

    

点击BagView_Node_ResourceBar
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=Node.*\\?nameMatches\=ResourceBar.*    ${focus}

    

    

长按BagView_BagSubViewNode
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=BagSubViewNode.*    ${focus}

    

BagView_BagSubViewNode
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=BagSubViewNode.*

    

点击BagView_BagSubViewNode
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=BagSubViewNode.*    ${focus}

    

    

长按BagView_BagSellSubView
    [Arguments]     ${focus}=(0.5,0.5)    ${duration}=${Empty}
    长按元素    ?nameMatches\=BagSellSubView.*    ${focus}

    

BagView_BagSellSubView
    [Return]    ${元素对象}
    ${元素对象}    获取元素    ?nameMatches\=BagSellSubView.*

    

点击BagView_BagSellSubView
    [Arguments]     ${focus}=(0.5,0.5)
    点击元素    ?nameMatches\=BagSellSubView.*    ${focus}

    
