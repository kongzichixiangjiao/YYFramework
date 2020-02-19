//
//  TableViewCell.swift
//  YYFramework
//
//  Created by houjianan on 2018/8/12.
//  Copyright © 2018年 houjianan. All rights reserved.
//  tableView优化 绘制成图片

import UIKit

class GraphicsEndImageCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var t: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        t.delegate = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let size = self.imgView.size
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            // drawing code here
            let context = UIGraphicsGetCurrentContext()
            context?.move(to: CGPoint(x: 10, y: 10))
            context?.addLine(to: CGPoint(x: 30, y: 60))
            context?.addLine(to: CGPoint(x: 20, y: 20))
            context?.addLine(to: CGPoint(x: 10, y: 10))
            context?.setStrokeColor(UIColor.red.cgColor)
            context?.setLineWidth(2)
            context?.drawPath(using: .stroke)
            let i = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            DispatchQueue.main.async {
                self.imgView.image = i
            }
        }
    }
    
}

