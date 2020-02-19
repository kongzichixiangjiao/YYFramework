//
//  GAHtmlTagViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/21.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GAHtmlTagViewController: UIViewController {

    @IBOutlet weak var l: UILabel!
    @IBOutlet weak var l1: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let s = "我是测试123123123123123123123123123123123123123123123123231231231231232312312312312323123123123123123123123123结尾"
        let style1 = NSMutableParagraphStyle()
        style1.alignment = .left
        style1.lineBreakMode = .byCharWrapping
        style1.lineSpacing = 15
        let attString = NSMutableAttributedString(string: s, attributes: nil)
        attString.addAttributes([NSAttributedString.Key.paragraphStyle : style1], range: NSMakeRange(0, s.count))
        l1.attributedText = attString
        
        let htmlString = "<p style=\"margin-top: 8px; margin-bottom: 8px; white-space: normal; padding: 0px; font-size: 14px; line-height: 1.6em; text-align: justify; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px;\">1、人为善，福虽未至，祸已远离；人为恶，祸虽未至，福已远离。</span></p ><p style=\"margin-top: 8px; margin-bottom: 8px; white-space: normal; padding: 0px; font-size: 14px; line-height: 1.6em; text-align: justify; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px;\">2、不妄求，则心安，不妄做，则身安。</span></p ><p style=\"margin-top: 8px; margin-bottom: 8px; white-space: normal; padding: 0px; font-size: 14px; line-height: 1.6em; text-align: justify; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px;\">3、不自重者，取辱。不自长者，取祸。不自满者，受益。不自足者，博闻。</span></p ><p style=\"margin-top: 8px; margin-bottom: 8px; white-space: normal; padding: 0px; font-size: 14px; line-height: 1.6em; text-align: justify; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px;\">4、积金遗于子孙，子孙未必能守</span></p ><p style=\"margin-top: 8px; margin-bottom: 8px; white-space: normal; padding: 0px; font-size: 14px; line-height: 1.6em; text-align: justify; color: rgb(51, 51, 51); font-family: &quot;Microsoft YaHei&quot;; background-color: rgb(255, 255, 255);\"><span style=\"margin: 0px; padding: 0px;\">1、人为善，福虽未至，祸已远离；人为恶，祸虽未至，福已远离。</span></p >"
        do {
            let style = NSMutableParagraphStyle()
            style.lineSpacing = 5
            style.paragraphSpacing = 30
            let attString = try NSMutableAttributedString(data: htmlString.data(using: String.Encoding.unicode)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
            attString.addAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], range: NSMakeRange(0, attString.length))
            attString.addAttributes([NSAttributedString.Key.paragraphStyle : style], range: NSMakeRange(0, attString.length))
            l.attributedText = attString
        } catch {
            l.text = htmlString
        }
    }

}
