//
//  GANormalizeScanViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/20.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import UIKit

class GANormalizeScanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = LBXScanViewController()
        vc.scanResultDelegate = self
        vc.scanStyle = ZHScanViewStype().style
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
extension GANormalizeScanViewController: LBXScanViewControllerDelegate {
    // fillUserInformation.html?id=63&type=activity&origin=puxin&scan=pxjf
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        self.dismiss(animated: true, completion: nil)
        /*
        if error == "" || error != nil {
            Toast(text: "二维码不正确", delay: 0, duration: 2).show()
            return
        }
        if let url = scanResult.strScanned {
            var random = "&random=" + CacheTool.getDefault(cacheKey: .userId)
            if !url.contains("?") {
                random = "?" + random
            }
            let vc = PXBaseWebViewController(url: url + random, title: "")
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            Toast(text: "二维码不正确", delay: 0, duration: 2).show()
        }
 */
    }
    
}
