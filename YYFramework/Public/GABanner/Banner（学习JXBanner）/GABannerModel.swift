//
//  GABannerModel.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation

class GABannerModel {
    public var isAutoPlay: Bool = true
    
    public var isBounces: Bool = true
    
    public var isShowPageControl: Bool = true
    
    public var isPagingEnabled: Bool = true
    
    public var contentInset = UIEdgeInsets.zero
    
    public var timeInterval: TimeInterval = 5.0
    
    public var cycleWay: CycleWay = .forward
    
    public var edgeTransitionType: GABannerTransitionType? = .fade
    
    public var edgeTransitionSubtype: CATransitionSubtype = .fromRight
    
    internal var currentRollingDirection: RollingDirection = .right
}

extension GABannerModel {
    enum GABannerTransitionType : String {
        case fade
        case push
        case reveal
        case moveIn
        case cube
        case suckEffect
        case oglFlip
        case rippleEffect
        case pageCurl
        case pageUnCurl
        case cameraIrisHollowOpen
        case cameraIrisHollowClose
        case curlDown
        case curlUp
        case flipFromLeft
        case flipFromRight
    }
    
    enum CycleWay {
        case forward
        case skipEnd
        case rollingBack
    }
    
    enum RollingDirection {
        case right
        case left
    }
}

extension GABannerModel {
    func isAutoPlay(_ isAutoPlay: Bool) -> GABannerModel {
        self.isAutoPlay = isAutoPlay
        return self
    }
    
    func isBounces(_ isBounces: Bool) -> GABannerModel {
        self.isBounces = isBounces
        return self
    }
    
    func isPagingEnabled(_ isPagingEnabled: Bool) -> GABannerModel {
        self.isPagingEnabled = isPagingEnabled
        return self
    }
    
    func contentInset(_ contentInset: UIEdgeInsets) -> GABannerModel {
        self.contentInset = contentInset
        return self
    }
    
    func isShowPageControl(_ isShowPageControl: Bool) -> GABannerModel {
        self.isShowPageControl = isShowPageControl
        return self
    }
    
    func timeInterval(_ timeInterval: TimeInterval) -> GABannerModel {
        self.timeInterval = timeInterval
        return self
    }
    
    func cycleWay(_ cycleWay: CycleWay) -> GABannerModel {
        self.cycleWay = cycleWay
        return self
    }
    
    func edgeTransitionType(_ edgeTransitionType: GABannerTransitionType?) -> GABannerModel {
        self.edgeTransitionType = edgeTransitionType
        return self
    }
    
    func edgeTransitionSubtype(_ edgeTransitionSubtype: CATransitionSubtype) -> GABannerModel {
        self.edgeTransitionSubtype = edgeTransitionSubtype
        return self
    }
    
    internal func currentRollingDirection(_ currentRollingDirection: RollingDirection) -> GABannerModel {
        self.currentRollingDirection = currentRollingDirection
        return self
    }
    
}
