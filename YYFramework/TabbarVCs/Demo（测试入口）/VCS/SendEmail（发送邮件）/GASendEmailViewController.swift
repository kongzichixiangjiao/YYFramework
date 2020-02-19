//
//  GASendEmailViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/7.
//  Copyright © 2020 houjianan. All rights reserved.
//  发送邮件Email 发送短信 发送信息

import UIKit
import MessageUI

class GASendEmailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            vc.mailComposeDelegate = self
            // 收件人
            let sendToPerson = "houjianan_110@163.com" // 
            vc.setToRecipients([sendToPerson])
            // 抄送
            let copyToPerson = ""
            vc.setCcRecipients([copyToPerson])
            vc.setSubject("天津瑞辰") // 猪蹄
            self.present(vc, animated: true, completion: nil)
            vc.setMessageBody("我是测试测试", isHTML: false)
        } else {
            self.view.ga_showView("您是否安装邮件App")
        }
        
    }
    
    @IBAction func sendMessage(_ sender: Any) {
        let vc = MFMessageComposeViewController()
        vc.messageComposeDelegate = self 
        vc.recipients = ["10086"]
        self.present(vc, animated: true, completion: nil)
        vc.viewControllers.last?.navigationItem.title = "title"
    }
    
    @IBAction func systemSendEmail(_ sender: Any) {
        let email = "houjianan_110@163.com"
        guard let url = URL(string: "mailto:\(email)") else {
            self.view.ga_showView("有问题的URl")
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        } else {
            self.view.ga_showView("此设备不支持")
        }
    }
    
}

extension GASendEmailViewController: MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch (result) {
        case .cancelled:
            self.view.ga_showView("取消发送")
            break
        case .failed:
            self.view.ga_showView("发送失败")
            break
        case .saved:
            self.view.ga_showView("保存草稿文件")
            break
        case .sent:
            self.view.ga_showView("发送成功")
            break
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            self.view.ga_showView("取消发送")
            break
        case .failed:
            self.view.ga_showView("发送失败")
            break
        case .sent:
            self.view.ga_showView("发送成功")
            break
        default:
            break
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}
