//
//  PXLoginTextField.swift
//  IFA-C
//
//  Created by 侯佳男 on 2018/8/2.
//  Copyright © 2018年 侯佳男. All rights reserved.
//

import UIKit

// 0-默认样式 1-密码样式 2-验证码样式
enum GATextFieldType: Int {
    case normal = 0, passWord = 1, verificationCode = 2
}

class GATextField: UIView {
    
    // 验证码按钮显示默认样式
    private var kVerificationCodeTitleDefault: String = "获取验证码"
    
    // 输入框内容
    public var textString: String {
        return self.textField.text ?? ""
    }
    
    // 根据键盘样式初始化UI布局 必须在xib中设置 0 1 2
    @IBInspectable var textFieldType_yy: Int = -1 {
        didSet {
            if (textFieldType_yy == -1) {
                print("error: GATextField 设置textFieldType_yy")
            }
            textField.frame = CGRect(x: icon.frame.origin.x + icon.frame.size.width + textFieldLeftSpace_yy + iconLeftSpace, y: textFeildTop, width: self.frame.size.width - icon.frame.width - textFieldLeftSpace_yy, height: self.frame.size.height - textFeildTop)
            lineView.frame = CGRect(x: 0, y: self.frame.size.height - 1.0 / UIScreen.main.scale, width: self.frame.size.width, height: 1.0 / UIScreen.main.scale)
            switch GATextFieldType(rawValue: textFieldType_yy) {
            case .normal?:
                let xW: CGFloat = 30
                clearButton.frame = CGRect(x: self.frame.size.width - xW, y: 0, width: xW, height: self.frame.size.height)
                break
            case .passWord?:
                let w: CGFloat = 30
                clearButton.frame = CGRect(x: self.frame.size.width - w * 2, y: clearAndEyebuttonTop, width: w, height: self.frame.size.height - clearAndEyebuttonTop)
                eyeButton.frame = CGRect(x: self.frame.size.width - w, y: clearAndEyebuttonTop, width: w, height: self.frame.size.height - clearAndEyebuttonTop)
                break
            case .verificationCode?:
                setUpVerificationCodeFrame(title: verificationCodeTitle_yy)
                // 验证码键盘样式
                textField.keyboardType = .numberPad
                break
            default:
                break
            }
        }
    }
    
    
    // icon图片名称
    @IBInspectable var iconImageName_yy: String = "pxLoginTextfield_code_icon" {
        didSet {
            guard let img = UIImage(named: iconImageName_yy) else {
                return
            }
            icon.image = img
            icon.frame = CGRect(x: iconLeftSpace, y: self.frame.size.height / 2 - img.size.height / 2 + iconTop, width: img.size.width, height: img.size.height)
            textField.frame = CGRect(x: icon.frame.origin.x + icon.frame.size.width + textFieldLeftSpace_yy + iconLeftSpace, y: textFeildTop, width: self.frame.size.width - icon.frame.width - textFieldLeftSpace_yy, height: self.frame.size.height - textFeildTop)
        }
    }
    
    // icon距离控件左侧距离
    @IBInspectable var iconLeftSpace: CGFloat = 5 {
        didSet {
            guard let image = icon.image else {
                return
            }
            icon.frame = CGRect(x: iconLeftSpace, y: self.frame.size.height / 2 - image.size.height / 2 + iconTop, width: icon.image!.size.width, height: image.size.height)
        }
    }
    
    // 输入框距离顶部距离
    @IBInspectable var textFeildTop: CGFloat = 0 {
        didSet {
            textField.frame = CGRect(x: icon.frame.origin.x + icon.frame.size.width + textFieldLeftSpace_yy + iconLeftSpace, y: textFeildTop, width: self.frame.size.width - icon.frame.width - textFieldLeftSpace_yy, height: self.frame.size.height - textFeildTop)
        }
    }
    
    // 输入框距离顶部距离
    @IBInspectable var iconTop: CGFloat = 0 {
        didSet {
            guard let image = icon.image else {
                return
            }
            icon.frame = CGRect(x: iconLeftSpace, y: self.frame.size.height / 2 - image.size.height / 2 + iconTop, width: image.size.width, height: image.size.height)
        }
    }
    
