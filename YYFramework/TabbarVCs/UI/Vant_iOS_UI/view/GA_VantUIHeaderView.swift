//
//  GA_VantUIHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/5.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GA_VantUIHeaderViewDelegate: class {
    func ga_VantUIHeaderViewClicked(section: Int)
}

class GA_VantUIHeaderView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: GA_VantUIHeaderViewDelegate?
    
    var section: Int = -1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if section != -1 {
            delegate?.ga_VantUIHeaderViewClicked(section: section)
        }
    }
}
