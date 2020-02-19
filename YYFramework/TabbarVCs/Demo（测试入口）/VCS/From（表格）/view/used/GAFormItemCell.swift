//
//  GAFormItemCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/20.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAFormItemCell: UITableViewCell {

    @IBOutlet weak var l: UILabel!
    
    var items: [GAFormRowModel]?
    var configModel: GAFormConfigModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        while (self.contentView.subviews.count != 0) {
            self.contentView.subviews.last?.removeFromSuperview()
        }
        guard let items = self.items else {
            return
        }
        
        for (i, item) in items.enumerated() {
            let w: CGFloat = self.configModel.rItemWidth
            let x: CGFloat = CGFloat(i) * w
            let y: CGFloat = 0
            let h: CGFloat = self.contentView.height
            let l = GAStrokeLabel(frame: CGRect(x: x, y: y, width: w, height: h))
            l.strokeColor = UIColor.lightGray
            l.font = UIFont.systemFont(ofSize: 10)
            l.textAlignment = .center 
            l.text = item.title
            self.contentView.addSubview(l)
        }
    }
}
