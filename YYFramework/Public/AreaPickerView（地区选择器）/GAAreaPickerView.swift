//
//  GAAreaPickerView.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/23.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAAreaPickerView: UIView {
    
    typealias ResultHandler = (_ models: [Any]) -> ()
    var resultHandler: ResultHandler?
    
    typealias ClosedHandler = () -> ()
    var closedHandler: ClosedHandler?
    
    private let _hotCollectionViewTag: Int = 1
    private let _resultCollectionViewTag: Int = 2
    private let _pTableViewTag: Int = 1
    private let _cTableViewTag: Int = 2
    private let _aTableViewTag: Int = 3
    private let _kRegionName: String = "regionName"
    private let _kRegionCode: String = "regionCode"
    private let _kParentId: String = "parentId"
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var hotCollectionView: UICollectionView!
    @IBOutlet weak var hotCollectionViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var resultCollectionView: UICollectionView!
    
    @IBOutlet weak var pTableView: UITableView! // province省
    @IBOutlet weak var cTableView: UITableView! // city省
    @IBOutlet weak var aTableView: UITableView! // area省
    
    var _pRow: Int = 0
    var _cRow: Int = 0
    var _aRow: Int = 0
    
    var hotData: [[String : String]] = [["regionCode":"110100","regionName":"北京市","parentId":"110000"],
                                        ["regionCode":"220200","regionName":"吉林市","parentId":"220000"],
                                        ["regionCode":"140200","regionName":"大同市","parentId":"140000"]]
    
    var resultData: [[String : Any]] = [["":""], ["":""], ["":""]]
    var dataSource: [[String : Any]] = [["":""]]
    
    static func loadView() -> GAAreaPickerView {
        return Bundle.main.loadNibNamed("GAAreaPickerView", owner: self, options: nil)?.last as! GAAreaPickerView
    }
    
    @IBAction func closed(_ sender: Any) {
        closedHandler?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _initData()
        
        _initViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func _initData() {
        guard let path = Bundle.main.path(forResource: "address", ofType: "plist") else {
            return
        }
        
        let dic = NSDictionary(contentsOf: URL(fileURLWithPath: path))
        dataSource = dic!["result"] as? [[String : Any]] ?? [["":""]]
    }
    
    private func _initViews() {
        let a = hotData.count / 4
        let b = hotData.count % 4
        hotCollectionViewHeight.constant = CGFloat(a + (b != 0 ? 1 : 0)) * 50.0
        
        _initCollectionView(c: hotCollectionView)
        _initCollectionView(c: resultCollectionView)
        
        _initTableView(t: pTableView)
        _initTableView(t: cTableView)
        _initTableView(t: aTableView)
        
        headerView.ga_clipStaticViewRectCorner(w: UIScreen.main.bounds.width, h: headerView.bounds.width, direction: [.topLeft, .topRight], cornerRadius: 10)
    }
    
    private func _initCollectionView(c: UICollectionView) {
        c.delegate = self
        c.dataSource = self
        
        c.register(UINib(nibName: "GAAreaPickerCollectionCell", bundle: nil), forCellWithReuseIdentifier: "GAAreaPickerCollectionCell")
        
        if c.tag == _resultCollectionViewTag {
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
            
            resultCollectionView.collectionViewLayout = layout
        } else if c.tag == _hotCollectionViewTag {
            let layout = UICollectionViewFlowLayout()
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            hotCollectionView.collectionViewLayout = layout
        } else {
            
        }
    }
    
    private func _initTableView(t: UITableView) {
        t.delegate = self
        t.dataSource = self
        t.register(UINib(nibName: "GAAreaPickerTableCell", bundle: nil), forCellReuseIdentifier: "GAAreaPickerTableCell")
    }
    
    private func _getP(row: Int) -> [String : Any] {
        return dataSource[row]
    }
    
    private func _getC(row: Int) -> [String : Any] {
        let p = _getP(row: _pRow)
        return (p["children1"] as! [[String : Any]])[row]
    }
    
    private func _getA(row: Int) -> [String : Any] {
        let c = _getC(row: _cRow)
        return (c["children"] as! [[String : Any]])[row]
    }
    
    private func _cGetP(parentId: String) -> [String : Any] {
        let item = dataSource.filter {m in
            return m[_kRegionCode] as! String == parentId
        }
        return item.first ?? ["":""]
    }
    
    private func _cGetP(regionName: String) -> [String : Any] {
        let item = dataSource.filter {m in
            return m[_kRegionName] as! String == regionName
        }
        return item.first ?? ["":""]
    }
    
    private func _cGetA(regionName: String) -> [[String : Any]] {
        let item = _cGetP(regionName: regionName)
        return item["children"] as! [[String : Any]]
    }
    
    private func _cGetPAtDataSourcePosition(hotC: [String : Any]) -> [Int] {
        var pRow: Int = 0
        var cRow: Int = 0
        let parentId = hotC[_kParentId] as! String
        let regionName = hotC[_kRegionName] as! String
        for i in 0..<dataSource.count {
            let p = dataSource[i]
            let regionCode = p[_kRegionCode] as! String
            if regionCode == parentId {
                pRow = i
                let c = p["children1"] as! [[String : Any]]
                for i in 0..<c.count {
                    let regionNameTemp = c[i][_kRegionName] as! String
                    if regionName == regionNameTemp {
                        cRow = i
                    }
                }
            }
        }
        return [pRow, cRow]
    }
    
}

