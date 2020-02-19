//
//  GAFormLeftHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GAFormLeftHeaderViewDelegate: class {
    func ga_formLeftHeaderViewDelegateClicked(section: Int)
}

class GAFormLeftHeaderView: UIView {
    
    @IBOutlet weak var nameLabel: UILabel!

    var delegate: GAFormLeftHeaderViewDelegate?
    
    var section: Int = -1
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if section != -1 {
            delegate?.ga_formLeftHeaderViewDelegateClicked(section: section)
        }
    }
    
    var items: [GAFormRowModel]?

}
