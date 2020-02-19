//
//  YYNewPaperView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/13.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import Foundation
import UIKit

class YYNewPaperViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}

enum YYNewPaperViewClickedType: Int {
    case login = 0, over = 1, root = 2
}

open class YYNewPaperView: UIView {

    typealias YYNewPaperViewHandler = (_ type: YYNewPaperViewClickedType) -> ()
    
    var handler: YYNewPaperViewHandler?
    var config: YYNewPaperConfig!
    

    lazy var collectionView: UICollectionView = {
        let layout = YYNewPaperViewFlowLayout()
        layout.itemSize = config.size
        
        let c = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        c.delegate = self
        c.dataSource = self
        c.backgroundColor = UIColor.white
        c.showsVerticalScrollIndicator = false
        c.showsHorizontalScrollIndicator = false
        c.isPagingEnabled = true
        c.isUserInteractionEnabled = true
        c.bounces = false
        c.contentOffset = CGPoint.zero
        
        if #available(iOS 11.0, *) {
            c.contentInsetAdjustmentBehavior = .never
        }
        
        self.addSubview(c)
        return c
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, config: YYNewPaperConfig = YYNewPaperConfig(), handler: @escaping YYNewPaperViewHandler) {
        self.init(frame: frame)
        
        self.config = config
        
        initViews()
        
        if config.isShowTimer {
            initCountDown()
        }
        
        self.handler = handler
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCountDown() {
        let countDown = GATimer(sourceTimerCount: config.sourceTimerCount)
        countDown.addTimer {
            [weak self] count, finished in
            if let weakSelf = self {
                if (finished) {
                    weakSelf.handler?(.over)
                } else {
                    if weakSelf.config.isShowTimer {
                        weakSelf.config.countDownButton.setTitle(String(count), for: .normal)
                    }
                }
            }
        }
    }
    
    func initViews() {
        collectionView.register(UINib(nibName: YYNewPaperCell.identifier, bundle: nil), forCellWithReuseIdentifier: YYNewPaperCell.identifier)
        
        if config.isShowLastButton {
            guard let lastBtn = config.lastButton else {
                return
            }
            
            lastBtn.frame = config.lastButtonFrame
            self.addSubview(lastBtn)
            lastBtn.addTarget(self, action: #selector(lastBtnAction), for: .touchUpInside)
        }
        if config.isShowTimer {
            config.countDownButton.frame = config.countDownFrame
            self.addSubview(config.countDownButton)
            config.countDownButton.addTarget(self, action: #selector(countDownButtonAction), for: .touchUpInside)
        }
    }
    
    @objc func countDownButtonAction() {
        if config.isShowTimer {
            self.handler?(.over)
        }
    }
    
    @objc func lastBtnAction() {
        self.handler?(.login)
    }
    
}

extension YYNewPaperView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: YYNewPaperCell.identifier, for: indexPath) as! YYNewPaperCell
        cell.imageView.image = UIImage(named: config.dataSource[indexPath.row])
        cell.row = indexPath.row
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return config.dataSource.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = collectionView.visibleCells.first as! YYNewPaperCell
        config.lastButton?.isHidden = !(cell.row == (config.dataSource.count - 1))
        print(cell)
        print(collectionView.contentOffset)
    }
}

