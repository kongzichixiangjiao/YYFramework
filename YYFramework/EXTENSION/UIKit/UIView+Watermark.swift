//
//  UIView+Watermark.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/21.
//  Copyright © 2019 houjianan. All rights reserved.
//  添加水印方法

import UIKit

extension UIView {
    /*
     *  text 水印内容
     *  color 水印颜色
     *  font 水印字体
     *  fontSize 水印字体大小
     *  lineCount 竖着展示文案个数
     *  rowCount 横着展示文案个数
     *  lineSpace 竖着水印内容间距
     *  rowSpace 横着水印内容间距
     *  leftSpace
     *  topSpace
     *  rotationAngle 水印旋转角度
     *
     *  水印居中展示
     */
    func ga_addWaterText(text: NSString, color: UIColor = UIColor.black, font: UIFont = UIFont.systemFont(ofSize: 14), fontSize: CGFloat = 14, lineCount: Int = 1, rowCount: Int = 1, lineSpace: CGFloat = 20, rowSpace: CGFloat = 20, leftSpace: CGFloat = 20, topSpace: CGFloat = 20, rotationAngle: CGFloat = CGFloat(-Double.pi / 16)) {
        
        let waterText:String = text as String
        
        let textSize: CGSize = waterText.watermark_sizeWithText(font: UIFont.systemFont(ofSize: fontSize))
        let textW: CGFloat = textSize.width
        let textH: CGFloat = textSize.height
        
        let _lineSpace: CGFloat = textH + lineSpace
        let _rowSpace: CGFloat = textW + rowSpace

//            for i in  0...lineCount - 1 {
//                for j in 0...rowCount - 1 {
//                let textLayer = CATextLayer.init()
//                textLayer.contentsScale = UIScreen.main.scale
//                textLayer.font = font
//                textLayer.fontSize = font.pointSize
//                textLayer.foregroundColor = color.cgColor
//                textLayer.string = "line:" + String(i) + "row:" + String(j)
//                let hSpace = CGFloat(j) * _rowSpace + leftSpace + ((i % 2 == 0) ? textW : 0)
//                let vSpace = CGFloat(i) * _lineSpace + topSpace
//
//                textLayer.frame = CGRect(x: hSpace, y: vSpace, width: textW, height: textH)
//
//                textLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 3)
//
//                self.layer.masksToBounds = true
//                self.layer.addSublayer(textLayer)
//            }
//        }
        
        for i in  0...lineCount - 1 {
            for j in 0...rowCount - 1 {
                let textLayer = CATextLayer.init()
                textLayer.contentsScale = UIScreen.main.scale
                textLayer.font = font
                textLayer.fontSize = font.pointSize
                textLayer.foregroundColor = color.cgColor
                textLayer.string = waterText
                let hSpace = CGFloat(j) * _rowSpace + leftSpace
                let vSpace = CGFloat(i) * _lineSpace + topSpace

                textLayer.frame = CGRect(x: hSpace, y: vSpace, width: textW, height: textH)

                textLayer.transform = CATransform3DMakeRotation(rotationAngle, 0, 0, 3)

                self.layer.masksToBounds = true
                self.layer.addSublayer(textLayer)
            }
        }
    }
    
    func ga_removeTextLayer(water: String)  {
        guard let layers = self.layer.sublayers else {
            return
        }
        var sublayers = [CALayer]()
        
        for (_, layer) in layers.enumerated() {
            if layer.isKind(of: CATextLayer.self) {
                let textLayer = layer as! CATextLayer
                let waterText:String = textLayer.string as! String
                guard water == waterText else {
                    return
                }
            } else {
                sublayers.append(layer)
            }
        }
        
        self.layer.sublayers = sublayers
    }
    
}

extension String{
    func watermark_sizeWithText(font: UIFont) -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect:CGRect = self.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude), options: option, attributes: attributes, context: nil)
        return rect.size
    }
}
