//
//  GAVerificationCodeView.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/14.
//  Copyright © 2020 houjianan. All rights reserved.
//

/*
class GAVerificationCodeViewController: UIViewController {
    
    @IBOutlet weak var verificationCodeView: GAVerificationCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func getCode(_ sender: Any) {
        verificationCodeView.updateData(texts: ["1", "7", "2", "5"])
    }
    
}
 */

import UIKit

class GAVerificationCodeView: UIView {
    
    @IBInspectable var countNums: Int = 4
    @IBInspectable var itemWidth: CGFloat = 40
    @IBInspectable var leftPadding: CGFloat = 40
    @IBInspectable var rightPadding: CGFloat = 40
    @IBInspectable var textColor: UIColor = UIColor.lightText
    @IBInspectable var borderColor: UIColor = UIColor.lightText
    @IBInspectable var fontSize: CGFloat = 20
    
    var textFields: [UITextField] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if textFields.count == 0 {
            self._initViews()
        }
    }
    
    private func _initViews() {
        let w: CGFloat = self.frame.size.width - leftPadding - rightPadding
        let space: CGFloat = (w - CGFloat(countNums) * itemWidth) / CGFloat(countNums - 1)
        for i in 0..<countNums {
            let v = UIView()
            v.backgroundColor = UIColor.randomColor()
            let x: CGFloat = leftPadding + (space + itemWidth) * CGFloat(i)
            v.frame = CGRect(x: x, y: 0, width: itemWidth, height: itemWidth)
            v.layer.borderColor = borderColor.cgColor
            self.addSubview(v)
            
            let t = UITextField()
            t.tag = i
            t.delegate = self
            t.textColor = textColor
            t.font = UIFont.systemFont(ofSize: fontSize)
            t.textAlignment = .center
            t.frame = v.bounds
            t.borderStyle = .none
            v.addSubview(t)
            
            textFields.append(t)
        }
    }
    
    public func becomeFirstResponder(index: Int = 0) {
        if index >= textFields.count {
            return
        }
        
        let t = textFields[index]
        t.becomeFirstResponder()
    }
    
    public func updateData(texts: [String]) {
        if texts.count == textFields.count {
            for i in 0..<textFields.count {
                let t = textFields[i]
                let text = texts[i]
                t.text = text
            }
        }
    }
    
    func toVerify() {
        var b: Bool = true
        for i in 0..<textFields.count {
            let t = textFields[i]
            if (t.text ?? "").isEmpty {
                b = false
                break
            }
        }
        if b {
            self.show("去验证...")
        }
    }
    
}

extension GAVerificationCodeView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        let tag = textField.tag
        if _judgeNumbser(string: string) {
            if string.isEmpty {
                textField.text = ""
                if tag != 0 {
                    becomeFirstResponder(index: tag - 1)
                }
                toVerify()
                return false
            } else {
                textField.text = string
                if tag != textFields.count - 1 {
                    becomeFirstResponder(index: tag + 1)
                }
                toVerify()
                return false
            }
        } else {
            toVerify()
            return false
        }
    }
    
    func _judgeNumbser(string: String) -> Bool {
        let cs = NSCharacterSet(charactersIn: "1234567890").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        return (string == filtered)
    }
}

