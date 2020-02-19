//
//  GAChartsViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/22.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class GAChartsViewController: GANavViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "ChartsView")
        
        let v = GABarChartView(frame: CGRect(x: 10, y: 100, width: kScreenWidth - 20, height: 200))
        v.backgroundColor = UIColor.lightGray
        self.view.addSubview(v)
        //        self.view.ga_addLayout(top: 100, left: 10, right: 10, height: 300, item: v, toItem: self.view)
        
    }
    
}


class GAChartsView: UIView {
    
}


class GABarChartView: GAChartsView {
    // MARK: GABarChartView边距
    var selfTopPadding: CGFloat = 30.0
    var selfBottomPadding: CGFloat = 30.0
    
    // MARK: X轴相关
    var xData: [String] = ["大一", "大二", "大三", "大四", "1", "2", "3", "4", "5", "168", "160", "last"] // x轴数据源
    var xFontSize: CGFloat = 10.0
    var xFontColor: UIColor = UIColor.black
    var xRotation: CGFloat = CGFloat.pi / 2.3 // x轴字体倾斜角度
    
    // MARK: Y轴相关
    var yData: [Double] = [400.0, 50.00, 60.00, 100.00, 200.0, 100.00, 200.00, 300.00, 130.00, 168, 160, 400] // y轴数据源
    var yLineData: [String] = ["0.00", "100.00", "400.00"] // y轴分割数据源
    var yUnit: String = "w" // y轴数据源单位
    var yFontSize: CGFloat = 10.0
    var yFontColor: UIColor = UIColor.black
    var yLeftPadding: CGFloat = 10.0
    var ylineCount: Int = 6
    
    // MARK: 柱子相关
    var barData: [String] = [] // 柱子数据源
    var barColors: [String] = [] // 柱子颜色值
    var barSpace: CGFloat = 10.0 // 柱子之间的距离
    var barLeftSpace: CGFloat = 30.0 // 第一根柱子距离左侧距离
    var barWidth: CGFloat = 50.0 // 柱子的宽
    var barFontSize: CGFloat = 9.0 // 柱子上字大小
    var barFontColor: UIColor = UIColor.black // 柱子上字颜色
    
    // MARK: 私有
    private var _yPoinst: [CGPoint] = [] // y 轴文案的点
    private var _lineViews: [UIView] = [] // 分割线
    private var _yDataMaxWidth: CGFloat = 0.0 // y轴数据源最大宽度
    private var _xDataMaxHeight: CGFloat = 0.0 // x轴数据源最大高度
    private var _xRightPadding: CGFloat = 10.0 // x轴数据到右侧线的距离
    private var _xLineY: CGFloat = 0 // x轴线的Y
    private var _barContentLayerW: CGFloat = 0.0 // 柱子界面的总宽度
    private var _oneLineSpace: CGFloat = 0.0 // 每份占比
    private var _yMax: Double = 0.0 // 数据中最大值
    
