//
//  XCHomeViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/30.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class XCHomeViewController: UIViewController {
    
    @objc func displayLink() {
        //        print("1")
    }
    @IBAction func b(_ sender: Any) {
        
        circleView.start()
        
        
        
//           float timeout = self.tf_timeout.text.floatValue;
//           [ProgressHUD show:@"请稍等..." Interaction:YES];
//           __weak typeof(self) weakSelf = self;
//
//           //1. 调用check接口检查及准备接口调用环境
//           [UMCommonHandler checkEnvAvailableWithComplete:^(NSDictionary * _Nullable resultDic) {
//               if ([PNSCodeSuccess isEqualToString:[resultDic objectForKey:@"resultCode"]] == NO) {
//                   [ProgressHUD showError:@"check 接口检查失败，环境不满足"];
//                   [weakSelf showResult:resultDic];
//                   return;
//               }
//
//               //2. 调用取号接口，加速授权页的弹起
//               [UMCommonHandler accelerateLoginPageWithTimeout:timeout complete:^(NSDictionary * _Nonnull resultDic) {
//                   if ([PNSCodeSuccess isEqualToString:[resultDic objectForKey:@"resultCode"]] == NO) {
//                       [ProgressHUD showError:@"取号，加速授权页弹起失败"];
//                       [weakSelf showResult:resultDic];
//                       return ;
//                   }
//
//                   //3. 调用获取登录Token接口，可以立马弹起授权页
//                   [ProgressHUD dismiss];
//                   UMCustomModel *model = [weakSelf buildCustomModel:NO];
//                   model.supportedInterfaceOrientations = UIInterfaceOrientationMaskAllButUpsideDown;
//                   [UMCommonHandler getLoginTokenWithTimeout:timeout controller:weakSelf model:model complete:^(NSDictionary * _Nonnull resultDic) {
//
//                       NSString *code = [resultDic objectForKey:@"resultCode"];
//                       if ([PNSCodeLoginControllerPresentSuccess isEqualToString:code]) {
//                           [ProgressHUD showSuccess:@"弹起授权页成功"];
//                       } else if ([PNSCodeLoginControllerClickCancel isEqualToString:code]) {
//                           [ProgressHUD showSuccess:@"点击了授权页的返回"];
//                       } else if ([PNSCodeLoginControllerClickChangeBtn isEqualToString:code]) {
//                           [ProgressHUD showSuccess:@"点击切换其他登录方式按钮"];
//                       } else if ([PNSCodeLoginControllerClickLoginBtn isEqualToString:code]) {
//                           if ([[resultDic objectForKey:@"isChecked"] boolValue] == YES) {
//                               [ProgressHUD showSuccess:@"点击了登录按钮，check box选中，SDK内部接着会去获取登陆Token"];
//                           } else {
//                               [ProgressHUD showSuccess:@"点击了登录按钮，check box选中，SDK内部不会去获取登陆Token"];
//                           }
//                       } else if ([PNSCodeLoginControllerClickCheckBoxBtn isEqualToString:code]) {
//                           [ProgressHUD showSuccess:@"点击check box"];
//                       } else if ([PNSCodeLoginControllerClickProtocol isEqualToString:code]) {
//                           [ProgressHUD showSuccess:@"点击了协议富文本"];
//                       } else if ([PNSCodeSuccess isEqualToString:code]) {
//                           //点击登录按钮获取登录Token成功回调
//                           NSString *token = [resultDic objectForKey:@"token"];
//                           dispatch_async(dispatch_get_main_queue(), ^{
//                               [UMCommonHandler cancelLoginVCAnimated:YES complete:nil];
//                           });
//                           [weakSelf showResult:resultDic];
//
//                           //拿Token去服务器换手机号
//
//                       } else {
//                      //     [ProgressHUD showError:@"获取登录Token失败"];
//                       }
//                       [weakSelf showResult:resultDic];
//                   }];
//               }];
//           }];
        
    }
    lazy var circleView: GACircleView = {
        let v = GACircleView(frame: CGRect(x: 0, y: 100, width: kScreenWidth, height: 130))
        v.backgroundColor = UIColor.red
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.addSublayer(circleView.layer)
    }
}

// jelly
class GACircleView: UIView {
    
    typealias FinishedHandler = () -> ()
    var stopedHandler: FinishedHandler?
    
    var tempY: CGFloat = 0.0
    var p: CGPoint = CGPoint.zero
    var isUp: Bool = true
    var r: CGFloat = 20
    var leftSpace: CGFloat = 0
    var rightSpace: CGFloat = 0
    var topSpace: CGFloat = 10
    var bottomSpace: CGFloat = 0
    @objc dynamic var curveX: CGFloat = 0
    @objc dynamic var curveY: CGFloat = 0
    
    lazy var _pointView: UIView = {
        let v = UIView(frame: CGRect(x: self.frame.width / 2, y: 0, width: 1, height: 1))
        v.backgroundColor = UIColor.clear
        return v
    }()
    lazy var display: CADisplayLink = {
        let c = CADisplayLink(target: self, selector: #selector(displayLink))
        c.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
        c.isPaused = true
        return c
    }()
    
    @objc func displayLink() {
        // ***
        let pLayer = self._pointView.layer.presentation()
        p = CGPoint.p(pLayer?.position.x ?? 0, pLayer?.position.y ?? 0)
        print(p)
        setNeedsDisplay()
    }
    
    func start() {
        self.display.isPaused = false
        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self._pointView.frame = CGRect(x: self.frame.width / 2, y: -self.topSpace - self.r, width: 3, height: 3)
        }) { (finished) in
            self.display.isPaused = true
        }
    }
    
    func stop(stopedHandler: @escaping FinishedHandler) {
        self.display.isPaused = false
        self.stopedHandler = stopedHandler
        
        UIView.animate(withDuration: 0.35, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 0.4, options: UIView.AnimationOptions.curveLinear, animations: {
            self._pointView.frame = CGRect(x: self.frame.width / 2, y: self.topSpace + self.r, width: 3, height: 3)
        }) { (finished) in
            self.display.isPaused = true
            self.stopedHandler?()
        }
    }
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        p = CGPoint.p(size.width/2, r + topSpace)
        
//        self.addObserver(self, forKeyPath: "curveX", options: [NSKeyValueObservingOptions.new], context: nil)
//        self.addObserver(self, forKeyPath: "curveY", options: [NSKeyValueObservingOptions.new], context: nil)
        
        self.addSubview(_pointView)
    }
    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//
//        if keyPath == "curveX" || keyPath == "curveY" {
//            setNeedsDisplay()
//        }
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let x: CGFloat = rect.origin.x + leftSpace
        let y: CGFloat = rect.origin.y + topSpace + r
        let w: CGFloat = rect.size.width - leftSpace - rightSpace
        let h: CGFloat = rect.size.height - topSpace - bottomSpace - r
        
        let path = UIBezierPath.init()
        path.move(to: CGPoint.p(x, y))
        path.addCurve(to: CGPoint.p(x+w, y), controlPoint1: CGPoint.p(x, y), controlPoint2: p)
        path.addLine(to: CGPoint.p(x+w,y+h))
        path.addLine(to: CGPoint.p(x,y+h))
        path.addLine(to: CGPoint.p(x,y))
        
        UIColor.red.setFill()
        
        path.fill()
    }
    
}
