//
//  YYPlayerControlView.swift
//  YYFramework
//
//  Created by houjianan on 2020/2/17.
//  Copyright © 2020 houjianan. All rights reserved.
//

import Foundation

enum YYPlayerControlViewButtonType: Int {
    case back = 1, fullScreen = 2, center = 3, play = 4
}

protocol YYPlayerControlViewDelegate: class {
    func playerControlViewClicked(buttonType: YYPlayerControlViewButtonType, button: UIButton)
}

class YYPlayerControlView: UIView {
    weak var delegate: YYPlayerControlViewDelegate?
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var bigImageView: UIImageView!
    @IBOutlet weak var loadingActivity: UIActivityIndicatorView!
    
    @IBOutlet weak var gestureRecognizerView: UIView!
    
    @IBOutlet weak var topBgView: UIView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var bottomBgView: UIView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var fullScreenButton: UIButton!
    @IBOutlet weak var sslider: YYPlayerSlider!
    
    static func loadView() -> YYPlayerControlView {
        return Bundle.main.loadNibNamed("YYPlayerControlView", owner: self, options: nil)?.last as! YYPlayerControlView
    }
    
    var urlString: String! {
        didSet {
            if urlString.isEmpty {
                return
            } else {
                _setup()
            }
        }
    }
    
    lazy var ql_player: PLPlayer = {
        let option = PLPlayerOption.default()
        let url = URL(string: urlString)
        
        var ql_player = PLPlayer(url: url, option: option)
        ql_player!.delegate = self
        ql_player!.playerView?.contentMode = .scaleAspectFit
        
        return ql_player!
    }()
    
    var timer: Timer?
    
    
    private func _setup() {
        guard let playerView = ql_player.playerView else {
            return
        }
        playerView.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(playerView, at: 0)
        self.ga_addLayout(top: 0, left: 0, right: 0, bottom: 0, item: playerView, toItem: self)
        sslider.delegate = self
        
        _addGesture()
    }
    
    func preStartPosTime(starTime: Int64) {
        ql_player.preStartPosTime(CMTimeMake(value: starTime, timescale: 1))
    }
    
    func play() {
    
        if _getPlayerState() == .statusPlaying {
            return
        }
        ql_player.play()
        
        _addTimer()
    }
    
    private func _play() {
        ql_player.play()
    }
    
    private func _stop() {
        ql_player.stop()
    }
    
    private func _pause() {
        ql_player.pause()
    }
    
    private func _resume() {
        ql_player.resume()
    }
    
    private func _getPlayerState() -> PLPlayerStatus {
        return ql_player.status
    }
    
