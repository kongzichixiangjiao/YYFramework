//
//  TipsXibView.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

enum TipsType {
    case textOnly, loading
}

class TipsXibView: UIView {

    @IBOutlet weak var textOnlyBgView: UIView!
    @IBOutlet weak var loadingBgView: UIView!
    @IBOutlet weak var textOnly: UILabel!
    
    var type: TipsType = .textOnly {
        didSet {
            switch type {
            case .textOnly:
                self.textOnlyBgView.isHidden = false
            case .loading:
                self.loadingBgView.isHidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
