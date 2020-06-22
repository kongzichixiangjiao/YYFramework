//
//  GABannerLayoutModel.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

class GABannerLayoutModel {
    // base
    public var itemSize: CGSize?
    public var itemSpacing: CGFloat = 0.0
    public var layoutType: GABannerTransformable?
    
    public var minimumScale: CGFloat = 0.8
    public var minimumAlpha: CGFloat = 1.0
    public var maximumAngle: CGFloat = 0.2
    public var rateOfChange: CGFloat = 0.4
    public var rateHorisonMargin: CGFloat = 0.2
    
}

extension GABannerLayoutModel {
    
    func itemSize(_ itemSize: CGSize) -> GABannerLayoutModel {
        self.itemSize = itemSize
        return self
    }
    
    func itemSpacing(_ itemSpacing: CGFloat) -> GABannerLayoutModel {
        self.itemSpacing = itemSpacing
        return self
    }
    
    func layoutType(_ layoutType: GABannerTransformable?) -> GABannerLayoutModel {
        self.layoutType = layoutType
        return self
    }
    
    func minimumScale(_ minimumScale: CGFloat) -> GABannerLayoutModel {
        self.minimumScale = minimumScale
        return self
    }
    
    func minimumAlpha(_ minimumAlpha: CGFloat) -> GABannerLayoutModel {
        self.minimumAlpha = minimumAlpha
        return self
    }
    
    func maximumAngle(_ maximumAngle: CGFloat) -> GABannerLayoutModel {
        self.maximumAngle = maximumAngle
        return self
    }
    
    func rateOfChange(_ rateOfChange: CGFloat) -> GABannerLayoutModel {
        self.rateOfChange = rateOfChange
        return self
    }
    
    func rateHorisonMargin(_ rateHorisonMargin: CGFloat) -> GABannerLayoutModel {
        self.rateHorisonMargin = rateHorisonMargin
        return self
    }

}
