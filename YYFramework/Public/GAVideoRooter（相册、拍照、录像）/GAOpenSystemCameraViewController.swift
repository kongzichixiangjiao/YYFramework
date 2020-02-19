//
//  GAOpenSystemCameraViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/12/18.
//  Copyright © 2019 houjianan. All rights reserved.
//


import UIKit
import AVFoundation
import Photos
import MobileCoreServices

enum GACameraType: Int {
    // 相册 拍照 录像
    case photoAlbum = 1, photos = 2, video = 3
}

protocol GAOpenSystemCameraViewControllerDelegate: class {
    // cameraType == .photoAlbum
    func openSystemCameraViewControllerDidSelected(pickVC: UIImagePickerController?, cameraType: GACameraType, sourceData: Any?)
    func openSystemCameraViewControllerPresentCompletion(pickVC: UIImagePickerController?, cameraType: GACameraType)
    // cameraType == .video -> UrlString  cameraType == .photos -> Image
    func openSystemCameraViewControllerSaveSuccess(pickVC: UIImagePickerController?, cameraType: GACameraType, sourceData: Any?)
    func openSystemCameraViewControllerShowSetting()
    func openSystemCameraViewController_is_ShowDefaultAlert() -> Bool
    func openSystemCameraViewControllerClickedCancle()
}

class GAOpenSystemCameraViewController: UIViewController {
    
    weak var delegate: GAOpenSystemCameraViewControllerDelegate?
    
    var pickImageController: UIImagePickerController?
    var cameraType: GACameraType = .video
    var allowsEditing: Bool = false
    
    static func showPickerVC() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        selectPhotoOrCamera()
    }
    
    // 解决被遮挡问题
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
        } else {
            // Fallback on earlier versions
        }
    }
    
    // 解决被遮挡问题
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
    }
    
    //选择相册、拍照、录像
    func selectPhotoOrCamera() {
        switch cameraType {
        case .photoAlbum:
            openAblum()
            break
        case .photos:
            openCamera()
            break
        case .video:
            openCamera()
            break
        }
    }
    
    //打开相册
    func openAblum(){
        weak var weakSelf=self
        
        pickImageController = UIImagePickerController()
        //savedPhotosAlbum是根据日期排列，photoLibrary是所有相册
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            //获取相册权限
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch status {
                case .notDetermined: break
                    
                case .restricted://此应用程序没有被授权访问的照片数据
                    break
                case .denied://用户已经明确否认了这一照片数据的应用程序访问
                    break
                case .authorized://已经有权限
                    DispatchQueue.main.async {
                        weakSelf!.pickImageController!.delegate = self
                        weakSelf!.pickImageController!.allowsEditing = weakSelf!.allowsEditing
                        weakSelf!.pickImageController!.sourceType = UIImagePickerController.SourceType.photoLibrary
                        //                        weakSelf?.pickImageController?.mediaTypes=[kUTTypeMovie as String]//只有视频
                        //                        weakSelf?.pickImageController?.mediaTypes=[kUTTypeImage as String]//只有照片
                        weakSelf?.pickImageController?.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//包括照片和视频
                        weakSelf?.pickImageController?.modalPresentationStyle = .fullScreen
                        weakSelf?.pickImageController?.modalTransitionStyle = .flipHorizontal
                        //弹出相册页面或相机
                        self.present(weakSelf!.pickImageController!, animated: true, completion: {
                            self.delegate?.openSystemCameraViewControllerPresentCompletion(pickVC: self.pickImageController!, cameraType: self.cameraType)
                        })
                    }
                    break
                @unknown default:
                    break
                }
            })
        }
    }
    //打开相机拍照或者录像
    func openCamera() {
        pickImageController = UIImagePickerController.init()
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: {
                [weak self] ist in
                if let weakSelf = self {
                    //检查相机权限
                    let status:AVAuthorizationStatus=AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
                    if status==AVAuthorizationStatus.authorized {// 有相机权限
                        DispatchQueue.main.async {
                            //跳转到相机或者相册
                            weakSelf.pickImageController!.delegate = self
                            weakSelf.pickImageController!.allowsEditing = weakSelf.allowsEditing
                            weakSelf.pickImageController!.sourceType = UIImagePickerController.SourceType.camera
                            
                            if weakSelf.cameraType == .photos {//拍照
                                weakSelf.pickImageController?.mediaTypes = [kUTTypeImage as String]//拍照
                                
                            } else if weakSelf.cameraType == .video {
                                weakSelf.pickImageController?.mediaTypes = [kUTTypeMovie as String]//录像
                            } else {
                                weakSelf.pickImageController?.mediaTypes = UIImagePickerController.availableMediaTypes(for: UIImagePickerController.SourceType.photoLibrary)!//拍照和录像都可以
                            }
                            weakSelf.present(weakSelf.pickImageController!, animated: true, completion: {
                                weakSelf.delegate?.openSystemCameraViewControllerPresentCompletion(pickVC: weakSelf.pickImageController!, cameraType: weakSelf.cameraType)
                            })
                        }
                    } else if (status == AVAuthorizationStatus.denied)||(status == AVAuthorizationStatus.restricted) {
                        
                    } else if(status == AVAuthorizationStatus.notDetermined){//权限没有被允许
                        //去请求权限
                        AVCaptureDevice.requestAccess(for: AVMediaType.video) { (genter) in
                            DispatchQueue.main.sync {
                                if (genter){
                                    print("去打开相机")
                                }else{
                                    print(">>>访问受限")
                                    if #available(iOS 10.0, *) {
                                        if weakSelf.delegate?.openSystemCameraViewController_is_ShowDefaultAlert() ?? false {
                                            weakSelf.gotoSetting()
                                        } else {
                                            weakSelf.delegate?.openSystemCameraViewControllerShowSetting()
                                        }
                                        weakSelf._disMiss()
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                            }
                        }
                    }
                }
            })
        }
    }
    
    //去设置权限
    @available(iOS 10.0, *)
    func gotoSetting() {
        let alertController:UIAlertController=UIAlertController.init(title: "去设置", message: "设置-》通用-》", preferredStyle: UIAlertController.Style.alert)
        let sure: UIAlertAction = UIAlertAction.init(title: "去开启权限", style: UIAlertAction.Style.default) { (ac) in
            let url=URL.init(string: UIApplication.openSettingsURLString)
            if UIApplication.shared.canOpenURL(url!){
                UIApplication.shared.open(url!, options: [:], completionHandler: { (ist) in
                    UIApplication.shared.openURL(url!)
                })
            }
        }
        alertController.addAction(sure)
        self.present(alertController, animated: true) {
            self.delegate?.openSystemCameraViewControllerPresentCompletion(pickVC: self.pickImageController!, cameraType: self.cameraType)
        }
    }
    
    //保存到系统相册
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        delegate?.openSystemCameraViewControllerSaveSuccess(pickVC: pickImageController, cameraType: cameraType, sourceData: image.pngData())
    }
    
    private func _disMiss() {
        pickImageController?.dismiss(animated: false, completion: nil)
        delegate?.openSystemCameraViewControllerClickedCancle()
    }
}

