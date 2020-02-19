//
//  GASelectedCityTopView.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/14.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GASelectedCityTopViewDelegate: class {
    func selectedCityTopViewClicked(text: String)
}

class GASelectedCityTopView: UIView {
    
    weak var delegate: GASelectedCityTopViewDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var locationView: GALocationView = {
        let v = GALocationView.loadLocationView()
        v.delegate = self
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    static func loadSelectedCityTopView() -> GASelectedCityTopView {
        let v = Bundle.main.loadNibNamed("GASelectedCityTopView", owner: self, options: nil)?.last as! GASelectedCityTopView
        return v
    }
    
    private var hotCityData = ["上海", "杭州", "广州", "成都", "苏州", "深圳", "南京", "天津", "重庆", "厦门", "武汉", "西安"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        _initViews()
    }
    
    private func _initViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.yy_register(nibName: GAHotCityCell.identifier)
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 20 - 40 - 20) / 3, height: 36)
        collectionView.collectionViewLayout = layout
        
        self.addSubview(locationView)
        self.selectedCity_addLayout(top: 0, left: 0, right: 0, height: 64, item: locationView, toItem: self)
    }
    
}


extension GASelectedCityTopView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAHotCityCell.identifier, for: indexPath) as! GAHotCityCell
        cell.nameLabel.text = hotCityData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotCityData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.selectedCityTopViewClicked(text: hotCityData[indexPath.row])
    }
}

extension GASelectedCityTopView: GALocationViewDelegate {
    func locationViewClicked(text: String) {
        delegate?.selectedCityTopViewClicked(text: text)
    }
}

extension UIView {
    func selectedCity_addLayout(top: CGFloat, left: CGFloat, right: CGFloat, height: CGFloat, item: UIView, toItem: UIView) {
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .top, relatedBy: .equal, toItem: toItem, attribute: .top, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .left, relatedBy: .equal, toItem: toItem, attribute: .left, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .right, relatedBy: .equal, toItem: toItem, attribute: .right, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: item, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: height))
    }
}
