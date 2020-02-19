//
//  LBXScanViewController.swift
//  swiftScan
//
//  Created by lbxia on 15/12/8.
//  Copyright © 2015年 xialibing. All rights reserved.
//


/*
 func toScan() {
 //设置扫码区域参数
 var style = LBXScanViewStyle()
 
 style.centerUpOffset = 50
 style.xScanRetangleOffset = 58
 
 if UIScreen.main.bounds.size.height <= 480
 {
 //3.5inch 显示的扫码缩小
 style.centerUpOffset = 40
 style.xScanRetangleOffset = 20
 }
 
 style.color_NotRecoginitonArea = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
 
 style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner
 style.photoframeLineW = 5
 style.photoframeAngleW = 16
 style.photoframeAngleH = 16
 
 style.isNeedShowRetangle = true
 
 style.anmiationStyle = LBXScanViewAnimationStyle.NetGrid
 style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_full_net")
 
 let vc = LBXScanViewController()
 vc.scanResultDelegate = self
 vc.scanStyle = style
 self.present(vc, animated: true, completion: nil)
 }
 */


import UIKit
import Foundation
import AVFoundation

public protocol LBXScanViewControllerDelegate {
     func scanFinished(scanResult: LBXScanResult, error: String?)
}

//open class LBXScanViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
open class LBXScanViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
 //返回扫码结果，也可以通过继承本控制器，改写该handleCodeResult方法即可
   open var scanResultDelegate: LBXScanViewControllerDelegate?
    
   open var scanObj: LBXScanWrapper?
    
   open var scanStyle: LBXScanViewStyle? = LBXScanViewStyle()
    
   open var qRScanView: LBXScanView?

    
    //启动区域识别功能
   open var isOpenInterestRect = false
    
    //识别码的类型
   public var arrayCodeType:[AVMetadataObject.ObjectType]?
    
    //是否需要识别后的当前图像
   public  var isNeedCodeImage = false
    
    //相机启动提示文字
    public var readyString:String! = ""

    override open func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
              // [self.view addSubview:_qRScanView];
        self.view.backgroundColor = UIColor.black
        self.edgesForExtendedLayout = UIRectEdge(rawValue: 0)
    }
    
    open func setNeedCodeImage(needCodeImg:Bool)
    {
        isNeedCodeImage = needCodeImg;
    }
    //设置框内识别
    open func setOpenInterestRect(isOpen:Bool){
        isOpenInterestRect = isOpen
    }
 
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        drawScanView()
        
        initNavigationView()
        
        initAlertView()
       
        perform(#selector(LBXScanViewController.startScan), with: nil, afterDelay: 0.3)
        
    }
    
    private func initNavigationView() {
        let backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64))
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.view.addSubview(backView)
        
        let backButton = UIButton(frame: CGRect(x: 10, y: 20, width: 44, height: 44))
        let image = UIImage(named: "CodeScan.bundle/qrcode_scan_titlebar_back_nor")
        backButton.setImage(image, for: UIControl.State.normal)
        backButton.addTarget(self, action: #selector(back), for: UIControl.Event.touchUpInside)
        backView.addSubview(backButton)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: backView.frame.size.width, height: 44))
        titleLabel.text = "扫一扫"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
        backView.addSubview(titleLabel)
    }
    
    private func initAlertView() {
        let w: CGFloat = self.view.frame.size.width - (qRScanView?.viewStyle.xScanRetangleOffset)! * 2
        let y: CGFloat = self.view.center.y - (qRScanView?.viewStyle.centerUpOffset)! + 25 + w / 2
        let alertLabel = UILabel(frame: CGRect(x: self.view.frame.width / 2 - 220 / 2, y: y, width: 220, height: 30))
        alertLabel.text = "将二维码放入框内，即可自动扫描"
        alertLabel.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        alertLabel.font = UIFont.systemFont(ofSize: 13)
        alertLabel.textColor = UIColor.white
        alertLabel.textAlignment = .center
        alertLabel.layer.borderWidth = 1
        alertLabel.layer.borderColor = UIColor(red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 128.0 / 255.0, alpha: 0.8).cgColor 
        alertLabel.layer.masksToBounds = true
        alertLabel.layer.cornerRadius = 15
        self.view.addSubview(alertLabel)
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc open func startScan()
    {
   
        if (scanObj == nil)
        {
            var cropRect = CGRect.zero
            if isOpenInterestRect
            {
                cropRect = LBXScanView.getScanRectWithPreView(preView: self.view, style:scanStyle! )
            }
            
            //指定识别几种码
            if arrayCodeType == nil
            {
                arrayCodeType = [.qr, .ean13, .code128]
            }
            
            scanObj = LBXScanWrapper(viewStyle: scanStyle,videoPreView: self.view,objType:arrayCodeType!, isCaptureImg: isNeedCodeImage,cropRect:cropRect, success: { [weak self] (arrayResult) -> Void in
                
                if let strongSelf = self
                {
                    //停止扫描动画
                    strongSelf.qRScanView?.stopScanAnimation()
                    
                    strongSelf.handleCodeResult(arrayResult: arrayResult)
                }
             })
        }
        
        //结束相机等待提示
        qRScanView?.deviceStopReadying()
        
        //开始扫描动画
        qRScanView?.startScanAnimation()
        
        //相机运行
        scanObj?.start()
    }
    
    open func drawScanView()
    {
        if qRScanView == nil
        {
            qRScanView = LBXScanView(frame: self.view.frame,vstyle:scanStyle! )
            self.view.addSubview(qRScanView!)
        }
        
        // loading 提示
//        qRScanView?.deviceStartReadying(readyStr: readyString)
        
    }
   
    
    /**
     处理扫码结果，如果是继承本控制器的，可以重写该方法,作出相应地处理，或者设置delegate作出相应处理
     */
    open func handleCodeResult(arrayResult:[LBXScanResult])
    {
        if let delegate = scanResultDelegate  {
            
            self.navigationController? .popViewController(animated: true)
            let result:LBXScanResult = arrayResult[0]
            
            delegate.scanFinished(scanResult: result, error: nil)

        }else{
            
//            for result:LBXScanResult in arrayResult
//            {
//                print("%@",result.strScanned ?? "")
//            }
            
            let result:LBXScanResult = arrayResult[0]
            
            showMsg(title: result.strBarCodeType, message: result.strScanned)
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        
        qRScanView?.stopScanAnimation()
        
        scanObj?.stop()
    }
    
    open func openPhotoAlbum()
    {
        LBXPermissions.authorizePhotoWith { [weak self] (granted) in
            
            let picker = UIImagePickerController()
            
            picker.sourceType = UIImagePickerController.SourceType.photoLibrary
            
            picker.delegate = self;
            
            picker.allowsEditing = true
            
           self?.present(picker, animated: true, completion: nil)
        }
    }
    
    //MARK: -----相册选择图片识别二维码 （条形码没有找到系统方法）
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        picker.dismiss(animated: true, completion: nil)
        
        var image = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage
        
        if (image == nil )
        {
            image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage
        }
        
        if(image != nil)
        {
            let arrayResult = LBXScanWrapper.recognizeQRImage(image: image!)
            if arrayResult.count > 0
            {
                handleCodeResult(arrayResult: arrayResult)
                return
            }
        }
      
        showMsg(title: nil, message: NSLocalizedString("Identify failed", comment: "Identify failed"))
    }
    
    func showMsg(title:String?,message:String?)
    {
        
        let alertController = UIAlertController(title: nil, message:message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: UIAlertAction.Style.default) { (alertAction) in
                
//                if let strongSelf = self
//                {
//                    strongSelf.startScan()
//                }
            }
            
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
    }
    deinit
    {
        #if DEBUG
            print("LBXScanViewController deinit")
        #endif
    }
    
}





