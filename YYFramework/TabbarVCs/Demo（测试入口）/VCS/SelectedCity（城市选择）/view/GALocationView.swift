//
//  GALocationView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/14.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GALocationViewDelegate: class {
    func locationViewClicked(text: String)
}

class GALocationView: UIView {

    weak var delegate: GALocationViewDelegate?
    
    @IBOutlet weak var locationLabel: UILabel!
    
    static func loadLocationView() -> GALocationView {
        let v = Bundle.main.loadNibNamed("GALocationView", owner: self, options: nil)?.last as! GALocationView
        return v
    }
    
    @IBAction func clicked(_ sender: Any) {
        delegate?.locationViewClicked(text: locationLabel.text ?? "")
    }
    
}
