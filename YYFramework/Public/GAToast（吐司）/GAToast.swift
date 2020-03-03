//
//  GAToast.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/29.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

enum GAToastType: Int {
    // 0 小菊花， 1 提交成功， 2 提交失败， 3 操作成功， 4 操作失败， 5 t文案提醒
    case loading = 0, submit_success = 1, submit_failure = 2, operate_success = 3, operate_error = 4, message = 5
}

class GAToast: UIView {
    
    // .submit_success .submit_failure .operate_success .operate_error
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var alertLabel: UILabel!
    // .message
    @IBOutlet weak var messageLabel: UILabel!
    
    var type: GAToastType! {
        didSet {
            
        }
    }
    
    static func loadToastView(type: GAToastType) -> GAToast {
        let views = Bundle.main.loadNibNamed("GAToast", owner: nil, options: nil) as! [UIView]
        return views[type.rawValue] as! GAToast
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
