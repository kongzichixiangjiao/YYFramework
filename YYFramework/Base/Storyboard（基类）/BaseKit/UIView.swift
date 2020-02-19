//
//  UIView.swift
//  eduOnline
//
//  Created by lixy on 2019/5/29.
//  Copyright © 2019 zheng. All rights reserved.
//

import UIKit

extension UIView {
    var viewController: UIViewController? {
        var vc: UIViewController?
        var rp = self.next
        while rp != nil {
            let temp = rp as? UIViewController
            if temp != nil {
                vc = temp
                break
            }
            rp = rp?.next
        }
        return vc
    }
    
    var navigationController: UINavigationController? {
        var vc: UINavigationController?
        var rp = self.next
        while rp != nil {
            let temp = rp as? UINavigationController
            if temp != nil {
                vc = temp
                break
            }
            rp = rp?.next
        }
        return vc
    }
}

extension UIView {
    public class func xibViewFrom<T: UIView>(viewType: T.Type) -> T {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as! T
    }
    
    public class func xibView() -> Self {
        return xibViewFrom(viewType: self)
    }
}

extension UIView {
    var renderImage: UIImage? {
        return autoreleasepool { () -> UIImage? in
            UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.layer.contents = nil
            return image
        }
    }
}

