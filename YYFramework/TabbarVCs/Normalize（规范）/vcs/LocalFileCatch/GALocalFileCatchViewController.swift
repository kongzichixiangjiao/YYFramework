//
//  GALocalFileCatchViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/3/4.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GALocalFileCatchViewController: UIViewController {

    @IBOutlet weak var l: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        l.text = "\(GALocalFileCatchManager().ga_fileSizeOfCache())"
    }

    @IBAction func clear(_ sender: Any) {
        GALocalFileCatchManager().ga_clearCache()
        l.text = "\(GALocalFileCatchManager().ga_fileSizeOfCache())"
    }
    
}
