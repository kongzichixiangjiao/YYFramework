//
//  YYPlayerViewController.swift
//  YE
//
//  Created by 侯佳男 on 2017/12/1.
//  Copyright © 2017年 侯佳男. All rights reserved.
//

import UIKit
import AVFoundation

class YYPlayerViewController: UIViewController {

    @IBOutlet weak var playerBackView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // http://qiniu.puxinasset.com/Fqd1WTazeaDOih8SSxGZ33SnNyMs
        self.playerBackView.addSubview(pView)

        pView.snp.makeConstraints({ (make) in
            make.edges.equalTo(playerBackView)
        })
        // fugong000
        // testMP4
//        let path = Bundle.main.path(forResource: "fugong001.mp4", ofType: nil)
//        pView.urlString = path
//        pView.urlString = "https://qiniu.puxinasset.com/59cb9f75a170aeb3f6f144849aeb85fe.mp4"
        pView.urlString = "https://qiniu.puxinasset.com/video2.mp4"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.layoutIfNeeded()
    }
    
//    let pView = YYPlayerView.loadPlayerView().then {
//        $0.urlString = "http://qiniu.puxinasset.com/099f507aed7c5799d5ff40386a1a9615.mp4"
//    }
    
    lazy var pView: YYPlayerView = {
        let v = YYPlayerView.loadPlayerView()
        return v
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        pView.releasePlayer()
    }

    deinit {
        print("YYPlayerViewController - deinit")
    }
}

extension YYPlayerViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
