//
//  YYInterlockCell.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/9/21.
//  Copyright © 2018年 houjianan. All rights reserved.
//  装载VC的view 横向滚动

import UIKit

protocol YYInterlockCellDelegate: class {
    func interlockCellScrollDidIndex(index: Int)
}
class YYInterlockCell: UITableViewCell {
    
    weak var delegate: YYInterlockCellDelegate?
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height))
        v.delegate = self
        v.isPagingEnabled = true
        v.isUserInteractionEnabled = true
        return v
    }()
    
    var viewSize: CGSize = CGSize.zero
    
    var vcs: [UIViewController]! {
        didSet {
            initViews()
        }
    }
    
    func initViews() {
        self.contentView.addSubview(scrollView)
        
        for i in 0..<self.vcs.count {
            let vc = vcs[i]
            guard let view = vc.view else {
                return
            }
            
            vc.yy_scrollView?.delegate = self
            let viewW = viewSize.width
            let viewH = viewSize.height
            view.frame = CGRect(x: CGFloat(i) * kScreenWidth, y: 0, width: viewW, height: viewH)
            self.scrollView.addSubview(view)
        }
        self.scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(self.vcs.count), height: self.frame.height)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension YYInterlockCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.width)
        delegate?.interlockCellScrollDidIndex(index: index)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
    }
    
}
