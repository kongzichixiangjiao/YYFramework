//
//  GASelectedCityViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/14.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GASelectedCityViewControllerDelegate: class {
    func selectedCityViewControllerDidSelected(text: String)
    func selectedCityViewControllerCancle()
}

class GASelectedCityViewController: UIViewController {
    
    weak var delegate: GASelectedCityViewControllerDelegate?
    
    @IBOutlet weak var searchView: GASearchView!
    @IBOutlet weak var tableView: UITableView!
    
    private var _indexSource: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    var dataSource: [[String : [String]]] = []
    var cityDataSource: [[String : Any]]!
    var screeningData = [[String : [String]]]()
    var allCity = [String]()
    var searchText: String = ""
    
    lazy var selectedCityTopView: GASelectedCityTopView = {
        let v = GASelectedCityTopView.loadSelectedCityTopView()
        v.delegate = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.delegate = self
        
        DispatchQueue.global().async {
            self._initData()
            DispatchQueue.main.async {
                self._initCityData()
            }
        }

        tableView.delegate = self
        tableView.dataSource = self
        tableView.yy_register(nibName: GASelectedCityCell.identifier)
        tableView.sectionIndexColor = "666666".color0X
        tableView.tableHeaderView = selectedCityTopView
        tableView.tableHeaderView?.height = 470
    }
    
    private func _initData() {
        guard let path = Bundle.main.path(forResource: "address", ofType: "plist") else {
            return
        }
        
        let dic = NSDictionary(contentsOf: URL(fileURLWithPath: path))
        cityDataSource = dic!["result"] as? [[String : Any]] ?? [["":""]]
    }
    
    private func _initCityData() {
        for data in cityDataSource {
            allCity.append(data["regionName"] as! String)
            for (key, value) in data {
                if key == "children1" {
                    let arr = (value as! [[String : Any]])
                    for item in arr {
                        allCity.append(item["regionName"] as! String)
                    }
                }
            }
        }
        _filterData(arr: allCity)
    }
    
    private func _filterData(arr: [String]) {
        dataSource = [["A" : []], ["B" : []], ["C" : []], ["D" : []], ["E" : []], ["F" : []], ["G" : []], ["H" : []], ["I" : []], ["J" : []], ["K" : []], ["L" : []], ["M" : []], ["N" : []], ["O" : []], ["P" : []], ["Q" : []], ["R" : []], ["S" : []], ["T" : []], ["U" : []], ["V" : []], ["W" : []], ["X" : []], ["Y" : []], ["Z" : []]]
        for c in arr {
            if c.sc_isIncludeChinese() {
                let headPinyin = c.sc_transformToPinyinHead()
                let h = headPinyin.sc_prefix(maxLength: 1)
                
                for i in 0..<dataSource.count {
                    var data = dataSource[i]
                    if data.keys.first == h {
                        var item = data[h]
                        item?.append(c)
                        data[h] = item
                        dataSource[i] = data
                    }
                }
            }
        }
        
        for i in 0..<dataSource.count {
            for index in _indexSource {
                if dataSource[i][index]?.count == 0 {
                    dataSource[i].removeAll()
                }
            }
        }
        
        var itemDataSource = [[String : [String]]]()
        _indexSource.removeAll()
        for i in 0..<dataSource.count {
            let data = dataSource[i]
            let key = data.keys.first ?? ""
            if data[key]?.count != 0 {
                if !key.isEmpty {
                    itemDataSource.append(data)
                    _indexSource.append(key)
                }
            }
        }
        
        dataSource = itemDataSource
        
        tableView.reloadData()
    }
}

extension GASelectedCityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = GASelectedCityHeaderView.loadSelectedCityHeaderView()
        v.nameLabel.text = _indexSource[section]
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataSource.count != 0 {
            let key = dataSource[section].keys.first ?? ""
            return dataSource[section][key]?.count ?? 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GASelectedCityCell.identifier, for: indexPath) as! GASelectedCityCell
        cell.nameLabel.text = dataSource[indexPath.section][dataSource[indexPath.section].keys.first ?? ""]?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = dataSource[indexPath.section][_indexSource[indexPath.section]]?[indexPath.row] ?? ""
        delegate?.selectedCityViewControllerDidSelected(text: text)
    }
    
    // 返回索引数组
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return _indexSource
    }
    //响应点击索引时的委托方法
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
}

extension GASelectedCityViewController: GASearchViewDelegate {
    
    func searchViewClickedCancle() {
        delegate?.selectedCityViewControllerCancle()
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchViewTextFieldDidChange(t: String) {
        var isWord: Bool = false
        for char in t.utf8  {
            if (char > 64 && char < 91) || (char > 96 && char < 123) {
                #if DEBUG
                print("字符串中包含字母")
                #endif
                isWord = true
            }
        }
        if !isWord {
            if searchText == t {
                return
            }
            if t.isEmpty {
                _filterData(arr: allCity)
            } else {
                let reArray = allCity.filter { (s) -> Bool in
                    return s.contains(t)
                }
                _filterData(arr: reArray)
            }
            searchText = t
        }
    }
}

extension GASelectedCityViewController: GASelectedCityTopViewDelegate {
    func selectedCityTopViewClicked(text: String) {
        delegate?.selectedCityViewControllerDidSelected(text: text)
    }
}

extension String {
    // 是否是汉字
    func sc_isIncludeChinese() -> Bool {
        for ch in self.unicodeScalars {
            if (0x4e00 < ch.value  && ch.value < 0x9fff) { return true } // 中文字符范围：0x4e00 ~ 0x9fff
        }
        return false
    }
    
    /// 将中文字符串转换为拼音
    ///
    /// - Parameter hasBlank: 是否带空格（默认不带空格）
    func sc_transformToPinyin(hasBlank: Bool = false) -> String {
        
        let stringRef = NSMutableString(string: self) as CFMutableString
        CFStringTransform(stringRef,nil, kCFStringTransformToLatin, false) // 转换为带音标的拼音
        CFStringTransform(stringRef, nil, kCFStringTransformStripCombiningMarks, false) // 去掉音标
        let pinyin = stringRef as String
        return hasBlank ? pinyin : pinyin.replacingOccurrences(of: " ", with: "")
    }
    
    /// 获取中文首字母
    ///
    /// - Parameter lowercased: 是否小写（默认大写）
    func sc_transformToPinyinHead(lowercased: Bool = false) -> String {
        let pinyin = self.sc_transformToPinyin(hasBlank: true).capitalized // 字符串转换为首字母大写
        var headPinyinStr = ""
        for ch in pinyin.sc_enumChar() {
            if ch <= "Z" && ch >= "A" {
                headPinyinStr.append(ch) // 获取所有大写字母
            }
        }
        return lowercased ? headPinyinStr.lowercased() : headPinyinStr
    }
    
    func sc_enumChar() -> [Character] {
        if self.isEmpty {
            return []
        }
        var chars: [Character] = []
        for char in self {
            chars.append(char)
        }
        return chars
    }
    
    func sc_prefix(maxLength: Int) -> String {
        return String(self.prefix(maxLength))
    }
}
