//
//  GABannerLineLayout.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/6.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GABannerLineLayout: UICollectionViewFlowLayout {
    var isPagingEnabled: Bool = true
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var model: GABannerLayoutModel? {
        didSet {
            if let model = model {
                itemSize = model.itemSize ?? collectionView?.bounds.size ?? CGSize(width: 2, height: 2)
                minimumLineSpacing = model.itemSpacing
                minimumInteritemSpacing = model.itemSpacing
            }
        }
    }
    
    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        
        if isPagingEnabled {
            let inset: CGFloat = (collectionView!.frame.width - itemSize.width) * 0.5
            sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) ->
        Bool {
            if let _ = model?.layoutType { return true }
            return super.shouldInvalidateLayout(forBoundsChange: newBounds)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if let layoutType = model?.layoutType {
            let attributesArray: [UICollectionViewLayoutAttributes] =
                NSArray(array: super.layoutAttributesForElements(in: rect) ?? [],
                        copyItems: true) as! [UICollectionViewLayoutAttributes]
            let visibleRect = CGRect(origin: collectionView!.contentOffset, size: collectionView!.bounds.size)
            
            for attributes in attributesArray {
                if !visibleRect.intersects(attributes.frame) { continue }
                applyTransformToAttributes(attributes: attributes,
                                           layoutType: layoutType)
            }
            return attributesArray
            
        }
        return super.layoutAttributesForElements(in: rect)
    }
    
    //MARK: Transform
    func applyTransformToAttributes(attributes: UICollectionViewLayoutAttributes, layoutType: GABannerTransformable) {
        let transformContext: GABannerTransformContext = GABannerTransformContext(transform: layoutType)
        transformContext.transformToAttributes(collectionView: collectionView!, model: model!, attributes: attributes)
    }
    
    func transformToAttributes(collectionView: UICollectionView, model: GABannerLayoutModel, attributes: UICollectionViewLayoutAttributes) {
        
        let collectionViewWidth = collectionView.frame.width
        if collectionViewWidth <= 0 { return }
        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5
        let delta = abs(attributes.center.x - centetX)
        let scale = max(1 - delta / collectionViewWidth * model.rateOfChange, model.minimumScale)
        let alpha = max(1 - delta / collectionViewWidth, model.minimumAlpha)
        
        var transform: CGAffineTransform = CGAffineTransform(scaleX: scale, y: scale)
        var _alpha = alpha
        
        // Adjust spacing When Scroling
        let location = GABannerTransfrom.itemLocation(viewCentetX: centetX, itemCenterX: attributes.center.x)
        let rate = 1.05 + model.rateHorisonMargin
        var translate: CGFloat = 0
        switch location {
        case .left:
            translate = rate * attributes.size.width * (1 - scale) / 2
        case .right:
            translate = -rate * attributes.size.width * (1 - scale) / 2
        case .center:
            _alpha = 1.0
        }
        transform = transform.translatedBy(x: translate, y: 0)
        
        // Set transform
        attributes.transform = transform
        attributes.alpha = _alpha
    }
}

