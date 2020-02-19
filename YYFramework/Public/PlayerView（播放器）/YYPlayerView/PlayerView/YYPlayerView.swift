//
//  YYPlayerView.swift
//  YueYe
//
//  Created by 侯佳男 on 2017/5/27.
//  Copyright © 2017年 侯佳男. All rights reserved.
// 提交github
//  播放器

import UIKit
import MediaPlayer

protocol YYPlayerViewDelegate: class {
    func playerViewClickedFullButton(state: YYPlayerScreenState)
    func playerView(playerSate: YYPlayerState)
}

open class YYPlayerView: UIView {
    
    weak var delegate: YYPlayerViewDelegate?
    
    // 是否展示预览图
    public var isShowMaskImageView: Bool = true
    // 快进/快退时间
    public var intervalTime: Double = 4
    // MARK: 播放的url
    public var urlString: String? {
        didSet {
            guard let url = URL(string: urlString!) else {
                print("错误 urlString ❎❌❌❌❌❎")
                return
            }
            
            config(url: url)
        }
    }
    
    public var url: URL? {
        didSet {
            guard let uRl = url else {
                print("错误 uRl ❎❌❌❌❌❎")
                return
            }
            config(url: uRl)
        }
    }
    
    // MARK: 初始化配置
    private func config(url: URL) {
        maskImageView.isHidden = !isShowMaskImageView
        progressSlider.delegate = self
        
        vidoeFirstImage(url: url)
        
        playAndPauseButton.playState = .pause
        
        mPlayer.url = url
        // 添加闭包
        mPlayer.displayLinkHandler = self.displayLinkHandler
        mPlayer.playerInfo = self.playerInfo
        mPlayer.playFinished = self.playFinished
        
        fullStateUpdate(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
    }
    
    // MARK: 获取设置声音的slider
    lazy var volumeSlider: UISlider? = {
        let v = MPVolumeView()
        v.showsRouteButton = true
        v.showsVolumeSlider = true
        v.sizeToFit()
        v.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        for v in v.subviews {
            if (v.classForCoder.description() == "MPVolumeSlider") {
                return v as? UISlider
            }
        }
        return nil
    }()
    
    // MARK: 初始化YYPlayerView方法
   static public func loadPlayerView() -> YYPlayerView {
        return Bundle.main.loadNibNamed("YYPlayerView", owner: nil, options: nil)?.last as! YYPlayerView
    }
    
    // 设置屏幕方向时候需要的key
    private let kOrientation = "orientation"
    // MARK: 私有属性
    private var totalTime: Double = 0 // 总时间
    private var currentTime: Double = 0 // 当前播放时间
    var fullState: YYPlayerScreenState = .small // 屏幕状态
    private var playerInfoState: AVPlayerItem.Status = .unknown // 播放内容状态
    private var isSliderDragging: Bool = false // 是否在拖拽
    private var isFinished: Bool = false // 是否播放结束 // 可以设置播放一次之后的特别状态
    private var isPlayed: Bool = false // 是否播放过
    private var isCanPlay: Bool = false // 是否可以播放
    // MARK: Player
    var mPlayer: YYPlayer = YYPlayer()
    var isShowBackButton: Bool = false {
        didSet {
            backButton.isHidden = !isShowBackButton
        }
    }
    
    // MARK: xib属性
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var topBackView: UIView! // 顶部view层
    @IBOutlet weak var screenView: UIView! // 屏幕层 承载播放界面
    @IBOutlet weak var bottomBackView: UIView! // 底部view层
    @IBOutlet weak var playAndPauseButton: YYPlayerButton! // 播放暂停按钮
    @IBOutlet weak var centerPlayButton: UIButton! // 中间播放按钮: 1、播放隐藏 2、播放完成显示
    @IBOutlet weak var currentTimeLabel: UILabel! // 当前播放时间显示
    @IBOutlet weak var totalTimeLabel: UILabel! // 总时间显示
    @IBOutlet weak var progressSlider: YYPlayerSlider!// 进度条
    @IBOutlet weak var fullScreenButton: YYPlayerButton! // 全屏、小屏切换按钮
    
    @IBOutlet weak var backButton: UIButton! // 返回按钮
    @IBOutlet weak var progressSecondsLabel: UILabel!
    @IBOutlet weak var maskImageView: UIImageView! // 遮罩图层
    @IBOutlet weak var topMaskView: YYPlayerGradualChangeView! // 顶部渐变图层
    @IBOutlet weak var bottomMaskView: YYPlayerGradualChangeView! // 底部渐变图层
    @IBOutlet weak var bottomViewRightSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomViewLeftSpace: NSLayoutConstraint!
    @IBOutlet weak var bottomViewHeight: NSLayoutConstraint!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    
    // MARK: 当前类播放状态 和YYPlayer同步
    var playerSate: YYPlayerState = .pause {
        didSet {
            delegate?.playerView(playerSate: playerSate)
            
            switch playerSate {
            case .play:
                if isFinished {
                    mPlayer.seek(seconds: 0)
                    isFinished = false
                }
                mPlayer.update(state: .play)
                if isShowMaskImageView {
                    maskImageView.isHidden = true
                }
                playAndPauseButton.playState = .play
                topAndBottomViewAnimation()
                centerPlayButton.isHidden = true
                isPlayed = true
            case .pause:
                mPlayer.update(state: .pause)
                playAndPauseButton.playState = .pause
                if isShowMaskImageView {
                    maskImageView.isHidden = false
                }
                
                centerPlayButton.isHidden = false
                isPlayed = false
            case .stop:
                mPlayer.update(state: .stop)
            case .finished:
                isFinished = true
                mPlayer.update(state: .pause)
                playAndPauseButton.playState = .pause
                if isShowMaskImageView {
                    maskImageView.isHidden = false
                }
                
                centerPlayButton.isHidden = false
                isPlayed = false
                break
            case .unknow:
                print("更改状态时候发生未知错误")
            }
        }
    }
    
    // MARK: 返回按钮事件
    @IBAction func backAction(_ sender: UIButton) {
        if fullState == .full {
            // 退出全屏
            fullAction(fullScreenButton)
        } else {
            playerViewController?.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: 播放/暂停按钮事件
    @IBAction func playAndPauseAction(_ sender: UIButton) {
        updatePlayerState()
    }
    
    // MARK: 中间播放按钮事件
    @IBAction func centerPlayButtonAction(_ sender: UIButton) {
        updatePlayerState()
    }
    
    // MARK: 播放暂停按钮点击状态改变
    private func updatePlayerState() {
        if !isCanPlay {
            return
        }
        if (playerInfoState != .readyToPlay) {
            #if DBUG
            print("播放错误")
            #endif
            mPlayer.againLoadPlayerItem()
        } else {
            if playerSate == .play {
                playerSate = .pause
                return
            }
            if playerSate == .pause || playerSate == .finished {
                playerSate = .play
            }
        }
    }
    
    // MARK: 按下结束事件
    private func _progressSliderTouchEnd(_ progress: Double) {
        progressSecondsLabel.isHidden = true
        if playAndPauseButton.playState == .play {
            playAndPauseButton.playState = .pause
        }
        playerSate = .play
        mPlayer.seek(seconds: progress * totalTime)
        isSliderDragging = false
        if isShowMaskImageView {
            maskImageView.isHidden = true
        }
    }
    
    // MARK: 全屏切换事件
    /// UIResponder类别中的一个属性allowRotation：是否可以横屏
    @IBAction func fullAction(_ sender: YYPlayerButton) {
        sender.isSelected = !sender.isSelected
        if fullState == .small {
            fullState = .full
        } else {
            fullState = .small
        }
        delegate?.playerViewClickedFullButton(state: fullState)
    }
    
    // MARK: layoutSubviews
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if fullState == .full {
            bottomViewRightSpace.constant = 90
            bottomViewLeftSpace.constant = 90
            bottomViewHeight.constant = 50
            topViewHeight.constant = 50
        } else {
            bottomViewRightSpace.constant = 0
            bottomViewLeftSpace.constant = 0
            bottomViewHeight.constant = 35
            topViewHeight.constant = 35
        }

        fullStateUpdate(frame: CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height))
    }
    
    func fullStateUpdate(frame: CGRect) {
        if !(urlString ?? "").isEmpty || url != nil {
            // 横竖屏切换从新设置playerLayer大小， 第一次添加playerLayer也会走起
            screenView.layer.insertSublayer(mPlayer.playerLayer, below: self.maskImageView.layer)
            mPlayer.playerLayer.frame = frame
        }
    }
    
    override open func awakeFromNib() {
        super.awakeFromNib()
        
        initGestureRecognizer()
    }
    
    // MARK: 添加手势
    private func initGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapScreenView(_:)))
        self.screenView.addGestureRecognizer(tap)
        
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(panScreenView(_:)))
//        self.screenView.addGestureRecognizer(pan)
    }
    
    // MARK: 点击屏幕手势方法 显示/隐藏山下渐变层
    @objc func tapScreenView(_ sender: UITapGestureRecognizer) {
        topAndBottomViewAnimation()
    }
    
    // MARK: 屏幕滑动手势
    @objc func panScreenView(_ sender: UIPanGestureRecognizer) {
        guard let view = sender.view else {
            return
        }
        let location = sender.location(in: view)
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)

        switch sender.state {
        case .began:
            panBegan(location: location, translation: translation, velocity: velocity)
            break
        case .ended:
            panEnded(location: location, translation: translation, velocity: velocity)
            break
        case .changed:
            panChanged(location: location, translation: translation, velocity: velocity)
            break
        case .cancelled:
            break
        case .failed:
            break
        case .possible:
            break
        @unknown default: break
            
        }
    }
    
    private func panBegan(location: CGPoint, translation: CGPoint, velocity: CGPoint) {

    }
    
    private func panEnded(location: CGPoint, translation: CGPoint, velocity: CGPoint) {
        if playerSate == .pause && !isPlayed {
            playerSate = .play
        }
    }
    
    private var _translationX: CGFloat = 0
    private func panChanged(location: CGPoint, translation: CGPoint, velocity: CGPoint) {
        if max(abs(translation.x), abs(translation.y)) < 20 {
            return
        } else {
            if (abs(translation.x) > abs(translation.y)) {
                #if DEBUG
                print("横向滑动")
                #endif
                if playerSate == .play {
                    playerSate = .pause
                }
                // 快进/快退
                if abs(velocity.x) > 800 || abs(velocity.y) > 800 {
                    if translation.x > 0 {
                        // 快进
                        mPlayer.seek(seconds: currentTime + intervalTime)
                    } else {
                        // 快退
                        mPlayer.seek(seconds: currentTime - intervalTime)
                    }
                }
                _translationX = translation.x
            } else if (abs(translation.x) < abs(translation.y)) {
                #if DEBUG
                print("纵向滑动")
                #endif
                // 声音/亮度
                if translation.y > 0 {
                    #if DEBUG
                    print("下")
                    #endif
                    if location.x > self.bounds.width / 2 {
                        #if DEBUG
                        print("屏幕右侧")
                        #endif
                        volumeSlider?.value = (volumeSlider?.value)! + 0.02
                    } else {
                        #if DEBUG
                        print("屏幕左侧")
                        #endif
                        UIScreen.main.brightness = UIScreen.main.brightness + 0.02
                    }
                } else {
                    #if DEBUG
                    print("上")
                    #endif
                    if location.x > self.bounds.width / 2 {
                        #if DEBUG
                        print("屏幕右侧")
                        #endif
                        volumeSlider?.value = (volumeSlider?.value)! - 0.02
                    } else {
                        #if DEBUG
                        print("屏幕左侧")
                        #endif
                        UIScreen.main.brightness = UIScreen.main.brightness - 0.02
                    }
                }
            } else {
            }
        }
    }
    
    func topAndBottomViewAnimation() {
        UIView.animate(withDuration: 0.4, animations: {
            self.topBackView.alpha = self.topBackView.alpha == 0 ? 1 : 0
            self.bottomBackView.alpha = self.bottomBackView.alpha == 0 ? 1 : 0
            self.topMaskView.alpha = self.topMaskView.alpha == 0 ? 1 : 0
            self.bottomMaskView.alpha = self.bottomMaskView.alpha == 0 ? 1 : 0
        })
    }
    
    // MARK: 第一帧图片获取
    private func vidoeFirstImage(url:URL) {
        if !maskImageView.isHidden {
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
                        self.maskImageView.image = UIImage(cgImage: cgImage)
                    }
                } catch let error as NSError{
                    print("获取第一帧出错：", error)
                }
            }
        }
    }
    
    // MARK: 实时更新进度条和时间的闭包
    lazy var displayLinkHandler: YYPlayer.DisplayLinkHandler = {
        [weak self] currentTime, catchTime, state in
        if let weakSelf = self {
            weakSelf.isCanPlay = (state == .play)
            weakSelf.loadingView.isHidden = (state == .play)
            if state == .play {
                if weakSelf.isSliderDragging {

                } else {
                    weakSelf.currentTimeLabel.text = String(format: "%02d:%02d", Int(currentTime.seconds) / 60, Int(currentTime.seconds) % 60)
                    if weakSelf.totalTime != 0.0 {
                        weakSelf.progressSlider.setupProgress(CGFloat(currentTime.seconds / weakSelf.totalTime))
                    }
                    weakSelf.currentTime = currentTime.seconds
                }
            }
        }
    }
    
    // MARK: 获取总播放时间的闭包 此处隐藏转圈圈
    lazy var playerInfo: YYPlayer.PlayerInfo = {
        [weak self] totalTime, state in
        if let weakSelf = self {
            switch state {
            case .readyToPlay:
                weakSelf.playerSate = .play
                weakSelf.loadingView.isHidden = true
                if totalTime.isValid {
                    let m = Int(totalTime.seconds) / 60
                    let s = Int(totalTime.seconds) % 60
                    weakSelf.totalTimeLabel.text = String(format: "%02d:%02d", m, s)
                    weakSelf.totalTime = totalTime.seconds
                }
            case .failed:
                weakSelf.loadingView.isHidden = false
                break
            case .unknown:
                break
            @unknown default:
                fatalError()
            }
            weakSelf.playerInfoState = state
        }
    }
    
    // MARK: 播放结束的闭包
    lazy var playFinished: YYPlayer.PlayFinished = {
        [weak self] in
        if let weakSelf = self {
            weakSelf.playerSate = .finished
            
        }
    }
    
    // MARK: 退出界面时候调用
    public func releasePlayer() {
        mPlayer.releaseAll()
    }
    
    deinit {
        
    }
}

// MARK: 获取当前的controller
extension YYPlayerView {
    
    fileprivate struct AssociatedKeys {
        static var playerViewController: UIViewController = UIViewController()
    }
    
    open var playerViewController: UIViewController? {
        get {
            guard let playerViewController = objc_getAssociatedObject(self, &AssociatedKeys.playerViewController) as? UIViewController else {
                var next = self.next
                while next != nil {
                    if next!.isKind(of: UIViewController.self) {
                        return next as? UIViewController
                    }
                    next = next?.next
                }
                return nil
            }
            return playerViewController
        }
    }
}

extension YYPlayerView: YYPlayerSliderDelegate {
    func playerSliderBegan(progress: CGFloat) {
        playerSate = .pause
        isSliderDragging = true
    }
    
    func playerSliderChanged(progress: CGFloat) {
        progressSecondsLabel.isHidden = false
        centerPlayButton.isHidden = true
        progressSecondsLabel.text = String(format: "%02d:%02d", Int(totalTime * Double(progress)) / 60, Int(totalTime * Double(progress)) % 60)
    }
    
    func playerSliderEnd(progress: CGFloat) {
        _progressSliderTouchEnd(Double(progress))
    }
}

