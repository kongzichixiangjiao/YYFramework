//
//  LFLiveKitViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/27.
//  Copyright © 2019 houjianan. All rights reserved.
//  LFLiveKit直播

import UIKit

class LFLiveKitViewController: UIViewController {
    
    @IBOutlet weak var preView: UIView!
    
    //    lazy var session: LFLiveSession = {
    //        let audioConfiguration = LFLiveAudioConfiguration.default()
    //        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
    //        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
    //
    //        session?.delegate = self
    //        session?.preView = self.preView
    //        return session!
    //    }()
    /*
    //创建会话并配置
    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.default()
        /*
         
         
         /// 分辨率： 360 *640 帧数：15 码率：500Kps
         case low1
         
         /// 分辨率： 360 *640 帧数：24 码率：800Kps
         case low2
         
         /// 分辨率： 360 *640 帧数：30 码率：800Kps
         case low3
         
         /// 分辨率： 540 *960 帧数：15 码率：800Kps
         case medium1
         
         /// 分辨率： 540 *960 帧数：24 码率：800Kps
         case medium2
         
         /// 分辨率： 540 *960 帧数：30 码率：800Kps
         case medium3
         
         /// 分辨率： 720 *1280 帧数：15 码率：1000Kps
         case high1
         
         /// 分辨率： 720 *1280 帧数：24 码率：1200Kps
         case high2
         
         /// 分辨率： 720 *1280 帧数：30 码率：1200Kps
         case high3
         
         ///美颜设置
         open var beautyFace: Bool
         
         ///美颜级别
         open var beautyLevel: CGFloat
         
         /// 亮度
         open var brightLevel: CGFloat
         */
        
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: .low2, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        session?.delegate = self
        return session!
    }()
    
    func startRunning() {
        //配置信息
        let stream = LFLiveStreamInfo()
        
        //设置推流地址
        stream.url = "rtmp://192.168.3.34:1935/hls/test";
        //开始推流
        session.startLive(stream)
        //不加这个无法开启,官方案例没有
        session.running = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session.preView = self.preView
        let devicePositon = self.session.captureDevicePosition
        session.captureDevicePosition = (devicePositon == .back) ? .front : .back
    }
    
    @IBAction func start(_ sender: Any) {
        //        startLive()
        startRunning()
    }
    
    @IBAction func stop(_ sender: Any) {
        stopLive()
    }
    
    //MARK: - Event
    func startLive() {
        let stream = LFLiveStreamInfo()
        stream.url = "rtmp://127.0.0.1:1935/myapp/room1";
        session.startLive(stream)
    }
    
    func stopLive() {
        
//        session.stopLive()
    }
    */
}
/*
extension LFLiveKitViewController: LFLiveSessionDelegate {
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print(debugInfo)
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print(errorCode)
    }
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print(state)
    }
}
*/
