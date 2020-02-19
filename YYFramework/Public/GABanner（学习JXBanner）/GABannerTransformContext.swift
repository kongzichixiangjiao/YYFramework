//
//  GABannerTransformContext.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

struct GABannerTransformContext: GABannerTransformable {

    var transform: GABannerTransformable?
    
    init() {}
    
    init(transform: GABannerTransformable) {
        self.transform = transform
    }
    
    func transformToAttributes(collectionView: UICollectionView,
                               model: GABannerLayoutModel,
                               attributes: UICollectionViewLayoutAttributes) {
        transform?.transformToAttributes(collectionView: collectionView,
                                         model: model,
                                         attributes: attributes)
    }

}
