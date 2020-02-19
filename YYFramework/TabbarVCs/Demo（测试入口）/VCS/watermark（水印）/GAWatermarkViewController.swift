//
//  GAWatermarkViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/10/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GAWatermarkViewController: GANavViewController {
    
    @IBOutlet weak var watermarkView: UIView!
    @IBOutlet weak var watermarkImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        b_showNavigationView(title: "水印")
        
        watermarkView.ga_addWaterText(text: "侯佳男 13146218617",
                                      color: UIColor.green,
                                      font: UIFont.systemFont(ofSize: 20),
                                      fontSize: 20,
                                      lineCount: 10,
                                      rowCount: 10,
                                      lineSpace: 120,
                                      rowSpace: 120)
        
        watermarkImageView.ga_addWaterText(text: "侯佳男",
                                           color: UIColor.green,
                                           font: UIFont.systemFont(ofSize: 14),
                                           fontSize: 14,
                                           lineCount: 10,
                                           rowCount: 10,
                                           lineSpace: 120,
                                           rowSpace: 120)
    }
    
    @IBAction func removeWatermark(_ sender: Any) {
        watermarkView.ga_removeTextLayer(water: "侯佳男 13146218617")
    }
    @IBAction func action(_ sender: Any) {
        print("----")
    }
}
