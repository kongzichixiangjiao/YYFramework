//
//  GALocalVideoPlayerViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/7/29.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
//import SuperPlayer

//class GASuperPlayerView: SuperPlayerView {
//
//}

class GALocalVideoPlayerViewController: UIViewController {
    
    var player: AVPlayer!
//    var _playerView: SuperPlayerView!
//    var ali_player: AliPlayer!
    
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        _initViews()
        //        _initSuperPlayerView()
        
        //        _initAliPlayer()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //        let path = Bundle.main.path(forResource: "testMP4.mp4", ofType: nil)
        //        let vc = AVPlayerViewController()
        //        vc.player = AVPlayer(url: URL(fileURLWithPath: path ?? ""))
        //        self.present(vc, animated: true, completion: nil)
        
        //        player.play()
    }
    
    
    func _initAliPlayer() {
//    // 阿里播放器
//        let s = "http://1256170760.vod2.myqcloud.com/5406930dvodtranscq1256170760/b7421f3f5285890798529155765/adp.10.m3u8"
//        let s1 = "http://1256170760.vod2.myqcloud.com/7d1ca565vodcq1256170760/b7421f3f5285890798529155765/hVA2hqDsIlkA.mp4"
//        let s2 = "rtmp://3891.liveplay.myqcloud.com/live/3891_user_a6432fe5_c517"
//
//        ali_player = AliPlayer()
//        ali_player.delegate = self
//        ali_player.scalingMode = AVP_SCALINGMODE_SCALEASPECTFIT
//        ali_player.rate = 1
//        ali_player.isLoop = false
//        ali_player.playerView = bgView
//
//        let source = AVPUrlSource()
//        source.playerUrl = URL(string: s1)
//        ali_player.setUrlSource(source)
//
//        let config = ali_player.getConfig()
//        ali_player.setConfig(config)
//
//        ali_player.prepare()
//
//        ali_player.start()
    }
    
    func _initSuperPlayerView() {
//        // 腾讯播放器
//        _playerView = GASuperPlayerView()
//
//        _playerView.delegate = self
//
//        _playerView.layoutStyle = .compact
//        // 设置父View
//        _playerView.fatherView = self.bgView
//
//        let playerModel = SuperPlayerModel()
//
//        //        let videoId = SuperPlayerVideoId()
//        //        videoId.appId = 1256170760 // 这里换成您的 appID
//        //        videoId.fileId = "5285890798529155765" // 这里换成需要播放视频的 fileID
//        //
//        //        playerModel.videoId = videoId
//
//        // 设置播放地址，直播、点播都可以
//        let s = "http://cyberplayerplay.kaywang.cn/cyberplayer/demo201711-L1.m3u8"
//        let s1 = "http://1256170760.vod2.myqcloud.com/7d1ca565vodcq1256170760/b7421f3f5285890798529155765/hVA2hqDsIlkA.mp4"
//        let s2 = "rtmp://3891.liveplay.myqcloud.com/live/3891_user_a6432fe5_c517"
//        playerModel.videoURL = s
//
//        // 开始播放
//        _playerView.play(with: playerModel)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func _initViews() {
        let path = Bundle.main.path(forResource: "testAvi.avi", ofType: nil)
        let url = URL(fileURLWithPath: path ?? "")
        //设置播放的项目
        let item = AVPlayerItem(url: url)
        //初始化player对象
        player = AVPlayer(playerItem: item)
        //设置播放页面
        let layer = AVPlayerLayer.init(player: player)
        //设置播放页面的大小
        layer.frame = CGRect(x: 0, y: 0, width: 400, height: 600)
        layer.backgroundColor = UIColor.lightGray.cgColor
        //设置播放窗口和当前视图之间的比例显示内容
        layer.videoGravity = .resizeAspect
        self.view.layer.addSublayer(layer)
        //添加播放视图到self.view
        //设置播放的默认音量值
        self.player.volume = 1.0
    }
    
    @IBAction func plRooter(_ sender: Any) {
        let vc = GAPLPlayerViewController(nibName: "GAPLPlayerViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func liveDetails(_ sender: Any) {
        let vc = GALiveDetailsViewController(nibName: "GALiveDetailsViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //        _playerView.resetPlayer()
    }
}

//extension GALocalVideoPlayerViewController: SuperPlayerDelegate {
//    func superPlayerFullScreenChanged(_ player: SuperPlayerView!) {
//        //        (player.controlView as! SPDefaultControlView).topImageView.isHidden = true
//        (player.controlView as! SPDefaultControlView).moreBtn.isHidden = true
//    }
//}

//extension GALocalVideoPlayerViewController: AVPDelegate {
//    
//    /**
//     @brief 播放器事件回调
//     @param player 播放器player指针
//     @param eventType 播放器事件类型，@see AVPEventType
//     */
//    func onPlayerEvent(_ player: AliPlayer!, eventType: AVPEventType) {
//        switch (eventType) {
//        case AVPEventPrepareDone:
//            // 准备完成
//            break;
//        case AVPEventAutoPlayStart:
//            // 自动播放开始事件
//            break;
//        case AVPEventFirstRenderedStart:
//            // 首帧显示
//            break;
//        case AVPEventCompletion:
//            // 播放完成
//            break;
//        case AVPEventLoadingStart:
//            // 缓冲开始
//            break;
//        case AVPEventLoadingEnd:
//            // 缓冲完成
//            break;
//        case AVPEventSeekEnd:
//            // 跳转完成
//            break;
//        case AVPEventLoopingStart:
//            // 循环播放开始
//            break;
//        default:
//            break;
//        }
//    }
//    
//    /**
//     @brief 视频当前播放位置回调
//     @param player 播放器player指针
//     @param position 视频当前播放位置
//     */
//    func onCurrentPositionUpdate(_ player: AliPlayer!, position: Int64) {
//        // 更新进度条
//    }
//    
//}