    // 输入框距离顶部距离
    @IBInspectable var verificationCodeIconTop: CGFloat = 0 {
        didSet {
            setUpVerificationCodeFrame(title: verificationCodeTitle_yy)
        }
    }
    
    // 按钮距离顶部距离
    @IBInspectable var clearAndEyebuttonTop: CGFloat = 0 {
        didSet {
            let w: CGFloat = 30
            clearButton.frame = CGRect(x: self.frame.size.width - w * 2, y: clearAndEyebuttonTop, width: w, height: self.frame.size.height - clearAndEyebuttonTop)
            eyeButton.frame = CGRect(x: self.frame.size.width - w, y: clearAndEyebuttonTop, width: w, height: self.frame.size.height - clearAndEyebuttonTop)
        }
    }
    
    // 输入框占位内容
    @IBInspectable var placeholderText_yy: String! {
        didSet {
            textField.placeholder = placeholderText_yy
        }
    }
    
    // 验证码按钮标题
    @IBInspectable var verificationCodeTitle_yy: String = "获取验证码" {
        didSet {
            if .verificationCode != GATextFieldType(rawValue: textFieldType_yy) {
                return
            }
            verificationCodeButton.setTitle(verificationCodeTitle_yy, for: .normal)
            setUpVerificationCodeFrame(title: verificationCodeTitle_yy)
            kVerificationCodeTitleDefault = verificationCodeTitle_yy
        }
    }
    
    // 倒计时结束 验证码按钮显示标题
    @IBInspectable var repeatVerificationCodeTitle_yy: String = "重新获取"
    
    
    // 输入内容必须为数字
    @IBInspectable var isMustNumber: Bool = false
    // 输入内容个数限制
    @IBInspectable var textMaxCount: Int = 100
    
    // 输入框字体大小
    @IBInspectable var textFieldFont_yy: Int = 12 {
        didSet {
            textField.font = UIFont.systemFont(ofSize: CGFloat(textFieldFont_yy))
        }
    }
    
    //键盘样式
    @IBInspectable var keyboardType_yy: Int = 0 {
        didSet {
            textField.keyboardType = .numberPad
        }
    }
    
    enum myKeyboardType: Int {
        case `default` = 0, asciiCapable = 1, numbersAndPunctuation = 2, URL = 3, numberPad = 4, phonePad = 5, namePhonePad = 6, emailAddress = 7, decimalPad = 8, twitter = 9, webSearch = 10, asciiCapableNumberPad = 11
    }
    
    /*
     case `default` // Default type for the current input method.
     
     case asciiCapable // Displays a keyboard which can enter ASCII characters
     
     case numbersAndPunctuation // Numbers and assorted punctuation.
     
     case URL // A type optimized for URL entry (shows . / .com prominently).
     
     case numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
     
     case phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).
     
     case namePhonePad // A type optimized for entering a person's name or phone number.
     
     case emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).
     
     @available(iOS 4.1, *)
     case decimalPad // A number pad with a decimal point.
     
     @available(iOS 5.0, *)
     case twitter // A type optimized for twitter text entry (easy access to @ #)
     
     @available(iOS 7.0, *)
     case webSearch // A default keyboard type with URL-oriented addition (shows space . prominently).
     
     @available(iOS 10.0, *)
     case asciiCapableNumberPad // A number pad (0-9) that will always be ASCII digits.
     */
    
    // 输入框距离控件最左侧距离
    @IBInspectable var textFieldLeftSpace_yy: CGFloat = 10 {
        didSet {
            textField.frame = CGRect(x: icon.frame.origin.x + icon.frame.size.width + textFieldLeftSpace_yy + iconLeftSpace, y: textFeildTop, width: self.frame.size.width - icon.frame.width - textFieldLeftSpace_yy, height: self.frame.size.height - textFeildTop)
        }
    }
    
