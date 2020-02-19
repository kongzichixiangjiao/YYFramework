//  GANormalizePickerView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/20.
//  Copyright © 2019年 houjianan. All rights reserved.
//
import UIKit

public enum GANormalizePickerViewDataType: Int {
    case none = 0, cancle = 1
}

open class GANormalizePickerView: UIView {
    
    var config: GANormalizePickerViewConfig = GANormalizePickerViewConfig()
    
    typealias PickerViewDidSelectHandler = (_ pickerView: GANormalizePickerView, _ row: Int, _ component: Int, _ type: GANormalizePickerViewDataType) -> ()
    var pickerViewDidSelectHandler: PickerViewDidSelectHandler?
    
    typealias PickerViewMultigroupDidSelectHandler = (_ pickerView: GANormalizePickerView, _ selected: [Int : Int], _ type: GANormalizePickerViewDataType) -> ()
    var pickerViewMultigroupDidSelectHandler: PickerViewMultigroupDidSelectHandler?
    
    @IBOutlet weak var pikcerView: UIPickerView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    
    var myRow: Int = 0
    var myComponent: Int = 0
    
    var selectedData: [Int : Int] = [Int : Int]()
    
    var dataType: GANormalizePickerViewDataType = .none
    var dataSource: [[String]] = [[""]]
    
    class func loadPickerView() -> GANormalizePickerView {
        return Bundle.main.loadNibNamed("GANormalizePickerView", owner: self, options: nil)?.last as! GANormalizePickerView
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        pikcerView.delegate = self
        pikcerView.dataSource = self
        
        _initBottomLineView()
    }
    
    func reload(type: GANormalizePickerViewDataType) {
        
        self.dataType = type
        
        if dataSource.count > 1 {
            for i in 0..<dataSource.count {
                selectedData[i] = 0
            }
        }
        
        pikcerView.reloadAllComponents()
        if dataSource.count != 0 {
            pikcerView.selectRow(myRow, inComponent: myComponent, animated: false)
        }
        
        _config()
    }
    
    @IBAction func cancle(_ sender: UIButton) {
        pickerViewDidSelectHandler?(self, myRow, myComponent, .cancle)
        pickerViewMultigroupDidSelectHandler?(self, [0:0], .cancle)
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        pickerViewDidSelectHandler?(self, myRow, myComponent, self.dataType)
        pickerViewMultigroupDidSelectHandler?(self, selectedData, .cancle)
    }
    
    // 分割线
    var _isShowBottomLineView: Bool = true
    var _marginSpaceBottomLineView: CGFloat = 16
    lazy var _bottomLineView: UIView = {
        let v = UIView()
        v.backgroundColor = kSeptalLine_1_LevelColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    private func _initBottomLineView() {
        if _isShowBottomLineView {
            self.addSubview(_bottomLineView)
            
            self.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 44))
            self.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .left, relatedBy: .equal, toItem: self, attribute: .left, multiplier: 1, constant: _marginSpaceBottomLineView))
            self.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .right, relatedBy: .equal, toItem: self, attribute: .right, multiplier: 1, constant: -_marginSpaceBottomLineView))
            _bottomLineView.addConstraint(NSLayoutConstraint(item: _bottomLineView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 1.0 / UIScreen.main.scale))
        }
    }
    
    func _config() {
        titleLabel.text = config.title
    }
    
}

extension GANormalizePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    public func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        let w = self.frame.size.width
        return CGFloat(w / CGFloat(dataSource.count))
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource[component].count
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return dataSource.count
    }
    
//    public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let fontSize: CGFloat = 16.0
//        print(fontSize)
//        let attributed = NSMutableAttributedString(string: dataSource[component][row])
//        attributed.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: fontSize), range: NSMakeRange(0, attributed.length))
//        attributed.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: NSMakeRange(0, attributed.length))
//        return attributed
//    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let fontSize: CGFloat = 16.0
        let l = UILabel()
        l.textColor = config.textColor
        l.font = UIFont.systemFont(ofSize: fontSize)
        l.textAlignment = .center

        let s = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        l.text = s
        return l
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[component][row]
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.myComponent = component
        self.myRow = row
        
        selectedData[component] = row
    }
    
}

