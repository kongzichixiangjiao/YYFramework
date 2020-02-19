//
//  PLSelectedVideoCell.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/6.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class PLSelectedVideoCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var mTitleLabel: UILabel!
    
    var reservationNumber: String = ""
    
    var model: String! {
        didSet {
            let url = model.pl_getFilePath(reservationNumber: self.reservationNumber)
            _vidoeFirstImage(url: url)
            
            getVideoTime(url: url)
            mTitleLabel.text = model 
        }
    }
    
    // 第一帧
    private func _vidoeFirstImage(url: URL) {
        DispatchQueue.global().async {
            let opts = [AVURLAssetPreferPreciseDurationAndTimingKey : false]
            let asset = AVURLAsset(url: url, options: opts)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.appliesPreferredTrackTransform = true
            var actualTime = CMTimeMake(value: 0,timescale: 600) //  CMTimeMake(a,b) a/b = 当前秒   a当前第几帧, b每秒钟多少帧
            let time = CMTimeMakeWithSeconds(10, preferredTimescale: 60) //  CMTimeMakeWithSeconds(a,b) a当前时间,b每秒钟多少帧
            var cgImage: CGImage!
            do {
                cgImage = try generator.copyCGImage(at: time, actualTime: &actualTime)
                DispatchQueue.main.async {
                    // set up imgView
                    self.imgView.image = UIImage(cgImage: cgImage)
                }
            } catch let error as NSError{
                print(error)
            }
        }
    }
    
    func getVideoTime(url: URL){
        let avUrl = AVURLAsset(url: url)
        
        let time = avUrl.duration
        let fTime = CMTimeGetSeconds(time)
        
        let m = Int(fTime) / 60
        let s = Int(fTime) % 60
        
        timeLabel.text = String(format: "%02d:%02d", m, s) 
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