    // MARK: 私有layer
    private var _barContentLayer: CALayer = CALayer()
    private var _barScrollLayer: CAScrollLayer = CAScrollLayer()
    private var _xContentLayer: CALayer = CALayer()
    private var _xScrollLayer: CAScrollLayer = CAScrollLayer()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        _drawY()
        _drawLine()
        _drawX()
        _initViews()
        _initGestureRecognizer()
    }
    
    // MARK: 手势
    private func _initGestureRecognizer() {
        //给view添加UIPanGestureRecognizer
        let pan = UIPanGestureRecognizer(target: self, action: #selector(_pan(sender:)))
        self.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(_tap(sender:)))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: 画Y轴
    private func _drawY() {
        _yMax = yData.max() ?? 0.0
        _oneLineSpace = (self.frame.size.height - selfTopPadding - selfBottomPadding) / CGFloat(_yMax)
        
        var newYData = [String]()
        if yLineData.count == 0 {
            for i in 0...ylineCount {
                let a = _yMax / Double(ylineCount) * Double(i)
                newYData.insert(String(format: "%.2f", a), at: 0)
            }
        } else {
            newYData = yLineData.reversed()
            ylineCount = yLineData.count
        }
        
        for i in 0..<newYData.count {
            // 绘制y轴文案
            let text = newYData[i]
            let s: NSString = (text + yUnit) as NSString
            let textW = text.char_widthWith(yFontSize, height: yFontSize)
            if textW >= _yDataMaxWidth {
                _yDataMaxWidth = textW
            }
            let textAttributes: [NSAttributedString.Key : Any] = [.font : yFontSize.char_font, .foregroundColor : yFontColor]
            let lienY = selfTopPadding + _oneLineSpace * (CGFloat(_yMax) - (text.ga_toCGFloat(digits: 0) ?? 0.0))
            let textPoint = CGPoint(x: yLeftPadding, y: lienY - yFontSize)
            s.draw(at: textPoint, withAttributes: textAttributes)
            let linePoint = CGPoint(x: yLeftPadding, y: lienY)
            _yPoinst.append(linePoint)
        }
    }
    
    // MARK: 画线
    private func _drawLine() {
        let w: CGFloat = self.frame.size.width

        for i in 0..<_yPoinst.count {
            let point = _yPoinst[i]
            // 绘制分割线
            let scale = 1.0 / UIScreen.main.scale
            let path = UIBezierPath.init()
            let lineY: CGFloat = point.y
            let sP = CGPoint(x: point.x + _yDataMaxWidth + _xRightPadding, y: lineY)
            path.move(to: sP)
            let tP = CGPoint(x: w, y: lineY)
            path.addLine(to: tP)
            path.lineWidth = (i == _yPoinst.count - 1) ? 1.0 : scale
            UIColor.orange.setStroke()
            path.stroke()
            
            if i == _yPoinst.count - 1 {
                _xLineY = lineY
            }
        }
    }
    
    // MARK: 画X轴
    private func _drawX() {
        let x = yLeftPadding + _yDataMaxWidth + _xRightPadding
        let h = _xLineY - selfTopPadding
        let w = self.frame.size.width
        
        _barContentLayerW = CGFloat(xData.count) * (barWidth + barSpace) + barLeftSpace
        
        _xScrollLayer.backgroundColor = UIColor.clear.cgColor
        _xScrollLayer.frame = CGRect(x: x, y: _xLineY, width: w - x, height: h)
        _xScrollLayer.scrollMode = .horizontally
        _xScrollLayer.masksToBounds = true
        self.layer.addSublayer(_xScrollLayer)
        
        _xContentLayer.backgroundColor = UIColor.clear.cgColor
        _xContentLayer.contents = UIImage(named: "tianmolei")?.cgImage
        _xContentLayer.contentsScale = 0.4
        _xContentLayer.frame = CGRect(x: 0, y: 0, width: _barContentLayerW, height: h)
        _xScrollLayer.addSublayer(_xContentLayer)
        
        for i in 0..<xData.count {
            // 绘制x轴文案c
            let text = xData[i]
            let textW = text.char_widthWith(yFontSize, height: yFontSize)
            
            let c = CATextLayer()
            c.contentsScale = UIScreen.main.scale
            let y: CGFloat = 5.0
            let w: CGFloat = textW  + yFontSize * cos(xRotation)
            let x: CGFloat = CGFloat(i) * (barSpace + barWidth) + barLeftSpace + barWidth / 2 - w / 2
            let h: CGFloat = yFontSize + yFontSize * sin(xRotation)
            c.frame = CGRect(x: x, y: y, width: w, height: h)
            c.transform = CATransform3DMakeRotation(xRotation, 0, 0, 3)
            c.string = text
            c.fontSize = yFontSize
            c.foregroundColor = xFontColor.cgColor
            _xContentLayer.addSublayer(c)
            if h >= _xDataMaxHeight {
                _xDataMaxHeight = h
            }
        }
    }
    
    // MARK: 画柱子
    private func _initViews() {
        let x = yLeftPadding + _yDataMaxWidth + _xRightPadding
        let w = self.frame.size.width
        let y: CGFloat = 0.0
        let h = _xLineY - y
        
        _barScrollLayer.backgroundColor = UIColor.clear.cgColor
        _barScrollLayer.frame = CGRect(x: x, y: y, width: w - x, height: h)
        _barScrollLayer.scrollMode = .horizontally
        _barScrollLayer.masksToBounds = true
        self.layer.addSublayer(_barScrollLayer)
        
        _barContentLayer.backgroundColor = UIColor.clear.cgColor
        _barContentLayer.contents = UIImage(named: "tianmolei")?.cgImage
        _barContentLayer.contentsScale = 0.4
        _barContentLayer.frame = CGRect(x: 0, y: 0, width: _barContentLayerW, height: h)
        _barScrollLayer.addSublayer(_barContentLayer)
        
        for i in 0..<xData.count {
            let yD = yData[i]
            let yH: CGFloat = _oneLineSpace * CGFloat(yD)
            let bX = CGFloat(i) * (barWidth + barSpace) + barLeftSpace
            _initBarCharLayer(c: UIColor.randomColor(), x: bX, y: h - yH, w: barWidth, h: yH)
            
            _initBarCharTopLayer(yD: yD, x: bX, y: h - yH)
        }
    }
    
    private func _initBarCharLayer(c: UIColor, x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        let b = CALayer()
        b.backgroundColor = c.cgColor
        b.contentsScale = 0.4
        b.frame = CGRect(x: x, y: y, width: w, height: h)
        _barContentLayer.addSublayer(b)
    }
    
    private func _initBarCharTopLayer(yD: Double, x: CGFloat, y: CGFloat) {
        let text = String(yD)
        let textW = text.char_widthWith(barFontSize, height: barFontSize)
        let c = CATextLayer()
        c.contentsScale = UIScreen.main.scale
        let w: CGFloat = textW
        let h: CGFloat = barFontSize
        c.frame = CGRect(x: x, y: y - h, width: w, height: h)
        c.string = text
        c.fontSize = barFontSize
        c.foregroundColor = barFontColor.cgColor
        _barContentLayer.addSublayer(c)
    }
    
    // MARK: 点击方法
    @objc func _tap(sender: UITapGestureRecognizer) {
        
    }
    
    // MARK: 滑动方法
    @objc func _pan(sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        var offset = _barScrollLayer.bounds.origin
        
        offset.x -= translation.x
        offset.y -= translation.y
        if offset.x < 0 {
            offset.x = 0
        }
        
        let beyondSpace = _barContentLayerW - (self.frame.size.width - (yLeftPadding + _yDataMaxWidth + _xRightPadding))
        if offset.x > beyondSpace {
            offset.x = beyondSpace
        }
        _barScrollLayer.scroll(to: offset)
        _xScrollLayer.scroll(to: offset)
        
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
}


// MARK: extension
extension Double {
    var char_font: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self))
    }
}

extension Int {
    var char_font: UIFont {
        return UIFont.systemFont(ofSize: CGFloat(self))
    }
}

extension CGFloat {
    var char_font: UIFont {
        return UIFont.systemFont(ofSize: self)
    }
}


// MARK: 计算宽度
extension String {
    func char_widthWith(_ fontSize: CGFloat, height: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
}
