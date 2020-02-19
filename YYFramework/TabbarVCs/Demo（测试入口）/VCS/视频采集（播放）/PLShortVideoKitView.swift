//
//  PLShortVideoKitView.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/6.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

enum PLShortVideoKitViewType: Int {
    case record = 0, back = 1, postion = 2, upload = 3
}

protocol PLShortVideoKitViewDelegate: class {
    // 1 = 录制开始、前置摄像头  2 = 录制结束、后置摄像头
    func shortVideoKitView(buttonType: PLShortVideoKitViewType, clickedType: Int)
}

class PLShortVideoKitView: UIView {

    weak var delegate: PLShortVideoKitViewDelegate?
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var positionButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func upload(_ sender: UIButton) {
        delegate?.shortVideoKitView(buttonType: .upload, clickedType: sender.isSelected ? 1 : 0)
    }
    
    // 录制开始与结束
    @IBAction func record(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.shortVideoKitView(buttonType: .record, clickedType: sender.isSelected ? 1 : 0)
    }
    
    // 返回
    @IBAction func back(_ sender: UIButton) {
        delegate?.shortVideoKitView(buttonType: .back, clickedType: -1)
    }
    
    // 摄像头前与侯
    @IBAction func position(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        delegate?.shortVideoKitView(buttonType: .postion, clickedType: sender.isSelected ? 1 : 0)
    }
}
