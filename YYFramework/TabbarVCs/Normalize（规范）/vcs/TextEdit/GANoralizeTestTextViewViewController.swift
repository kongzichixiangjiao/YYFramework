//
//  GANoralizeTestTextViewViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/14.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANoralizeTestTextViewViewController: UIViewController {

    @IBOutlet weak var textView: GANormalizeTextView!
    @IBOutlet weak var textView0: GANormalizeTextView!
    @IBOutlet weak var textView1: GANormalizeTextView!
    @IBOutlet weak var textView2: GANormalizeTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.mDelegate = self
        textView0.mDelegate = self
        textView1.mDelegate = self
        textView2.mDelegate = self
        
        let v = GANormalizeTextView(frame: CGRect(x: 0, y: self.view.height - 50, width: self.view.width, height: 50))
        v.mDelegate = self
        v.tag = 4
        self.view.addSubview(v)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("GANoralizeTestTextViewViewController deinit")
    }

}

extension GANoralizeTestTextViewViewController: GANormalizeTextViewDelegate {
    func normalizeTextViewPlaceholdView(textView: GANormalizeTextView) -> UIView {
        let l = UILabel()
        l.frame = CGRect(x: 0, y: 0, width: 100, height: 15)
        l.font = textView.font
        l.textColor = UIColor.white 
        if textView.tag == 0 {
            l.text = "只能输入数字"
        }
        if textView.tag == 1 {
            l.text = "只能输入汉字"
        }
        if textView.tag == 2 {
            l.text = "只能输入字母"
        }
        if textView.tag == 3 {
            l.text = "只能输入字母和数字"
        }
        if textView.tag == 4 {
            l.text = "只能输入字母和数字"
        }
        return l
    }
    
    func normalizeTextViewContentOffset(textView: GANormalizeTextView) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func normalizeTextViewRegularString(textView: GANormalizeTextView) -> String {
        return ""
//        return "[a-zA-Z0-9]"
    }
    
//    func normalizeTextViewCursorPosition(textView: GANormalizeTextView) -> CGRect {
//        return CGRect(x: 0, y: 0, width: 8, height: 20)
//    }
}
