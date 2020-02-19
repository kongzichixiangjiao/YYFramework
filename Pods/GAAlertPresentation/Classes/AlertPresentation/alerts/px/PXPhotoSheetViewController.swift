//
//  PXPhotoSheetViewController.swift
//  IFA-B
//
//  Created by 侯佳男 on 2018/8/8.
//  Copyright © 2018年 ZHENGHEHOLDING. All rights reserved.
//

import UIKit

open class PXPhotoSheetViewController: YYPresentationBaseViewController {

    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var cancleButton: UIButton!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        topButton.yy_button_circularBead(byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 13, height: 13))
//        middleButton.yy_button_circularBead(byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 13, height: 13))
//        cancleButton.yy_button_circularBead(byRoundingCorners: [.topRight, .topLeft, .bottomLeft, .bottomRight], cornerRadii: CGSize(width: 13, height: 13))
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 拍照
    @IBAction func photograph(_ sender: Any) {
        dismiss {
            [weak self] in
            if let weakself = self {
                weakself.clickedHandler!(1, nil)
            }
        }
    }
    
    // 相册
    @IBAction func photoAlbum(_ sender: Any) {
        dismiss {
            [weak self] in
            if let weakself = self {
                weakself.clickedHandler!(2, nil)
            }
        }
        
    }
    
    @IBAction func cancle(_ sender: Any) {
        dismiss()
    }
    

}
