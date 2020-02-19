//
//  YYGIFImage.swift
//  YYFramework
//
//  Created by 侯佳男 on 2018/8/13.
//  Copyright © 2018年 houjianan. All rights reserved.
// GIF 图片展示

/*
 let filePath    = Bundle.main.path(forResource: "guideImage6.gif", ofType: nil) ?? ""
 let url = URL(fileURLWithPath: filePath)
 let data = try? Data(contentsOf: url, options: Data.ReadingOptions.uncached)
 let type = GAImageType.checkDataType(data: data)
 let gifV = YYGIFImage(frame: self.view.bounds, gifData: data!)
 self.view.addSubview(gifV)
 */

import UIKit

class YYGIFImage: UIView {

    // gif图片timer
    private var gifTimer: DispatchSourceTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, gifData: Data) {
        self.init(frame: frame)
        
        // kCGImagePropertyGIFLoopCount  The number of times to repeat an animated sequence.
        let gifProperties = [kCGImagePropertyGIFDictionary : [kCGImagePropertyGIFLoopCount : 0]]
        
        guard let gifDataSource = CGImageSourceCreateWithData(gifData as CFData, gifProperties as CFDictionary) else {
            return
        }
        // CGImageSourceGetCount 返回图像源中的图像数量(不包括缩略图)。
        let gifImageCount = CGImageSourceGetCount(gifDataSource)
        // gif 图片组
        var images = [UIImage]()
        // gif 播放时长
        var gifDuration = 0.0
        
        // 计算总帧时长
        for i in 0..<gifImageCount {
            // CGImageSourceCreateImageAtIndex 为与图像源中的指定索引关联的图像数据创建CGImage对象。
            guard let imgaeRef = CGImageSourceCreateImageAtIndex(gifDataSource, i, gifProperties as CFDictionary) else {
                return
            }
            
            if gifImageCount == 1 {
                // 单帧  infinity 正无穷
                gifDuration = Double.infinity
            } else {
                // 多帧  CGImageSourceCopyPropertiesAtIndex  Returns the properties of the image at a specified location in an image source.
                guard let properties = CGImageSourceCopyPropertiesAtIndex(gifDataSource, i, nil), let gifInfo = (properties as NSDictionary)[kCGImagePropertyGIFDictionary] as? NSDictionary,
                    let frameDuration = gifInfo[kCGImagePropertyGIFDelayTime] as? NSNumber else {
                    return
                }
                gifDuration += frameDuration.doubleValue
                let image = UIImage(cgImage: imgaeRef, scale: UIScreen.main.scale, orientation: .up)
                images.append(image)
            }
        }
        
        // 计算循环时间
        var repeating = gifDuration / Double(gifImageCount)
        repeating = repeating > 1.2 ? 0.1 : repeating
        repeating = (gifImageCount > 30 && repeating > 0.06) ? 0.06 : repeating
        repeating = (gifImageCount > 50 && repeating > 0.04) ? 0.04 : repeating
        
        gifTimer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
        gifTimer?.schedule(deadline: .now(), repeating: repeating)
        var index = 0
        gifTimer?.setEventHandler(handler: {
            [weak self] in
            DispatchQueue.main.async {
                index = index % gifImageCount
                let imageref: CGImage = CGImageSourceCreateImageAtIndex(gifDataSource, index, nil)!
                self?.layer.contents = imageref
                index += 1
            }
        })
        gifTimer?.resume()
    }
    
    deinit {
        gifTimer?.cancel()
        gifTimer = nil
    }
    
}
