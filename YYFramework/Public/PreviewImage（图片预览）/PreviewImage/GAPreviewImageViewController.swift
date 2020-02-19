//
//  GAPreviewImageViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/12/10.
//  Copyright © 2018年 houjianan. All rights reserved.
//

import UIKit

class GAPreviewImageConfig {
    public var currentPage: Int = 0
    public var dataSource: [Any] = []
    
    public var backImageName: String = ""
    public var deleteImageName: String = ""
    
    public var isShowDelete: Bool = false
    public var isShowBack: Bool = false
    public var isShowPageControl: Bool = false
    
    public var pageControl_currentColor: UIColor?
    public var pageControl_defaultColor: UIColor?
}

protocol GAPreviewImageViewControllerDelegate: class {
    func GAPreviewImageViewController_deleteCurrentImage(index: Int)
    func GAPreviewImageViewController_clickBackActionComplete()
}

class GAPreviewImageViewController: UIViewController {

    public var config: GAPreviewImageConfig!
    
    weak var delegate: GAPreviewImageViewControllerDelegate?
    
    lazy var deleteButton: UIButton = {
        let v = UIButton()
        if self.config.deleteImageName.isEmpty {
            v.setTitle("删除", for: .normal)
        } else {
            v.setImage(UIImage(named: self.config.deleteImageName), for: .normal)
        }
        v.addTarget(self, action: #selector(deleteCurrentImage), for: .touchUpInside)
        return v
    }()
    
    lazy var backButton: UIButton = {
        let v = UIButton()
        if self.config.backImageName.isEmpty {
            v.setTitle("返回", for: .normal)
        } else {
            v.setImage(UIImage(named: self.config.backImageName), for: .normal)
        }
        v.addTarget(self, action: #selector(clickedBackAction), for: .touchUpInside)
        return v
    }()
    
    lazy var pageControl: UIPageControl = {
        let v = UIPageControl()
        v.currentPage = self.config.currentPage
        v.numberOfPages = self.config.dataSource.count
        v.tintColor = self.config.pageControl_defaultColor
        v.currentPageIndicatorTintColor = self.config.pageControl_currentColor
        return v
    }()
    
    lazy var previewImageView: GAPreviewImage = {
        let v = GAPreviewImage(frame: self.view.bounds, images: [UIImage(named: "ic_close")!, UIImage(named: "ic_code")!])
        v.images = [UIImage(named: "ic_close")!, UIImage(named: "ic_code")!]
        return v
    }()
    
    @objc func deleteCurrentImage() {
        delegate?.GAPreviewImageViewController_deleteCurrentImage(index: config.currentPage)
    }
    
    @objc func clickedBackAction() {
        delegate?.GAPreviewImageViewController_clickBackActionComplete()
    }
    
    private func initViews() {
        self.view.addSubview(previewImageView)
        
        if config.isShowBack {
            self.view.addSubview(backButton)
        }
        if config.isShowDelete {
            self.view.addSubview(deleteButton)
        }
        if config.isShowPageControl {
            self.view.addSubview(pageControl)
        }
    }
    
    convenience init(config: GAPreviewImageConfig?) {
        self.init()
        if config == nil {
            let c = GAPreviewImageConfig()
            c.isShowBack = true
            c.isShowDelete = true
            c.isShowPageControl = true

            self.config = c
        } else {
            self.config = config
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        initViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
