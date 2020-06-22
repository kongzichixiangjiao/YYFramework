//
//  GABannerBaseFlow.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

class GABannerBaseFlow: UICollectionViewFlowLayout {
    
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
    
}

public struct GABannerTransfrom {
    
    public enum GATransformLocation {
        case left
        case center
        case right
    }
    
    public static func itemLocation(viewCentetX: CGFloat, itemCenterX: CGFloat) -> GATransformLocation {
        var location: GATransformLocation = .right
        if abs(itemCenterX - viewCentetX) < 0.5 {
            location = .center
        } else if (itemCenterX - viewCentetX) < 0 {
            location = .left
        }
        return location
    }
}
