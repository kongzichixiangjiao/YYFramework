//
//  YYADCellView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYADCellView: UITableViewCell {

    static let identifier1 = "YYADCellView"
    
    @IBOutlet weak var mTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
