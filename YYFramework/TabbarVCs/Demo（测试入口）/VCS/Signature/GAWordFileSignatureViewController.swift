//
//  GAWordFileSignatureViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/3/27.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import QuickLook

class GAWordFileSignatureViewController: UIViewController {

    var fileUrls: [URL] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        for i in 1..<4 {
            let path = Bundle.main.path(forResource: "apple\(i)", ofType: "docx", inDirectory: nil)
            let fileUrl = URL(fileURLWithPath: path ?? "")
            fileUrls.append(fileUrl)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        let previewController = QLPreviewController()
        previewController.dataSource = self
        // currentPreviewItemIndex 监听切换到第几个文件
        previewController.addObserver(self, forKeyPath: "currentPreviewItemIndex", options: [.old, .new], context: nil)

        self.navigationController?.pushViewController(previewController, animated: true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(change ?? "")
    }


}

extension GAWordFileSignatureViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("1")
    }
}

extension GAWordFileSignatureViewController: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return fileUrls[index] as QLPreviewItem
    }
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return fileUrls.count
    }
}
