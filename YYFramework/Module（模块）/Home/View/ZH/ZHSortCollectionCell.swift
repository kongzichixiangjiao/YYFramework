//
//  ZHSortCollectionCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/11/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

enum YYHomeSortType: Int {
    /*
     公募基金 = 0， 私募基金 = 1，稳赢宝 = 2， 保险服务 = 3， 海外移民 = 4， 家族信托 = 5， 企业理财 = 6， 普信公益 = 7
     */
    case gmjj = 0, smjj = 1, wyb = 2, bxfw = 3, hwym = 4, jzxt = 5, qylc = 6, pxgy = 7
}

protocol ZHSortCollectionCellDelegate: class {
    func sortTableViewCellDidSelected(row: Int)
}

class ZHSortCollectionCell: UICollectionViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var mDelegate: ZHSortCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.yy_register(nibName: ZHSortItemCollectionCell.identifier)
    }

}

extension ZHSortCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZHSortItemCollectionCell.identifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width / 4, height: self.bounds.width / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mDelegate?.sortTableViewCellDidSelected(row: indexPath.row)
    }
}
