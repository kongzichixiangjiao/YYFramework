//
//  GARxSwiftViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/27.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation
import RxSwift

#if os(iOS)
    import UIKit
    typealias OSViewController = UIViewController
#elseif os(macOS)
    import Cocoa
    typealias OSViewController = NSViewController
#endif

class GARxSwiftBaseViewController: OSViewController {
    var disposeBag = DisposeBag()
}

class GARxTabaleBaseViewController: UITableViewController {
    var disposeBag = DisposeBag()
}
