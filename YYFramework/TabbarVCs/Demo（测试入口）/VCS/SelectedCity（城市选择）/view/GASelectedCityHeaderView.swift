//
//  GASelectedCityHeaderView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/14.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GASelectedCityHeaderView: UIView {

    @IBOutlet weak var nameLabel: UILabel!
    static func loadSelectedCityHeaderView() -> GASelectedCityHeaderView {
        let v = Bundle.main.loadNibNamed("GASelectedCityHeaderView", owner: self, options: nil)?.last as! GASelectedCityHeaderView
        return v 
    }
}
