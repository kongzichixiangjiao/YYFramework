//
//  XCMineViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/28.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class XCMineViewController: UIViewController {
    
    var dataSource = ["1.jpg", "2.jpg", "3.jpg", "4.jpg", "5.jpg", "6.jpg"]
    
    lazy var banner: GABannerView = {
        let v = GABannerView(frame: CGRect(x: 0, y: 100, width: self.view.width, height: 250))
        v.delegate = self
        v.dataSource = self
        v.identifier = "test"
        v.backgroundColor = UIColor.randomColor()
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.randomColor()
        
        self.view.addSubview(banner)
    }
    
}

extension XCMineViewController: GABannerDelegate, GABannerDataSource {
    func gaBanner(_ banner: GABanner, coverView: UIView) {
        
    }
    
    func gaBanner(_ banner: GABanner, center index: Int) {
        
    }
    
    func gaBanner(_ banner: GABanner, model: GABannerModel) -> GABannerModel {
        return model
        .timeInterval(3)
        .cycleWay(.forward)
    }
    
    func gaBanner(_ banner: GABanner, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func gaBanner(_ banner: GABanner) -> (GABannerCellRegister) {
        return GABannerCellRegister(type: GABannerBaseCell.self, reuseIdentifier: GABannerBaseCell.identifier, nib: UINib(nibName: GABannerBaseCell.identifier, bundle: nil))
    }
    
    func gaBanner(_ banner: GABanner, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell {
        let name = dataSource[index % 6]
        (cell as! GABannerBaseCell).imgView.image = UIImage(named: name)
        return cell
    }
    
    func gaBanner(numberOfItems banner: GABanner) -> Int {
        return dataSource.count
    }
    
    func gaBanner(_ banner: GABanner, layoutModel: GABannerLayoutModel) -> GABannerLayoutModel {
        return layoutModel
            .layoutType(GABannerLinearTransform())
            .itemSize(CGSize(width: 280, height: 250))
            .maximumAngle(0.1)
            .itemSpacing(10)
    }
}
