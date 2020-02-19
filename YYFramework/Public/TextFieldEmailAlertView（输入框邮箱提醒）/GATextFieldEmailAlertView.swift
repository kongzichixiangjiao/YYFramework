//
//  GATextFieldEmailAlertView.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/15.
//  Copyright © 2020 houjianan. All rights reserved.
//

/*
class GATextFieldEmailAlertViewController: GANavViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    var sourceData = ["@qq.com", "@163.com", "@puxin.com", "@google.cn"]
    
    lazy var textFieldEmailAlertView: GATextFieldEmailAlertView = {
        let v = GATextFieldEmailAlertView(frame: CGRect(x: textField.x, y: textField.maxY, width: textField.width, height: CGFloat(sourceData.count) * 40.0), sourceData: self.sourceData)
        v.delegate = self
        v.backgroundColor = UIColor.randomColor()
        self.view.addSubview(v)
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func editingChanged(_ sender: Any) {
        textFieldEmailAlertView.reload(text: textField.text ?? "")
    }
}

extension GATextFieldEmailAlertViewController: GATextFieldEmailAlertViewDelegate {
    func textFieldEmailAlertViewDidSelected(text: String) {
        textField.text = text
    }
}

extension GATextFieldEmailAlertViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldEmailAlertView.show()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldEmailAlertView.hide()
    }
}
*/

import UIKit

protocol GATextFieldEmailAlertViewDelegate: class {
    func textFieldEmailAlertViewDidSelected(text: String)
}

class GATextFieldEmailAlertView: UIView {
    
    weak var delegate: GATextFieldEmailAlertViewDelegate?
    
    var textString: String = ""
    var sourceData: [String] = []
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = self.bounds
        t.separatorStyle = .none
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    convenience init(frame: CGRect, sourceData: [String]) {
        self.init(frame: frame)
        
        self.sourceData = sourceData
        
        self.addSubview(tableView)
        tableView.register(UINib(nibName: "GATextFieldEmailAlertCell", bundle: nil), forCellReuseIdentifier: "GATextFieldEmailAlertCell")
    }
    
    func show() {
        self.isHidden = false
    }
    
    func hide() {
        self.isHidden = true
    }
    
    func reload(text: String) {
        self.textString = text
        
        tableView.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GATextFieldEmailAlertView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GATextFieldEmailAlertCell", for: indexPath) as! GATextFieldEmailAlertCell
        cell.l.text = textString + sourceData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = sourceData[indexPath.row]
        delegate?.textFieldEmailAlertViewDidSelected(text: textString + text)
        
        hide()
    }
}
