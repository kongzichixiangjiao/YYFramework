//
//  PXAnswerQuestionsAlertViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/13.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import GAAlertPresentation

class PXAnswerQuestionsAlertViewController: PXEditAlertBaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if registerNotification {
            _registerNotification()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.textView.becomeFirstResponder()
    }
}

extension PXAnswerQuestionsAlertViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        clickedHandler?(1, textView.text)
    }
}
