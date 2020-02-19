//
//  PLSelectedVideoListViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/6.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class PLSelectedVideoListViewController: YYBaseCollectionViewController {

    var data = [String]()
    var reservationNumber: String = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        base_showNavigationView(title: "选择视频")
        
        _initViews()
        
        _initData(fileName: kPLVideo_test_yydh)
    }
    
    func _initViews() {
        collectionView.frame = CGRect(x: 0, y: kNavigationViewMaxY, width: kScreenWidth, height: kScreenHeight - kNavigationViewMaxY)
        collectionView.yy_register(nibName: PLSelectedVideoCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    func _initData(fileName: String = "") {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let item = (fileName.isEmpty ? "" : ("/" + fileName))
        let path = (paths.first ?? "") + "/" + kPLVideoSaveFileName + item 
        do {
            let arr = try FileManager.default.contentsOfDirectory(atPath: path)
            data = arr
            
            collectionView.reloadData()
        } catch {
            
        }
    }
}

extension PLSelectedVideoListViewController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PLSelectedVideoCell.identifier, for: indexPath) as! PLSelectedVideoCell
        cell.reservationNumber = reservationNumber
        cell.model = data[indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: kScreenWidth / 3, height: 200)
    }
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PLSPlayerViewController(nibName: "PLSPlayerViewController", bundle: nil)
        vc.name = data[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
