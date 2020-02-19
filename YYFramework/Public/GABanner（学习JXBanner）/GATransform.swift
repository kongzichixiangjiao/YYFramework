//
//  GATransform.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/2.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

// MARK: - Linear
public struct GABannerLinearTransform: GABannerTransformable {
    
    public init() {}

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
        attributes.transform = transform;
        attributes.alpha = _alpha;
    }
}

// MARK: - Custom
struct GACustomTransform: GABannerTransformable {
    
    func transformToAttributes(collectionView: UICollectionView, model: GABannerLayoutModel, attributes: UICollectionViewLayoutAttributes) {
        
        let collectionViewWidth = collectionView.frame.width
        if collectionViewWidth <= 0 { return }
        
        let centetX = collectionView.contentOffset.x + collectionViewWidth * 0.5;
        let delta = abs(attributes.center.x - centetX)
        let calculateRate = 1 - delta / collectionViewWidth
        let angle = min(delta / collectionViewWidth * (1 - model.rateOfChange), model.maximumAngle)
        let alpha = max(calculateRate, model.minimumAlpha)
        
        
        applyCoverflowTransformToAttributes(viewCentetX: centetX,
                                            attributes: attributes,
                                            model: model,
                                            angle: angle,
                                            alpha: alpha,
                                            calculateRate: calculateRate)
    }
    
    func applyCoverflowTransformToAttributes(viewCentetX: CGFloat,
                                             attributes: UICollectionViewLayoutAttributes,
                                             model: GABannerLayoutModel,
                                             angle: CGFloat,
                                             alpha: CGFloat,
                                             calculateRate: CGFloat) -> Void {
        var transform3D: CATransform3D = CATransform3DIdentity
        
        
        let location = GABannerTransfrom.itemLocation(viewCentetX: viewCentetX,
                                                      itemCenterX: attributes.center.x)

        var _angle = angle
        var _alpha = alpha
        var _translateX: CGFloat = 0
        var _translateY: CGFloat = 0
        attributes.zIndex = 0
        
        switch location {
        case .left:
            _angle = angle
            _translateX = 0.2 * attributes.size.width * (1 - calculateRate) / 4
            _translateY = 0.4 * attributes.size.height * (1 - calculateRate)
            
            
        case .right:
            _angle = -angle
            _translateX = -0.2 * attributes.size.width * (1 - calculateRate) / 4
            _translateY = 0.4 * attributes.size.height * (1 - calculateRate)
            
        case .center:
            _angle = 0
            _alpha = 1
            _translateY = 0
            attributes.zIndex = 10000
        }
        
        transform3D = CATransform3DTranslate(transform3D, _translateX, _translateY, 0)
        transform3D = CATransform3DRotate(transform3D, -CGFloat.pi * _angle, 0, 0, 1)
        attributes.alpha = _alpha
        attributes.transform3D = transform3D
    }

}
