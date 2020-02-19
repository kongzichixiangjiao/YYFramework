//
//  YYInterlockTableView.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/10/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class YYInterlockTableView: UITableView {

}

extension YYInterlockTableView: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
