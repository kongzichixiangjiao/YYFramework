//
//  GABanner.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

// MARK: Banner
protocol GABanner: UIView {
    var delegate: GABannerDelegate? { set get }
    var dataSource: GABannerDataSource? { set get }
    var identifier: String? { set get }
    
    func reloadView()
}

extension GABanner {
    
}


// MARK: DataSource
protocol GABannerDataSource: class {
    func gaBanner(_ banner: GABanner) -> (GABannerCellRegister)
    func gaBanner(_ banner: GABanner, cellForItemAt index: Int, cell: UICollectionViewCell) -> UICollectionViewCell
    func gaBanner(numberOfItems banner: GABanner) -> Int
    func gaBanner(_ banner: GABanner, layoutModel: GABannerLayoutModel) -> GABannerLayoutModel
    func gaBanner(_ banner: GABanner, model: GABannerModel) -> GABannerModel
}

extension GABannerDataSource {

}


// MARK: Delegate
protocol GABannerDelegate: class {
    func gaBanner(_ banner: GABanner, didSelectItemAt indexPath: IndexPath)
    func gaBanner(_ banner: GABanner, coverView: UIView)
    func gaBanner(_ banner: GABanner, center index: Int)
}

extension GABannerDelegate {

}


// MARK: Transformable
protocol GABannerTransformable {
    func transformToAttributes(collectionView: UICollectionView, model: GABannerLayoutModel, attributes: UICollectionViewLayoutAttributes)
}
