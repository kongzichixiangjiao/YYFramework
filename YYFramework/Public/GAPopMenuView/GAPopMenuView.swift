//
//  GAPopMenuView.swift
//  YYFramework
//
//  Created by houjianan on 2019/4/9.
//  Copyright © 2019 houjianan. All rights reserved.
//  POPMENU
/*
class GAPopMenuViewController: GANavViewController {

    @IBOutlet weak var b: UIButton!
    
    var menuView: GAPopMenuView!
    var models: [GAPopMenuModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "PopMenu")
        
        
        let model = GAPopMenuModel()
        model.title = "123"

        let model1 = GAPopMenuModel()
        model1.title = "aaaaa"
        models = [model1, model]

        menuView = GAPopMenuView(models: models, targetView: b, cellHeight: 40, cellWidth: 200, handler: {
            [weak self] row, targetView  in
            if let weakSelf = self {
                weakSelf.b.setTitle(weakSelf.models[row].title, for: .normal)
            }
        })
    }
    
    @IBAction func ac(_ sender: Any) {
        menuView.show(models: models, targetView: b)
    }
    
    deinit {
        print("deinit GAPopMenuViewController")
    }
}
*/

import UIKit

enum GAPopMenuViewDirectionType: Int {
    case down = 0, up = 1, left = 2, right = 3
}

class GAPopMenuView: UIView {
    
    typealias PopMenuViewHandler = (_ row: Int, _ targetView: UIView) -> ()
    private var _popMenuViewHandler: PopMenuViewHandler?
    
    public var models: [GAPopMenuModel] = []
    public weak var targetView: UIView!
    private var _selectedColor: UIColor!
    private var _normalColor: UIColor!
    private var _bgColor: UIColor!
    private var _cellHeight: CGFloat!
    private var _cellWidth: CGFloat!
    
    private var _directionType: GAPopMenuViewDirectionType = .down
    
    lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = CGRect.zero
        t.separatorStyle = .none
        t.isScrollEnabled = false
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    lazy var mWindow: UIWindow = {
        let v = UIWindow(frame: UIScreen.main.bounds)
        v.windowLevel = UIWindow.Level.alert
        v.backgroundColor = UIColor.clear
        v.becomeKey()
        v.makeKeyAndVisible()
        v.isHidden = true
        return v
    }()
    
    convenience init(models: [GAPopMenuModel],
                     targetView: UIView,
                     directionType: GAPopMenuViewDirectionType = .down,
                     bgColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0),
                     normalColor: UIColor = UIColor(red: 153 / 255, green: 153 / 255, blue: 153 / 255, alpha: 1),
                     selectedColor: UIColor = UIColor(red: 35 / 255, green: 132 / 255, blue: 224 / 255, alpha: 1),
                     cellHeight: CGFloat = 44,
                     cellWidth: CGFloat,
                     handler: @escaping PopMenuViewHandler) {
        self.init(frame: CGRect.zero)
        
        self.models = models
        self.targetView = targetView
        self._directionType = directionType
        self._normalColor = normalColor
        self._selectedColor = selectedColor
        self._bgColor = bgColor
        self._cellHeight = cellHeight
        self._cellWidth = cellWidth
        
        self._popMenuViewHandler = handler
        
        _initViews()
    }
    
    private func _initViews() {
        mWindow.addSubview(self)
        
        tableView.register(UINib(nibName: "GAPopMenuCell", bundle: nil), forCellReuseIdentifier: "GAPopMenuCell")
        self.addSubview(tableView)

        reloadViews()
    }

    public func show(models: [GAPopMenuModel], targetView: UIView) {
        self.targetView = targetView
        
        reloadViews()
        
        self.isHidden = false
        mWindow.isHidden = false
        
        self.models = models
        tableView.reloadData()
    }
    
    private func reloadViews() {
        let delegate = UIApplication.shared.delegate as? AppDelegate
        let rect = targetView.convert(targetView.bounds, to: delegate?.window)
        let minX = rect.minX
        let maxY = rect.maxY
    
        _cellWidth = min(rect.size.width, _cellWidth)
        
        self.frame = CGRect(x: minX, y: maxY, width: _cellWidth, height: _cellHeight * CGFloat(models.count))
        tableView.frame = CGRect(x: 0, y: 0, width: _cellWidth, height: _cellHeight * CGFloat(models.count))
    }
    
    public func hide() {
        mWindow.resignKey()
        self.isHidden = true
        mWindow.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GAPopMenuView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GAPopMenuCell", for: indexPath) as! GAPopMenuCell
        let model = models[indexPath.row]
        cell.titleLabel.textColor = model.isSelected ? _selectedColor : _normalColor
        cell.titleLabel.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return _cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _popMenuViewHandler?(indexPath.row, targetView)
        
        hide()
    }
}

class GAPopMenuModel {
    var title: String = ""
    var isSelected: Bool = false
}
