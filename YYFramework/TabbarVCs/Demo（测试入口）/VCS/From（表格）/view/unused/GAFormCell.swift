//
//  GAFormCell.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/20.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

protocol GAFormCellDelegate: class {

    func ga_formCellscrollViewDidScroll(x: CGFloat)
    
}

class GAFormCell: UITableViewCell {
    
    var delegate: GAFormCellDelegate?
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.yy_register(nibName: GAFormSectionCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func scrollViewDidScroll(x: CGFloat) {
        collectionView.contentOffset.x = x 
    }
    
}

extension GAFormCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GAFormSectionCell.identifier, for: indexPath) as! GAFormSectionCell
        cell.tLabel.text = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.ga_formCellscrollViewDidScroll(x: scrollView.contentOffset.x)
    }
}
