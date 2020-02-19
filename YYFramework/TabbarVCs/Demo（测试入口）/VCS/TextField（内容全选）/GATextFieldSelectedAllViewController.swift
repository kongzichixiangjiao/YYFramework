//
//  GATextFieldSelectedAllViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/18.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GATextFieldSelectedAllViewController: GANavViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        b_showNavigationView(title: "文本框内容全选")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.clearsOnInsertion = true
    }

}

extension GATextFieldSelectedAllViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let endDocument = textField.endOfDocument
        guard let end = textField.position(from: endDocument, offset: 0) else {
            return
        }
        guard let start = textField.position(from: end, offset: -textField.text.length) else {
            return
        }
        textField.selectedTextRange = textField.textRange(from: start, to: end)
    }
}

extension GATextFieldSelectedAllViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard let f = textView.position(from: textView.beginningOfDocument, in: .right, offset: 2) else {
            return
        }
        guard let t = textView.position(from: textView.endOfDocument, in: .left, offset: 2) else {
            return
        }
        let r = textView.textRange(from: f, to: t)
        textView.selectedTextRange = r
    }
}
