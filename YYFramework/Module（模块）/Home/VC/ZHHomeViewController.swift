//
//  ZHHomeViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class ZHHomeViewController: UIViewController {

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let v = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        v.delegate = self
        v.dataSource = self
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        initCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initCollectionView() {
        collectionView.yy_register(nibNames: [ZHSortCollectionCell.identifier,
                                              ZHVIPCollectionCell.identifier,
                                              ZHADCollectionCell.identifier])
        self.view.addSubview(collectionView)
    }

}

extension ZHHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == HomeCellType.sort.rawValue) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHSortCollectionCell.identifier, for: indexPath) as! ZHSortCollectionCell
            cell.mDelegate = self
            return cell
        } else if (indexPath.row == HomeCellType.ad.rawValue) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHADCollectionCell.identifier, for: indexPath)
            return cell
        } else if (indexPath.row == HomeCellType.vip.rawValue) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHVIPCollectionCell.identifier, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHVIPCollectionCell.identifier, for: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == HomeCellType.sort.rawValue) {
            return CGSize(width: self.view.bounds.width, height: self.view.bounds.width / 2)
        } else if (indexPath.row == HomeCellType.ad.rawValue) {
            return CGSize(width: self.view.bounds.width, height: kYYScrollADViewHeight)
        } else if (indexPath.row == HomeCellType.vip.rawValue) {
            return CGSize(width: self.view.bounds.width, height: 80)
        } else {
            return CGSize(width: self.view.bounds.width, height: 80)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ZHCalendarViewController(nibName: "ZHCalendarViewController", bundle: nil), animated: true)
    }
}

extension ZHHomeViewController: ZHSortCollectionCellDelegate {
    func sortTableViewCellDidSelected(row: Int) {
        print(row)
    }
}
