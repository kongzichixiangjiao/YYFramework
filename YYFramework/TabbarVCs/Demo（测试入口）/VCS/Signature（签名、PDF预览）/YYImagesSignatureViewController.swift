//
//  YYImagesSignatureViewController.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/3/26.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class YYImagesSignatureViewController: YYBaseTableViewController {

    var data: [[String : Any]] = [["url" : "", "imageData" : UIImage(), "frame" : ""], ["url" : "", "imageData" : "", "frame" : ""]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        base_showNavigationView(title: "list", isShow: false)
        base_initTableView()
    }
    
    override func base_initTableView() {
        super.base_initTableView()
        tableView.yy_register(nibName: YYImagesSignatureCell.identifier)
    }

}

extension YYImagesSignatureViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: YYImagesSignatureCell.identifier, for: indexPath) as! YYImagesSignatureCell
        cell.delegate = self 
        cell.model = data[0]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension YYImagesSignatureViewController: YYImagesSignatureCellDelegate {
    func imagesSignatureCellClickedSignatureArea() {
        let vc = YYMosaicViewController(nibName: "YYMosaicViewController", bundle: nil)
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension YYImagesSignatureViewController: YYMosaicViewControllerDelegate {
    func mosaicViewControllerGet(resultsImageView: UIImageView) {
        data[0]["imageData"] = resultsImageView.image
        tableView.reloadData()
    }
}
