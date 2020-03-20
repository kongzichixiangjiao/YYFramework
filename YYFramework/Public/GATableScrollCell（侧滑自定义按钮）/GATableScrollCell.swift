//
//  GATableScrollCell.swift
//  Need
//
//  Created by houjianan on 2020/3/17.
//  Copyright © 2020 houjianan. All rights reserved.
//  自定义侧滑按钮
//  cell继承

//  cell.rightButtons = self.rightButtons()
//  cell.scrollDelegate = self
//  cell.row = indexPath.row

//func tableScrollCellClicked(row: Int, tag: Int) {
//}

import UIKit
import SnapKit

protocol GATableScrollCellDelegate: class {
    func tableScrollCellClicked(row: Int, tag: Int)
}

class GATableScrollCell: UITableViewCell {
    
    let kScrollViewOpenName = NSNotification.Name(rawValue: "scrollViewOpen")
    let kScrollViewClosedName = NSNotification.Name(rawValue: "scrollViewOpen")
    
    weak var scrollDelegate: GATableScrollCellDelegate?
    
    private var rightButtonTotalWidth: CGFloat = 0
    private var isOpen: Bool = false
    private weak var _tableView: UITableView!
    private var _tableViewPanGestureRecognizer: UIPanGestureRecognizer!
    var rightButtons: [UIButton] = []
    var row: Int = -1
     
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: self.bounds)
        v.backgroundColor = UIColor.clear
        v.translatesAutoresizingMaskIntoConstraints = false
        v.showsHorizontalScrollIndicator = false
        v.showsVerticalScrollIndicator = false
        v.isPagingEnabled = false
        v.delegate = self
        v.isUserInteractionEnabled = true
        return v
    }()
    
    lazy var buttonsView: GATableScrollButtonView = {
        let v = GATableScrollButtonView()
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        scrollView.addSubview(self.contentView)
        self.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(0)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(scrollViewClosed), name: kScrollViewClosedName, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(sender:)))
        scrollView.addGestureRecognizer(tap)
    }
    
    override func didMoveToSuperview() {
        func checkTableView(v: UIView?) {
            guard let v = v else {
                return
            }
            if let t = v as? UITableView {
                _tableView = t
                _tableViewPanGestureRecognizer = _tableView.panGestureRecognizer
                _tableViewPanGestureRecognizer.addObserver(self, forKeyPath: "state", options: NSKeyValueObservingOptions.new, context: nil)
            } else {
                checkTableView(v: v.superview)
            }
        }
        
        checkTableView(v: self.superview)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let tableViewPanGestureRecognizer = object as? UIPanGestureRecognizer {
            if _tableViewPanGestureRecognizer == tableViewPanGestureRecognizer {
                if _tableViewPanGestureRecognizer.state == .began {
                    NotificationCenter.default.post(name: self.kScrollViewClosedName, object: self)
                }
            }
        }
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        guard let indexPath = _tableView.indexPath(for: self) else {
            return
        }
        if isOpen {
            _scrollViewClosed()
        } else {
            if self.isSelected {
                _tableView.delegate?.tableView?(_tableView, didDeselectRowAt: indexPath)
            } else {
                _tableView.delegate?.tableView?(_tableView, didSelectRowAt: indexPath)
            }
        }
        
    }
    
    @objc func scrollViewClosed(sender: Notification) {
        let cell = sender.object as! GATableScrollCell
        if cell != self && isOpen {
            _scrollViewClosed()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let h = self.contentView.frame.size.height
        let w = self.contentView.frame.size.width
        
        scrollView.addSubview(buttonsView)
        rightButtonTotalWidth = buttonsView.add(cell: self, buttons: rightButtons) {
            [weak self] tag in
            if let weakSelf = self {
                guard let indexPath = weakSelf._tableView.indexPath(for: weakSelf) else {
                    return
                }
                weakSelf.scrollDelegate?.tableScrollCellClicked(row: weakSelf.row == -1 ? indexPath.row : weakSelf.row, tag: tag)
            }
        }
        buttonsView.frame = CGRect(x: w, y: 0, width: rightButtonTotalWidth, height: h)
        
        scrollView.contentSize = CGSize(width: w + rightButtonTotalWidth, height: h)
        scrollView.contentOffset = CGPoint.zero
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    deinit {
        _tableViewPanGestureRecognizer.removeObserver(self, forKeyPath: "state")
        NotificationCenter.default.removeObserver(self, name: kScrollViewOpenName, object: nil)
        NotificationCenter.default.removeObserver(self, name: kScrollViewClosedName, object: nil)
    }
}

extension GATableScrollCell {
    func _scrollViewOpen() {
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollView.contentOffset = CGPoint(x: self.rightButtonTotalWidth, y: 0)
        }) { (b) in
            self.isOpen = true
        }
    }
    
    func _scrollViewClosed() {
        UIView.animate(withDuration: 0.25, animations: {
            self.scrollView.contentOffset = CGPoint.zero
        }) { (b) in
            self.isOpen = false
        }
    }
}

extension GATableScrollCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: self.kScrollViewClosedName, object: self)
        let x = scrollView.contentOffset.x
        if x >= rightButtonTotalWidth {
            scrollView.contentOffset = CGPoint(x: rightButtonTotalWidth, y: 0)
            return
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.x > rightButtonTotalWidth / 2 {
            _scrollViewOpen()
        } else {
            _scrollViewClosed()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x > rightButtonTotalWidth / 2 {
            _scrollViewOpen()
        } else {
            _scrollViewClosed()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let vX = velocity.x
        if vX == 0 {
            return 
        }
        if vX > 0 {
            _scrollViewOpen()
        } else {
            _scrollViewClosed()
        }
    }
}

class GATableScrollButtonView: UIView {
    typealias Handler = (_ tag: Int) -> ()
    var handler: Handler?
    
    func add(cell: GATableScrollCell, buttons: [UIButton], handler: @escaping Handler) -> CGFloat {
        for b in self.subviews {
            b.removeFromSuperview()
        }
        
        self.handler = handler
        let h = cell.contentView.frame.size.height
        let _ = cell.contentView.frame.size.width
        var totalHeight: CGFloat = 0.0
        
        for i in 0..<buttons.count {
            let b = buttons[i]
            let bW = b.frame.size.width
            totalHeight += bW
            b.frame = CGRect(x: CGFloat(i) * bW, y: 0, width: bW, height: h)
            b.addTarget(self, action: #selector(rightButtonsTouchUpInside(sender:)), for: UIControl.Event.touchUpInside)
            self.addSubview(b)
        }
        return totalHeight
    }
    
    @objc func rightButtonsTouchUpInside(sender: UIButton) {
        self.handler?(sender.tag)
    }
    
}
