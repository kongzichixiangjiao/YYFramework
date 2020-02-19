//
//  PLShortVideoKitViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/3.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit

class PLShortVideoKitViewController: UIViewController {
    
}

// 模拟器不能运行 暂时注释

//import PLShortVideoKit
//
//class PLShortVideoKitViewController: UIViewController {
//
//    var reservationNumber: String = "123"
//    var allCount: Int = 0
//    private var totalDuration: CGFloat = 0.0
//    // 录制 音频 视频采集
//    private var videoConfiguration = PLSVideoConfiguration.default()
//    private var audioConfiguration = PLSAudioConfiguration.default()
//    private var shortVideoRecorder: PLShortVideoRecorder!
//    // 上传
//    private var shortVideoUploader: PLShortVideoUploader!
//
//    lazy var mainV: PLShortVideoKitView = {
//        let v = "PLShortVideoKitView".xibLoadView() as! PLShortVideoKitView
//        v.frame = self.view.bounds
//        v.delegate = self
//        return v
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        _config()
//        _initViews()
//
//        _addObserverEvent()
//    }
//
//    func _addObserverEvent() {
//        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackgroundNotification), name: UIApplication.didEnterBackgroundNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification), name: UIApplication.didBecomeActiveNotification, object: nil)
//    }
//
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    var isEnterBackground: Bool = false // 退到后台 控制录制完成是否合成
//    @objc func didEnterBackgroundNotification() {
//        isEnterBackground = true
//    }
//
//    @objc func didBecomeActiveNotification() {
//        if !(self.shortVideoRecorder.isRecording) && mainV.recordButton.isSelected {
//            self.shortVideoRecorder.startRecording(getFileURL())
//        }
//        isEnterBackground = false
//    }
//
//    private func _config() {
//        // SDK 的版本信息
//        #if DEBUG
//        print(PLShortVideoRecorder.versionInfo())
//        #endif
//        PLShortVideoRecorder.checkAuthentication { (result) in
//            #if DEBUG
//            print(result)
//            #endif
//        }
//
//        self.videoConfiguration?.position = AVCaptureDevice.Position.back
//
//        self.videoConfiguration?.videoFrameRate = 30
//        self.videoConfiguration?.videoSize = CGSize(width: 720, height: 1280)
//        self.videoConfiguration?.averageVideoBitRate = suitableVideoBitrate(videoSize: self.videoConfiguration?.videoSize ?? CGSize.zero)
//        self.videoConfiguration?.videoOrientation = AVCaptureVideoOrientation.portrait
//        self.videoConfiguration?.sessionPreset = AVCaptureSession.Preset.hd1280x720.rawValue
//
//        self.shortVideoRecorder = PLShortVideoRecorder.init(videoConfiguration: videoConfiguration, audioConfiguration: audioConfiguration)
//
//        self.shortVideoRecorder.delegate = self
//
//        self.shortVideoRecorder.maxDuration = 36000.0
//        self.shortVideoRecorder.minDuration = 36000.0
//        self.shortVideoRecorder.setBeautifyModeOn(false)
//        self.shortVideoRecorder.outputFileType = PLSFileTypeMPEG4
//        self.shortVideoRecorder.innerFocusViewShowEnable = false // 显示 SDK 内部自带的对焦动画
//        self.shortVideoRecorder.backgroundMonitorEnable = false
//        self.shortVideoRecorder.previewView?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
//        self.view.addSubview(self.shortVideoRecorder.previewView!)
//
//        self.shortVideoRecorder.startCaptureSession()
//    }
//
//    func _initData(fileName: String = "") -> Int {
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        let item = (fileName.isEmpty ? "" : ("/" + fileName))
//        let path = (paths.first ?? "") + "/" + kPLVideoSaveFileName + item
//        do {
//            let arr = try FileManager.default.contentsOfDirectory(atPath: path)
//            return arr.count
//        } catch {
//            return 0
//        }
//    }
//
//    func getFileURL() -> URL {
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        let catchs = kPLVideoSaveFileName + "/" + "catch"
//        let path = (paths.first ?? "") + "/" + catchs
//        let fileManager = FileManager.default
//        if !fileManager.fileExists(atPath: path) {
//            // 如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
//            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//        }
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyyMMddHHmmss"
//        let nowTimeStr = formatter.string(from: Date.init(timeIntervalSinceNow: 0))
//        let name = nowTimeStr
//        let fileName = path + "/" + name + ".mp4"
//        let fileURL = URL.init(fileURLWithPath: fileName)
//
//        return fileURL
//    }
//
//    func exportAudioMixPath() -> URL {
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        let path = (paths.first ?? "") + "/" + kPLVideoSaveFileName + "/" + reservationNumber
//        let fileManager = FileManager.default
//        if !fileManager.fileExists(atPath: path) {
//            // 如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
//            try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//        }
//
//        allCount = _initData(fileName: reservationNumber)
//
//        let name = "签约视频" + String(allCount)
//        let fileName = path + "/" + name + ".mp4"
//        let fileURL = URL.init(fileURLWithPath: fileName)
//
//        return fileURL
//    }
//
//    private func _initViews() {
//        self.view.addSubview(mainV)
//    }
//
//    func suitableVideoBitrate(videoSize: CGSize) -> UInt {
//        // 下面的码率设置均偏大，为了拍摄出来的视频更清晰，选择了偏大的码率，不过均比系统相机拍摄出来的视频码率小很多
//        if (videoSize.width + videoSize.height > 720 + 1280) {
//            return 8 * 1000 * 1000
//        } else if (videoSize.width + videoSize.height > 544 + 960) {
//            return 4 * 1000 * 1000
//        } else if (videoSize.width + videoSize.height > 360 + 640) {
//            return 2 * 1000 * 1000
//        } else {
//            return 1 * 1000 * 1000
//        }
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
//
//        if !tioncheckAuthorizationStatus(mediaType: .audio) {
//            self.view.ga_showView("开启音频")
//        }
//
//        if !tioncheckAuthorizationStatus(mediaType: .video) {
//            self.view.ga_showView("开启视频")
//        }
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
//    }
//
//    func getFilePath(name: String) -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        let item = "/" + reservationNumber + "/" + name
//        let path = (paths.first ?? "") + "/" + kPLVideoSaveFileName + item
//        return path
//    }
//
//    @objc func getList(b: UIButton) {
//        let vc = PLSelectedVideoListViewController()
//        vc.reservationNumber = reservationNumber
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//    // 旋转摄像头
//    func toggleCamera() {
//        // 采集帧率不大于 30 帧的时候，使用 [self.shortVideoRecorder toggleCamera] 和 [self.shortVideoRecorder toggleCamera:block] 都可以。当采集大于 30 帧的时候，为确保切换成功，需要先停止采集，再切换相机，切换完成再启动采集。如果不先停止采集，部分机型上采集 60 帧的时候，切换摄像头可能会耗时几秒钟
//        if (self.videoConfiguration?.videoFrameRate ?? 0 > UInt(30)) {
//            mainV.positionButton.isEnabled = false
//            self.shortVideoRecorder.stopCaptureSession()
//            self.shortVideoRecorder.toggleCamera {
//                [weak self] isFinish in
//                if let weakSelf = self {
//                    weakSelf.checkActiveFormat()// 默认的 active 可能最大只支持采集 30 帧，这里手动设置一下
//                    weakSelf.shortVideoRecorder.startCaptureSession()
//                    DispatchQueue.main.async {
//                        weakSelf.mainV.positionButton.isEnabled = true
//                    }
//                }
//            }
//        } else {
//            self.shortVideoRecorder.toggleCamera()
//        }
//    }
//
//    func checkActiveFormat() {
//        var needCaptureSize = self.videoConfiguration?.videoSize
//
//        if AVCaptureVideoOrientation.portrait == self.videoConfiguration?.videoOrientation || AVCaptureVideoOrientation.portraitUpsideDown == self.videoConfiguration?.videoOrientation {
//            needCaptureSize = CGSize(width: self.videoConfiguration?.videoSize.height ?? 0.0, height: self.videoConfiguration?.videoSize.width ?? 0.0)
//        }
//
//        let activeFormat = self.shortVideoRecorder.videoActiveFormat
//        var frameRateRange = activeFormat.videoSupportedFrameRateRanges.first
//        var captureSize = CMVideoFormatDescriptionGetDimensions(activeFormat.formatDescription)
//
//        if (UInt(frameRateRange!.maxFrameRate) < self.videoConfiguration!.videoFrameRate ||
//            UInt(frameRateRange!.minFrameRate) > self.videoConfiguration!.videoFrameRate ||
//            UInt(needCaptureSize!.width) > captureSize.width ||
//            UInt(needCaptureSize!.height) > captureSize.height) {
//
//            let videoFormats = self.shortVideoRecorder.videoFormats
//            for format in videoFormats {
//                frameRateRange = format.videoSupportedFrameRateRanges.first
//                captureSize = CMVideoFormatDescriptionGetDimensions(format.formatDescription)
//
//                if (UInt(frameRateRange!.maxFrameRate) >= self.videoConfiguration!.videoFrameRate &&
//                    UInt(frameRateRange!.minFrameRate) <= self.videoConfiguration!.videoFrameRate &&
//                    captureSize.width >= UInt(needCaptureSize!.width) &&
//                    captureSize.height >= UInt(needCaptureSize!.height)) {
//                    self.shortVideoRecorder.videoActiveFormat = format
//                    break
//                }
//            }
//        }
//    }
//
//    func playEvent(asset: AVAsset) {
////        let exportSession = PLSAVAssetExportSession.init(asset: asset)
////        let outputPath1 = self.exportAudioMixPath()
////        exportSession?.outputURL = outputPath1
////        exportSession?.shouldOptimizeForNetworkUse = true
////        exportSession?.delegate = self
////        exportSession?.isExportMovieToPhotosAlbum = false
////        exportSession?.completionBlock = {
////            [weak self] url in
////            if let weakSelf = self {
////                print(url)
////            }
////        }
////
////        exportSession?.processingBlock = {
////            [weak self] progress in
////            if let weakSelf = self {
////                print("progress = ", progress)
////            }
////        }
////
////        exportSession?.failureBlock = {
////            [weak self] error in
////            if let weakSelf = self {
////                print(error)
////            }
////        }
////        exportSession?.exportAsynchronously()
//
//        // 原生
//
//        let session = AVAssetExportSession.init(asset: asset, presetName: AVAssetExportPresetHighestQuality)
//        session?.outputFileType = .mp4
//        let outputPath = self.exportAudioMixPath()
//        session?.outputURL = outputPath
//        session?.exportAsynchronously(completionHandler: {
//            print("保存成功")
//
//            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//            let catchs = kPLVideoSaveFileName + "/" + "catch"
//            let path = (paths.first ?? "") + "/" + catchs
//            let fileManager = FileManager.default
//            if !fileManager.fileExists(atPath: path) {
//                // 如果不存在,则说明是第一次运行这个程序，那么建立这个文件夹
//                try! fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
//            }
//            try! fileManager.removeItem(atPath: path)
//
//            self.shortVideoRecorder.deleteAllFiles()
//            DispatchQueue.main.async {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//                self.view.hideLoading()
//            }
//        })
//
//    }
//}
//
//// MARK: PLSAVAssetExportSessionDelegate 主要做滤镜处理
//extension PLShortVideoKitViewController: PLSAVAssetExportSessionDelegate {
//
//}
//
//// MARK: 录制
//extension PLShortVideoKitViewController: PLShortVideoRecorderDelegate {
//    // 开始录制
//    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didStartRecordingToOutputFileAt fileURL: URL) {
//        self.view.ga_showView("开始录制")
//    }
//    // 录制过程中
//    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
//        let allDution = totalDuration
//        let h = Int(allDution) / 3600
//        let m = Int(allDution) / 60
//        let s = Int(allDution) % 60
//        mainV.timeLabel.text = String(format: "%02d:%02d:%02d", h, m, s)
//    }
//    // 录制一段完成
//    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didFinishRecordingToOutputFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
//        self.totalDuration = totalDuration
//        print(Thread.current)
//        self.view.ga_showView("录制完成")
//        if !isEnterBackground {
//            let asset = self.shortVideoRecorder.assetRepresentingAllFiles()
//            playEvent(asset: asset)
//        }
//    }
//    // 删除视频
//    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didDeleteFileAt fileURL: URL, fileDuration: CGFloat, totalDuration: CGFloat) {
//
//    }
//
//    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didGetMicrophoneAuthorizationStatus status: PLSAuthorizationStatus) {
//        if status == PLSAuthorizationStatusAuthorized {
//            recorder.startCaptureSession()
//        } else {
//
//        }
//    }
//
//    func shortVideoRecorder(_ recorder: PLShortVideoRecorder, didGetCameraAuthorizationStatus status: PLSAuthorizationStatus) {
//        if status == PLSAuthorizationStatusAuthorized {
//            recorder.startCaptureSession()
//        } else {
//
//        }
//    }
//
//    func tioncheckAuthorizationStatus(mediaType: AVMediaType) -> Bool {
//        let authorStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
//        if authorStatus == .restricted || authorStatus == .denied {
//            return false
//        }
//        return true
//    }
//
//    func checkAuthoriztion() -> Bool {
//        if !tioncheckAuthorizationStatus(mediaType: .audio) {
//            goSystemSetting()
//            return false
//        }
//
//        if !tioncheckAuthorizationStatus(mediaType: .video) {
//            goSystemSetting()
//            return false
//        }
//
//        return true
//    }
//
//    func goSystemSetting() {
//        let settingsUrl = URL(string: UIApplication.openSettingsURLString)!
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
//        } else {
//
//        }
//    }
//
//}
//
//// MARK: 上传
//extension PLShortVideoKitViewController: PLShortVideoUploaderDelegate {
//    // 上传完成
//    func shortVideoUploader(_ uploader: PLShortVideoUploader, complete info: PLSUploaderResponseInfo, uploadKey: String, resp: [AnyHashable : Any]?) {
//        let s = "https://qiniu.puxinasset.com/123_0.mp4"
//        print(s)
//        let urlString =  "http://panm32w98.bkt.clouddn.com/" + uploadKey
//        print(urlString)
//        print(info.duration)
//    }
//
//    // 上传进度
//    func shortVideoUploader(_ uploader: PLShortVideoUploader, uploadKey: String?, uploadPercent: Float) {
//        print(uploadPercent)
//    }
//
//    func uploadVideo() {
//        //        let token = "LF4EFQrhdFR-Adabi7lNMchxnG2V0koEdlYBBLqm:_m-LDPkDKvsK4JRuhYunh5D1gNQ=:eyJzY29wZSI6InB1eGluIiwiZGVhZGxpbmUiOjE1NzgwMzg2ODV9"
//        let token = "QxZugR8TAhI38AiJ_cptTl3RbzLyca3t-AAiH-Hh:3hK7jJJQKwmemseSwQ1duO5AXOw=:eyJzY29wZSI6InNhdmUtc2hvcnQtdmlkZW8tZnJvbS1kZW1vIiwiZGVhZGxpbmUiOjM1NTk2OTU4NzYsInVwaG9zdHMiOlsiaHR0cDovL3VwLXoyLnFpbml1LmNvbSIsImh0dHA6Ly91cGxvYWQtejIucWluaXUuY29tIiwiLUggdXAtejIucWluaXUuY29tIGh0dHA6Ly8xNC4xNTIuMzcuNCJdfQ=="
//        let name = "123_3.mp4"
//        let key = getKey(name: name)
//        let uploadConfig = PLSUploaderConfiguration(token: token, videoKey: key, https: true, recorder: nil)
//        self.shortVideoUploader = PLShortVideoUploader(configuration: uploadConfig!)
//        self.shortVideoUploader.delegate = self
//
//        self.shortVideoUploader.uploadVideoFile(getFilePath(name: name))
//    }
//
//    func getKey(name: String) -> String {
//        return "" + name
//    }
//}
//
//extension PLShortVideoKitViewController: PLShortVideoKitViewDelegate {
//    func shortVideoKitView(buttonType: PLShortVideoKitViewType, clickedType: Int) {
//        switch buttonType {
//        case .record:
//            if checkAuthoriztion() {
//                if (self.shortVideoRecorder.isRecording) {
//
//                    self.view.showLoading()
//                    UIApplication.shared.isNetworkActivityIndicatorVisible = true
//
//                    self.shortVideoRecorder.stopRecording()
//                    self.totalDuration = 0.0
//                } else {
//                    mainV.timeLabel.text = "00:00:00"
//                    self.shortVideoRecorder.startRecording(getFileURL())
//                }
//            }
//            break
//        case .back:
//            self.navigationController?.popViewController(animated: true)
//            break
//        case .postion:
//            toggleCamera()
//            break
//        case .upload:
//            uploadVideo()
//
//            break
//        }
//    }
//}
