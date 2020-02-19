//
//  GA_BDBaseViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/29.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit
import AVKit

class GA_BDFaceViewController: UIViewController {

//    var videoCapture: VideoCaptureDevice!
    // 预览范围
    var previewRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
    // 用于播放视频流
    var detectRect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _initSDK()
        
        _initVideoCapture()
    
    }
    
    private func _initVideoCapture() {
//        videoCapture = VideoCaptureDevice()
//        videoCapture.delegate = self
    }
    
    private func _initSDK() {
//        // 设置最小检测人脸阈值
//        FaceSDKManager.sharedInstance()?.setMinFaceSize(200)
//        // 设置截取人脸图片大小
//        FaceSDKManager.sharedInstance()?.setCropFaceSizeWidth(400)
//        // 设置人脸遮挡阀值
//        FaceSDKManager.sharedInstance()?.setOccluThreshold(0.5)
//        // 设置亮度阀值
//        FaceSDKManager.sharedInstance()?.setIllumThreshold(40)
//        // 设置图像模糊阀值
//        FaceSDKManager.sharedInstance()?.setBlurThreshold(0.7)
//        // 设置头部姿态角度
//        FaceSDKManager.sharedInstance()?.setEulurAngleThrPitch(10, yaw: 10, roll: 10)
//        // 设置是否进行人脸图片质量检测
//        FaceSDKManager.sharedInstance()?.setIsCheckQuality(true)
//        // 设置超时时间
//        FaceSDKManager.sharedInstance()?.conditionTimeout = 10
//        // 设置人脸检测精度阀值
//        FaceSDKManager.sharedInstance()?.setNotFaceThreshold(0.6)
//        // 设置照片采集张数
//        FaceSDKManager.sharedInstance()?.setMaxCropImageNum(1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        IDLFaceDetectionManager.sharedInstance()?.startInitial()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        IDLFaceDetectionManager.sharedInstance()?.reset()
    }

}

//extension GA_BDFaceViewController: CaptureDataOutputProtocol {
//    func captureOutputSampleBuffer(_ image: UIImage!) {
//        IDLFaceDetectionManager.sharedInstance()?.detectStratrgy(withNormalImage: image, previewRect: previewRect, detect: detectRect, completionHandler: { (faceInfo, images, remindCode) in
//            switch remindCode {
//                
//            case .OK:
//                print("OK---------")
//                break
//            case .pitchOutofDownRange:
//                break
//            case .pitchOutofUpRange:
//                break
//            case .yawOutofLeftRange:
//                break
//            case .yawOutofRightRange:
//                break
//            case .poorIllumination:
//                break
//            case .noFaceDetected:
//                break
//            case .dataHitOne:
//                break
//            case .dataHitLast:
//                break
//            case .imageBlured:
//                break
//            case .occlusionLeftEye:
//                break
//            case .occlusionRightEye:
//                break
//            case .occlusionNose:
//                break
//            case .occlusionMouth:
//                break
//            case .occlusionLeftContour:
//                break
//            case .occlusionRightContour:
//                break
//            case .occlusionChinCoutour:
//                break
//            case .tooClose:
//                break
//            case .tooFar:
//                break
//            case .beyondPreviewFrame:
//                break
//            case .verifyInitError:
//                break
//            case .verifyDecryptError:
//                break
//            case .verifyInfoFormatError:
//                break
//            case .verifyExpired:
//                break
//            case .verifyMissRequiredInfo:
//                break
//            case .verifyInfoCheckError:
//                break
//            case .verifyLocalFileError:
//                break
//            case .verifyRemoteDataError:
//                break
//            case .timeout:
//                break
//            case .conditionMeet:
//                break
//            @unknown default:
//                break
//            }
//        })
//    }
//    
//    func captureError() {
//        #if DEBUG
//        print("错误提醒")
//        #endif
//    }
//    
//}
