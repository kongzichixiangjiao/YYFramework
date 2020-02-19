//
//  YYTableADView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYTableADView: UIView {

    var models: [YYTableADViewModel]!
    
    var timer: Timer?
    
    var currentRow: Int = 0
    
    var iconImageName: String = ""
    
    @objc lazy var tableView: UITableView = {
        let t = UITableView()
        t.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        t.separatorStyle = .none
        t.isScrollEnabled = false 
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    lazy var iconImageView: UIImageView = {
        let img = UIImage(named: iconImageName)
        let i = UIImageView(image: img)
        i.backgroundColor = UIColor.white
        i.contentMode = .center
        i.frame = CGRect(x: 0, y: 0, width: iconImageName.isEmpty ? 0 : (img?.size.width ?? 0), height: self.frame.size.height)
        return i
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(frame: CGRect, models: [YYTableADViewModel], iconImageName: String = "", speed: Double = 2) {
        self.init(frame: frame)
        
        self.models = models
        self.iconImageName = iconImageName
        
        initViews()
        initTimer(speed: speed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initViews() {
        if !iconImageName.isEmpty {
            self.addSubview(iconImageView)
        }
        tableView.frame = CGRect(x: 0, y: 0, width: self.bounds.width - iconImageView.bounds.width, height: self.bounds.height)
        tableView.register(UINib(nibName: YYADCellView.identifier, bundle: nil), forCellReuseIdentifier: YYADCellView.identifier)
        self.addSubview(tableView)
    }
    
    private func initTimer(speed: Double) {
        timer = Timer(timeInterval: speed, target: self, selector: #selector(scroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: RunLoop.Mode.common)
    }
    
    @objc func scroll() {
        tableView.scrollToRow(at: IndexPath(item: currentRow, section: 0), at: UITableView.ScrollPosition.bottom, animated: (currentRow != 0))
        
        currentRow += 1
        
        if currentRow == models.count {
            currentRow = 0
        }
    }
    
    private func stopScroll() {
        self.timer?.invalidate()
    }
    
    deinit {
        stopScroll()
    }
}

extension YYTableADView: UITableViewDataSource, UITableViewDelegate {

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYADCellView.identifier, for: indexPath) as! YYADCellView
        cell.mTextLabel.text = models[indexPath.row].text
        return cell
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.bounds.height
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        print(models[indexPath.row])
    }
}