    private func _addTimer() {
        _removeTimer()

        timer = Timer.palyer_scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            if let weakSelf = self {
                weakSelf.currentTimeLabel.text = weakSelf._getTimeString(time: weakSelf.ql_player.currentTime)
                weakSelf.totalTimeLabel.text = weakSelf._getTimeString(time: weakSelf.ql_player.totalDuration)
                
                if weakSelf.ql_player.currentTime.seconds == 0 || weakSelf.ql_player.totalDuration.seconds == 0 {
                    return
                }
                weakSelf.sslider.setupProgress(CGFloat(weakSelf.ql_player.currentTime.seconds / weakSelf.ql_player.totalDuration.seconds))
            }
        })
    }
    
    private func _removeTimer() {
        guard let _ = timer else {
            return
        }
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func timerAction() {
        currentTimeLabel.text = _getTimeString(time: ql_player.currentTime)
        totalTimeLabel.text = _getTimeString(time: ql_player.totalDuration)
        
        if ql_player.currentTime.seconds == 0 || ql_player.totalDuration.seconds == 0 {
            return
        }
        sslider.setupProgress(CGFloat(ql_player.currentTime.seconds / ql_player.totalDuration.seconds))
    }
    
    private func _addGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        gestureRecognizerView.addGestureRecognizer(tap)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        bottomBgView.isHidden = !bottomBgView.isHidden
        topBgView.isHidden = !topBgView.isHidden
        UIView.animate(withDuration: 0.3) {
            
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        delegate?.playerControlViewClicked(buttonType: .back, button: sender)
    }
    
    @IBAction func playAction(_ sender: UIButton) {
        if sender.isSelected {
            _pause()
        } else {
            if _getPlayerState() == .statusPaused {
                _resume()
            }
            play()
        }
        
        delegate?.playerControlViewClicked(buttonType: .play, button: sender)
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func fullScreenAction(_ sender: UIButton) {
        bottomBgView.isHidden = true
        topBgView.isHidden = true
        delegate?.playerControlViewClicked(buttonType: .fullScreen, button: sender)
        sender.isSelected = !sender.isSelected
    }
    
    private func _getTimeString(time: CMTime) -> String {
        if time.seconds == 0 {
            return "00:00"
        }
        return String(format: "%02d:%02d", Int(time.seconds) / 60, Int(time.seconds) % 60)
    }
    
    private func _unsetupPlayer() {
        if (self.ql_player.playerView?.superview != nil) {
            self.ql_player.playerView?.removeFromSuperview()
        }
        _removeTimer()
    }
    
    private func _seekTo(progress: CGFloat) {
        ql_player.seek(to: CMTimeMake(value: Int64(Double(progress) * ql_player.totalDuration.seconds), timescale: 1))
    }
    
    deinit {
        _unsetupPlayer()
    }
}

extension YYPlayerControlView: YYPlayerSliderDelegate {
    func playerSliderBegan(progress: CGFloat) {}
    func playerSliderChanged(progress: CGFloat) {}
    
    func playerSliderEnd(progress: CGFloat) {
        _seekTo(progress: progress)
        playButton.isSelected = true
    }
}

extension YYPlayerControlView: PLPlayerDelegate {
    /**
     告知代理对象 PLPlayer 即将开始进入后台播放任务
     */
    func playerWillBeginBackgroundTask(_ player: PLPlayer) {
        
    }

    /**
     告知代理对象 PLPlayer 即将结束后台播放状态任务
     */
    func playerWillEndBackgroundTask(_ player: PLPlayer) {
        
    }

    /**
     告知代理对象播放器状态变更
     */
    func player(_ player: PLPlayer, statusDidChange state: PLPlayerStatus) {
        switch state {
        case .statusUnknow:
            loadingView.isHidden = false
            break
        case .statusPreparing:
            // PLPlayer 正在准备播放所需组件，在调用 -play 方法时出现。
            loadingView.isHidden = false
            break
        case .statusReady:
            loadingView.isHidden = true
            break
        case .statusOpen:
            break
        case .statusCaching:
            break
        case .statusPlaying:
            loadingView.isHidden = true
            break
        case .statusPaused:
            break
        case .statusStopped:
            break
        case .statusError:
            loadingView.isHidden = false 
            break
        case .stateAutoReconnecting:
            break
        case .statusCompleted:
            break
        @unknown default:
            break
        }
    }
    /**
     告知代理对象播放器因错误停止播放
     */
    func player(_ player: PLPlayer, stoppedWithError error: Error?) {
        
    }

    /**
     点播已缓冲区域
     */
    func player(_ player: PLPlayer, loadedTimeRange timeRange: CMTime) {
        
    }

    /**
     视频宽高数据回调通知
     */
    func player(_ player: PLPlayer, width: Int32, height: Int32) {
        
    }

    /**
     seekTo 完成的回调通知
     */
    func player(_ player: PLPlayer, seekToCompleted isCompleted: Bool) {
        
    }

}



// 写一个Timer的分类。
extension Timer {
    class func palyer_scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: block)
        }
        return scheduledTimer(timeInterval: interval, target: self, selector: #selector(ga_handerTimerAction), userInfo: Block(block), repeats: true)
    }
    
    // 一定要加class。 Timer是类对象，只能调用类方法，不能调用实例方法（否则报错：[NSTimer xx_handerTimerAction:]: unrecognized selector sent to class 0x1105c30c0'）
    @objc class func palyer_handerTimerAction(_ sender: Timer) {
        if let block = sender.userInfo as? PlayerBlock<(Timer) -> Void> {
            block.type(sender)
        }
    }
}

//Block模型类
class PlayerBlock<T> {
    let type: T
    init(_ type: T) {
        self.type = type
    }
}
