//
//  GATagsViewModel.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/11.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

class GATagsViewModel {
    var fontSize: CGFloat = 14
    var tagMinHeight: CGFloat = 34  // 按钮最小高度
    var tagMinWidth: CGFloat = 28   // 内容最小宽度
    
    var leftSpace: CGFloat = 10     //tag起始的左边距
    var rightSpace: CGFloat = 10    // 一行最后一个tag的右边距
    var topSpace: CGFloat = 0
    var bottomSpace: CGFloat = 0    //
    
    var tagRowSpace: CGFloat = 5   // 每个tag的行间隔（上下）
    var tagColumnSpace: CGFloat = 10    // 每个tag的列间隔（左右）
    
    var tagMargin: CGFloat = 18 // 字距离按钮左右边距
    
    var maxRows: Int = 10    // 最多显示行数，默认3行
    
    var bNormalTextColor: UIColor = "999999".tagsView_color0X       // 按钮普通状态字体颜色
    var bSelectedTextColor: UIColor = "333333".tagsView_color0X     // 按钮选择状态字体颜色
    
    var bNormalBackColor: UIColor = "FFFFFF".tagsView_color0X       // 按钮普通状态背景颜色
    var bSelectedBackColor: UIColor = "EFF6FD".tagsView_color0X     // 按钮选择状态背景颜色
    
    var bNormalBorderColor: UIColor = "D8D9D9".tagsView_color0X     // 按钮普通状态描边颜色
    var bSelectedBorderColor: UIColor = "EFF6FD".tagsView_color0X   // 按钮选择状态描边颜色
    
    var isShowLastButton: Bool = true   // 是否展示最后一个icon按钮
    var lastButtonIcon: String = "ic_link_48pt"
    
    
    var isShowEditView: Bool = false
    var editViewHeight: CGFloat = 30
    var editViewWidth: CGFloat = 200
    
    var isRadio: Bool = false // 按钮是否是单选
    
    var isAlwaysShowMoreButton: Bool = true
    var moreButtonWidth: CGFloat = 80
    var moreButtonShowAllTitle: String = "收起"
    var moreButtonShowAllIcon: String = "tags_moreBtn_icon_down"
    var moreButtonShow3Title: String = "更多"
    var moreButtonShow3Icon: String = "tags_moreBtn_icon_up"
}

class GATagsButtonModel {
    var name: String = ""
    var icon: String = ""
    var code: String = ""
    var isSelected: Bool = false
    var isLast: Bool = false
}
