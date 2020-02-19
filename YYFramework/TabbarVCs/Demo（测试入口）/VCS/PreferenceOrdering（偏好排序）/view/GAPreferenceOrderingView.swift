//
//  GAPreferenceOrderingView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/15.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GAPreferenceOrderingViewDelegate: class {
    func preferenceOrderingViewClicked(btn: UIButton)
}

class GAPreferenceOrderingView: UIView {

    weak var delegate: GAPreferenceOrderingViewDelegate?
    
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    
    var buttons: [UIButton] = []
    
    var resultTitles: [String]! {
        get {
            return [(b1.titleLabel?.text ?? ""), (b2.titleLabel?.text ?? ""), (b3.titleLabel?.text ?? "")]
        }
    }
    
    static func loadPreferenceOrderingView() -> GAPreferenceOrderingView {
        let v = Bundle.main.loadNibNamed("GAPreferenceOrderingView", owner: self, options: nil)?.last as! GAPreferenceOrderingView
        return v 
    }
    
    @IBAction func b1(_ sender: UIButton) {
        delegate?.preferenceOrderingViewClicked(btn: sender)
    }
    
    @IBAction func b2(_ sender: UIButton) {
        delegate?.preferenceOrderingViewClicked(btn: sender)
    }
    
    @IBAction func b3(_ sender: UIButton) {
        delegate?.preferenceOrderingViewClicked(btn: sender)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        buttons = [b1, b2, b3]
    }
    
    public func setUpViews(b: UIButton, t: String) {
        for item in buttons {
            if b == item {
                b.setTitle(t, for: UIControl.State.normal)
            } else {
                if item.titleLabel?.text == t {
                    item.setTitle("请选择", for: UIControl.State.normal)
                }
            }
        }
    }
    
}