extension GAAreaPickerView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let d = dataSource as? [[String : String]] {
            if d == [["":""]] {
                return 0
            }
        }
        if tableView.tag == _pTableViewTag {
            return dataSource.count
        } else if tableView.tag == _cTableViewTag {
            let p = _getP(row: _pRow)
            return (p["children1"] as! [[String : Any]]).count
        } else if tableView.tag == _aTableViewTag {
            let c = _getC(row: _cRow)
            return (c["children"] as! [[String : Any]]).count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GAAreaPickerTableCell.self)
        if tableView.tag == _pTableViewTag {
            cell.l.text = _getP(row: indexPath.row)[_kRegionName] as? String
            cell.l.textColor = _pRow == indexPath.row ? "A97F3B".area_color0X : UIColor.black
        } else if tableView.tag == _cTableViewTag {
            cell.l.text = _getC(row: indexPath.row)[_kRegionName] as? String
            cell.l.textColor = _cRow == indexPath.row ? "A97F3B".area_color0X : UIColor.black
        } else if tableView.tag == _aTableViewTag {
            cell.l.text = _getA(row: indexPath.row)[_kRegionName] as? String
            cell.l.textColor = _aRow == indexPath.row ? "A97F3B".area_color0X : UIColor.black
        } else {
            cell.l.text = "默认"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == _pTableViewTag {
            resultData[0] = _getP(row: indexPath.row)
            resultData[1] = ["":""]
            resultData[2] = ["":""]
            _pRow = indexPath.row
            _cRow = 0
            _aRow = 0
        } else if tableView.tag == _cTableViewTag {
            if !_judgeResultData(data: resultData[0], message: "请先选择省") {
                return
            }
            resultData[1] = _getC(row: indexPath.row)
            resultData[2] = ["":""]
            _cRow = indexPath.row
            _aRow = 0
        } else if tableView.tag == _aTableViewTag {
            if !_judgeResultData(data: resultData[1], message: "请先选择市") {
                return
            }
            resultData[2] = _getA(row: indexPath.row)
            _aRow = indexPath.row
            ga_showView("选择完毕")
            resultHandler?(resultData)
        } else {
            
        }
        
        pTableView.reloadData()
        cTableView.reloadData()
        aTableView.reloadData()
        
        resultCollectionView.reloadData()
    }
    
    private func _judgeResultData(data: [String : Any], message: String) -> Bool {
        if let d = data as? [String : String] {
            if d == ["":""] {
                ga_showView(message)
                return false
            }
        }
        return true
    }
    
}

extension GAAreaPickerView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GAAreaPickerCollectionCell", for: indexPath) as! GAAreaPickerCollectionCell
        if collectionView.tag == _hotCollectionViewTag {
            cell.l.text = hotData[indexPath.row][_kRegionName]
        } else if collectionView.tag == _resultCollectionViewTag {
            cell.l.text = resultData[indexPath.row][_kRegionName] as? String ?? ""
        } else {
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == _hotCollectionViewTag {
            return hotData.count
        } else if collectionView.tag == _resultCollectionViewTag {
            return resultData.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == _hotCollectionViewTag {
            return CGSize(width: kScreenWidth / 4, height: 50)
        } else if collectionView.tag == _resultCollectionViewTag {
            return CGSize(width: kScreenWidth / 3, height: 50)
        } else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == _hotCollectionViewTag {
            resultData[2] = ["":""]
            
            let hotC = hotData[indexPath.row]
            let rows = _cGetPAtDataSourcePosition(hotC: hotC)
            
            _pRow = rows.first ?? 0
            _cRow = rows.last ?? 0
            _aRow = 0
            
            resultData[0] = _getP(row: _pRow)
            resultData[1] = _getC(row: _cRow)
            
            pTableView.reloadData()
            cTableView.reloadData()
            aTableView.reloadData()
            
            resultCollectionView.reloadData()
        }
    }
    
}
extension String {
    var area_color0X: UIColor! {
        var cString:String = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
}