extension GAOpenSystemCameraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        _disMiss()
    }
    //选中图片，保存图片或视频到系统相册
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage?
        let typ: String = (info[UIImagePickerController.InfoKey.mediaType] as! String)//类型
        // 图片类型"public.image"
        if typ == "public.image" {
            if(picker.allowsEditing){
                //裁剪后图片
                image = (info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
            } else {
                //原始图片
                image = (info[UIImagePickerController.InfoKey.originalImage] as! UIImage)
            }
            
            //        这个是系统的方法，先来解释下各个参数:
            //        1.image:将要保存的图片
            //        2.completionTarget:保存完毕后，回调方法所在的对象
            //        3.completionSelector:保存完毕后，回调的方法
            //        4.contextInfo:可选参数
            if cameraType == .photos {
                UIImageWriteToSavedPhotosAlbum(image!, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if cameraType == .photoAlbum {
                delegate?.openSystemCameraViewControllerDidSelected(pickVC: pickImageController, cameraType: cameraType, sourceData: image)
            }
            _disMiss()
        } else if typ == "public.movie" {
            let url = info[UIImagePickerController.InfoKey.mediaURL] as! NSURL
            let urlStr = url.path
            if UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr!) {
                //保存视频到相簿，
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: URL(string:urlStr!)!)
                }) { (boo, error) in
                    DispatchQueue.main.sync {
                        if boo {
                            // 保存视频
                            self.delegate?.openSystemCameraViewControllerSaveSuccess(pickVC: self.pickImageController, cameraType: self.cameraType, sourceData: urlStr)
                        } else {
                            // 选择视频
                            self.delegate?.openSystemCameraViewControllerDidSelected(pickVC: self.pickImageController, cameraType: self.cameraType, sourceData: urlStr)
                        }
                        
                        self._disMiss()
                    }
                }
            }
        }
    }
}
