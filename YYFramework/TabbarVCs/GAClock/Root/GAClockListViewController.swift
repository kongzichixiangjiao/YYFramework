//
//  GAClockViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/21.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import ESPullToRefresh

class GAClockListViewController: GANavTableViewController {
    
    var _player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _initViews()
    }
    
    private func _initViews() {
        b_showNavigationView(title: "小雷闹钟", isShow: true)
        b_showNavigationRightButton(title: "添加", imgName: "") { (title) in
            let vc = GAClockDetailsViewController()
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        tableView.es.addPullToRefresh {
            [unowned self] in
            self.tableView.ga_reloadData()
            self.tableView.es.stopPullToRefresh(ignoreDate: true)
            self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
            self.tableView.es.resetNoMoreData()
        }
        
        tableView.ga_reloadData()
    }
    
    override func b_clickedPlaceHolderViewrefresh() {
        tableView.es.startPullToRefresh()
    }
    
}

extension GAClockListViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GALocalPushManager.share.localNotifications?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.ga_dequeueReusableCell(cellClass: GAClockListCell.self)
        #if DEBUG
        print(GALocalPushManager.share.localNotifications ?? "")
        #endif
        if let localNotifications = GALocalPushManager.share.localNotifications {
            print(localNotifications[indexPath.row])
            cell.localNotification = localNotifications[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
    
}

extension GAClockListViewController {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let nofitications = GALocalPushManager.share.localNotifications else {
                return
            }
            let info = nofitications[indexPath.row].userInfo
            GALocalPushManager.share.cancel(info: info as! [String : String])
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.ga_reloadData()
        } else if editingStyle == .insert {
        } else {
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "灭了闹钟"
    }
}

extension GAClockListViewController: GAClockDetailsViewControllerDelegate {
    func clockDetailsViewControllerAddPop() {
        tableView.ga_reloadData()
    }
}

class GAClockListCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var fireDateLabel: UILabel!
    @IBOutlet weak var isRepeatIcon: UIImageView!
    @IBOutlet weak var soundNameLabel: UILabel!
    
    var localNotification: UILocalNotification! {
        didSet {
            nameLabel.text = localNotification.alertTitle
            bodyLabel.text = localNotification.alertBody
            fireDateLabel.text = GADate.dateToDateString(localNotification.fireDate ?? Date(), dateFormat: "HH:mm:ss")
            isRepeatIcon.isHidden = false
            soundNameLabel.text = localNotification.soundName
        }
    }
}