    // 验证码按钮圆角
    @IBInspectable var verificationCodeCornerRadius_yy: CGFloat = 5 {
        didSet {
            if .verificationCode != GATextFieldType(rawValue: textFieldType_yy) {
                return
            }
            verificationCodeButton.layer.cornerRadius = verificationCodeCornerRadius_yy
        }
    }
    
    // 验证码按钮字体大小
    @IBInspectable var verificationCodeFont_yy: CGFloat = 12 {
        didSet {
            if .verificationCode != GATextFieldType(rawValue: textFieldType_yy) {
                return
            }
            verificationCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: verificationCodeFont_yy)
            setUpVerificationCodeFrame(title: verificationCodeTitle_yy)
        }
    }
    
    // 验证码按钮高度
    @IBInspectable var verificationCodeHeight_yy: CGFloat = 22
    
    // 占位字体颜色
    @IBInspectable var placeholderColor_yy: UIColor! {
        didSet {
            textField.setValue(placeholderColor_yy, forKeyPath: "_placeholderLabel.textColor")
        }
    }
    
    // 输入内容字体颜色
    @IBInspectable var textFieldColor_yy: UIColor! {
        didSet {
            textField.textColor = textFieldColor_yy
        }
    }

    @IBInspectable var isShowVerificationCodeBorder_yy: Bool = false
    
    // 验证码按钮
    @IBInspectable var verificationCodeColor_yy: UIColor = UIColor.white {
        didSet {
            if .verificationCode != GATextFieldType(rawValue: textFieldType_yy) {
                return
            }
            verificationCodeButton.setTitleColor(verificationCodeColor_yy, for: .normal)
            if isShowVerificationCodeBorder_yy {
                verificationCodeButton.layer.borderColor = verificationCodeColor_yy.cgColor
                verificationCodeButton.layer.borderWidth = 0.5
                verificationCodeButton.layer.masksToBounds = true
            }
        }
    }
    
    // 底线颜色
    @IBInspectable var lineColor: UIColor = UIColor.white {
        didSet {
            lineView.backgroundColor = lineColor
        }
    }
    
    // 底线
    lazy var lineView: UIView = {
        let v = UIView(frame: CGRect.zero)
        v.backgroundColor = lineColor
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        self.addSubview(v)
        return v
    }()
    
    // 左侧icon
    lazy var icon: UIImageView = {
        let v = UIImageView(frame: CGRect.zero)
        self.addSubview(v)
//        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        return v
    }()
    
    // 输入框
    lazy var textField: UITextField = {
        let v = UITextField(frame: CGRect.zero)
        v.borderStyle = .none
        v.delegate = self
        v.addTarget(self, action: #selector(textFieldEditingChanged(sender: )), for: .editingChanged)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        self.addSubview(v)
        return v
    }()
    
    // 清空按钮
    lazy var clearButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(named: "pxLoginTextfield_clear_icon"), for: UIControl.State.normal)
        v.addTarget(self, action: #selector(clearAction(sender:)), for: .touchUpInside)
        v.isHidden = true
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        self.addSubview(v)
        return v
    }()
    
    // 密码按钮
    lazy var eyeButton: UIButton = {
        let v = UIButton()
        v.setImage(UIImage(named: "pxLoginTextfield_secret_open_icon"), for: UIControl.State.normal)
        v.setImage(UIImage(named: "pxLoginTextfield_secret_closed_icon"), for: UIControl.State.selected)
        v.addTarget(self, action: #selector(eyeAction(sender:)), for: .touchUpInside)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        self.addSubview(v)
        return v
    }()
    
    // 验证码按钮
    lazy var verificationCodeButton: UIButton = {
        let v = UIButton(type: UIButton.ButtonType.custom)
        v.setTitle(kVerificationCodeTitleDefault, for: .normal)
        v.titleLabel?.font = UIFont.systemFont(ofSize: verificationCodeFont_yy)
        v.addTarget(self, action: #selector(verificationCodeAction(sender:)), for: .touchUpInside)
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
        self.addSubview(v)
        return v
    }()
    
    // 验证码按钮尺寸更改
    func setUpVerificationCodeFrame(title: String) {
        let cW: CGFloat = 30
        let vW: CGFloat = CGFloat(title.count) * verificationCodeFont_yy + 10
        clearButton.frame = CGRect(x: self.frame.size.width - cW - vW, y: clearAndEyebuttonTop, width: cW, height: self.frame.size.height - clearAndEyebuttonTop)
        verificationCodeButton.frame = CGRect(x: self.frame.size.width - vW, y: self.frame.size.height / 2 - verificationCodeHeight_yy / 2 + verificationCodeIconTop, width: vW, height:  verificationCodeHeight_yy)
    }
    
    // 输入框输入改变方法
    @objc func textFieldEditingChanged(sender: UITextField) {
        clearButton.isHidden = sender.text?.isEmpty ?? true
        
        // 限制输入字数判断
        guard let _: UITextRange = sender.markedTextRange else{
            if (sender.text! as NSString).length > textMaxCount {
                sender.text = (sender.text! as NSString).substring(to: textMaxCount)
            }
            return
        }
    }
    
    // 清空按钮方法
    @objc func clearAction(sender: UIButton) {
        textField.text = ""
        sender.isHidden = true 
    }
    
    // 密码眼睛方法
    @objc func eyeAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        textField.isSecureTextEntry = sender.isSelected
    }
    
    // 验证码按钮方法
    @objc func verificationCodeAction(sender: UIButton) {
        // 防止正在倒计时进行中 连续添加timer
        if (sender.titleLabel?.text != kVerificationCodeTitleDefault) {
            return
        }
        addTimer()
    }
    
    // 定时器timer
    private var timer: DispatchSourceTimer?
    // 倒计时时间
    @IBInspectable var sourceTimerCount_yy: Int = 60 {
        didSet {
            timerCount_yy = sourceTimerCount_yy
        }
    }
    // 倒计时计数使用
    var timerCount_yy: Int = -1
    
    // 添加倒计时方法
    func addTimer() {
        // 子线程创建timer
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        //        let timer = DispatchSource.makeTimerSource()
        /*
         dealine: 开始执行时间
         repeating: 重复时间间隔
         leeway: 时间精度
         */
        timer?.schedule(deadline: .now() + .seconds(0), repeating: DispatchTimeInterval.seconds(1), leeway: DispatchTimeInterval.seconds(0))
        // timer 添加事件
        timer?.setEventHandler {
            [weak self] in
            if let weakSelf = self {
                weakSelf.timerCount_yy -= 1
                // 倒计时结束
                if (weakSelf.timerCount_yy == 0) {
                    // 取消倒计时
                    weakSelf.cancleTimer()
                    DispatchQueue.main.async {
                        // 主线程更改验证码按钮
                        weakSelf.verificationCodeButton.setTitle(weakSelf.repeatVerificationCodeTitle_yy, for: .normal)
                        weakSelf.setUpVerificationCodeFrame(title: weakSelf.repeatVerificationCodeTitle_yy)
                        weakSelf.kVerificationCodeTitleDefault = weakSelf.repeatVerificationCodeTitle_yy
                        // 恢复倒计时时间
                        weakSelf.timerCount_yy = weakSelf.sourceTimerCount_yy
                    }
                } else {
                    DispatchQueue.main.async {
                        // 倒计时更改UI
                        let title: String = "\(weakSelf.timerCount_yy)秒"
                        weakSelf.verificationCodeButton.setTitle(title, for: .normal)
                        weakSelf.setUpVerificationCodeFrame(title: title)
                    }
                }
            }
        }
        timer?.resume()
    }
    // timer暂停
    func stopTimer() {
        timer?.suspend()
    }
    // timer结束
    func cancleTimer() {
        guard let t = timer else {
            return
        }
        t.cancel()
        timer = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        cancleTimer()
    }
    
}

extension GATextField: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        clearButton.isHidden = true 
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if !textField.text!.isEmpty {
            clearButton.isHidden = false
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // 限制输入数字
        let cs = NSCharacterSet(charactersIn: "1234567890").inverted
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        if string == filtered {
            return true
        } else {
            if (isMustNumber) {
                return false
            }
        }
        return true
    }
}
