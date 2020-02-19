//
//  ZHADCollectionCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class ZHADCollectionCell: UICollectionViewCell {
    
    lazy var adView: YYTableADView = {
        var models: [YYTableADViewModel] = []
        for i in 0...4 {
            let model = YYTableADViewModel()
            model.text = "消息第" + "\(i)" + "条"
            models.append(model)
        }
        let v = YYTableADView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: kYYScrollADViewHeight), models: models)
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addSubview(adView)
    }

}
