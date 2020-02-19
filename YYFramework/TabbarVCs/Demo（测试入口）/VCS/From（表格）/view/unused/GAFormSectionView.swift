//
//  GAFormSectionView.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/20.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit


protocol GAFormSectionViewDelegate: class {
    func ga_formSectionViewClicked(section: Int)
    func ga_formSectionViewscrollViewDidScroll(x: CGFloat)
    
}

class GAFormSectionView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: GAFormSectionViewDelegate?
    
    var section: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.yy_register(nibName: GAFormSectionCell.identifier)
    }
}

extension GAFormSectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
        if section != -1 {
            delegate?.ga_formSectionViewClicked(section: section)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.ga_formSectionViewscrollViewDidScroll(x: scrollView.contentOffset.x)
    }
}
