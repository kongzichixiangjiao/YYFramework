//
//  PXVideoViewController.swift
//  YYFramework
//
//  Created by puxin on 2019/5/29.
//  Copyright © 2019年 houjianan. All rights reserved.
//  视频压缩

import UIKit
import UIKit
import MobileCoreServices
import AssetsLibrary
import AVKit
import AVFoundation
import Photos
class PXVideoViewController: UIViewController,  UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建一个ContactAdd类型的按钮
        let button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x:10, y:150, width:100, height:30)
        button.setTitle("选择视频", for:.normal)
        button.addTarget(self, action:#selector(selectVideo), for:.touchUpInside)
        self.view.addSubview(button)
    }
    
    
    
    @IBAction func touchViewButton(_ sender: UIButton) {
        
        selectVideo()
        
    }
    
    
    //选择视频
    @objc func selectVideo() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            //初始化图片控制器
            let imagePicker = UIImagePickerController()
            //设置代理
            imagePicker.delegate = self
            //指定图片控制器类型
            imagePicker.sourceType = .photoLibrary
            //只显示视频类型的文件
            imagePicker.mediaTypes = [kUTTypeMovie as String]
            //不需要编辑
            imagePicker.allowsEditing = false
            //弹出控制器，显示界面
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            print("读取相册错误")
        }
    }
    
    //选择视频成功后代理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //获取视频路径（选择后视频会自动复制到app临时文件夹下）
        let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
        let pathString = videoURL.relativePath
        print("视频地址：\(pathString)")
        print("原视频大小\(fileSize(path: videoURL))M")
        
        
        
        let avAsset = AVURLAsset.init(url: videoURL, options:nil)
        
        //        let compatiblePresets = AVAssetExportSession.exportPresets(compatibleWith: avAsset)
        //        //导出品质
        //        if compatiblePresets.contains(AVAssetExportPresetLowQuality) {
        
        //            压缩分辨率
        let exportSession = AVAssetExportSession.init(asset: avAsset, presetName: AVAssetExportPresetLowQuality)
        //优化网络
        exportSession?.shouldOptimizeForNetworkUse = true
        //转换后的格式
        exportSession?.outputFileType = AVFileType.mp4
        
        //当前时间的时间戳
        let timeInterval:TimeInterval = NSDate().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        
        let pathURL:URL! = URL.init(fileURLWithPath: "\(NSHomeDirectory())/Documents/\(timeStamp).mp4")
        
        exportSession?.outputURL = pathURL
        print("新的视频地址：\(pathURL.absoluteString)")
        
        //异步导出
        exportSession?.exportAsynchronously(completionHandler: {
            print("压缩完毕,压缩后大小 \(self.fileSize(path:pathURL))")
            
            if exportSession?.status ==  AVAssetExportSession.Status.completed {
                //                    self.saveVideo(outputFileURL: URL.init(string: path as String) as! URL)
                UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(pathURL.path)
                //                    self.saveVideo(outputFileURL: pathURL)
                print("压缩完毕,压缩后大小 \(self.fileSize(path:pathURL))")
                
                //播放视频文件
                self.reviewVideo(pathURL)
                
            }else {
                
                print(exportSession?.progress ?? 0)
            }
            
        })
        
        
        
        //        }
        
        
        //图片控制器退出
        self.dismiss(animated: true, completion: {})
        
    }
    
    //存入相册
    func saveVideo(outputFileURL:URL) {
        
        // ALAssetsLibrary提供了我们对iOS设备中的相片、视频的访问。
        //        let photoLibrary = PHPhotoLibrary.init()
        PHPhotoLibrary.shared().performChanges({
            print("保存成功")
            PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: outputFileURL)
        }) { (boo, error) in
            
//            print(error)
        }
        
        
        //        let library = ALAssetsLibrary()
        //        library.writeVideoAtPath(toSavedPhotosAlbum: outputFileURL) { (assetUrl, error) in
        //            if error != nil {
        //
        //                print("保存视频失败:\(error)")
        //
        //            } else {
        //
        //                print("保存视频到相册成功")
        //
        //            }
        //        }
        //
    }
    
    //获取压缩后的大小
    
    func fileSize(path:URL) -> Float {
        
        return Float(NSData.init(contentsOf: path)?.length ?? 0) / 1024.00 / 1024.00;
        
    }
    
    
    //视频播放
    func reviewVideo(_ videoURL: URL) {
        //定义一个视频播放器，通过本地文件路径初始化
        let player = AVPlayer(url: videoURL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
