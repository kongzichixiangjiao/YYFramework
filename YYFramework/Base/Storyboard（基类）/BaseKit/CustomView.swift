//
//  CustomView.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBInspectable var selectedColor: UIColor = 0xE0E0E0.color
    @IBInspectable var normalColor: UIColor = UIColor.white
    
    @IBOutlet var selectionView: UIView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionView?.backgroundColor = selected ? selectedColor : normalColor
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.selectionView?.backgroundColor = highlighted ? selectedColor : normalColor
    }
    
}
