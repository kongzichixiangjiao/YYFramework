//
//  GAFlutterRooterViewController.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/20.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit
import Flutter

class GAFlutterRooterViewController: GANavViewController {
    
    lazy var splashScreenView: GASplashScreenView = {
        let v = "GASplashScreenView".xibLoadView() as! GASplashScreenView
        v.frame = self.view.bounds
        return v
    }()
    
//    lazy var flutterViewController: FlutterViewController = {
//       let flutterViewController = FlutterViewController(project: nil, nibName: nil, bundle: nil)
//        let v = "GASplashScreenView".xibLoadView() as! GASplashScreenView
//        v.frame = self.view.bounds
//        flutterViewController.splashScreenView = v
//        flutterViewController.setInitialRoute("MyApp")
//
//        let channel = FlutterMethodChannel(name: "jianan.YYFramework/test", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
//        channel.setMethodCallHandler { (call, result) in
//            print("method = ", call.method, "arguments = ", call.arguments ?? "argumentsNULL", result)
//
//            let method = call.method
//            if method == "FlutterPopIOS" {
//                print("FlutterPopIOS：返回来传的参数是 == ", call.arguments ?? "argumentsNULL")
//                self.navigationController?.popViewController(animated: true)
//            } else if method == "FlutterCickedActionPushIOSNewVC" {
//                print("FlutterCickedActionPushIOSNewVC：返回来传的参数是 == ", call.arguments ?? "argumentsNULL")
//                let vc = GAVerificationCodeViewController(nibName: "GAVerificationCodeViewController", bundle: nil)
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else if method == "FlutterGetIOSArguments" {
//                let dic = ["a":"值就是value，没错。"]
//                print("传参给Flutter：", dic)
//                result(dic)
//            } else {
//
//            }
//        }
//        return flutterViewController
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(flutterViewController)
        
        b_showNavigationView(title: "FlutterRooter")
    }
    
    @IBAction func bAction(_ sender: Any) {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        present(flutterViewController, animated: true, completion: nil)
    }
    
    @IBAction func cAction(_ sender: Any) {
        let flutterViewController = FlutterViewController(project: nil, nibName: nil, bundle: nil)
        let v = "GASplashScreenView".xibLoadView() as! GASplashScreenView
        v.frame = self.view.bounds
        flutterViewController.splashScreenView = v
        flutterViewController.setInitialRoute("MyApp123")
        
        let channel = FlutterMethodChannel(name: "jianan.YYFramework/test", binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        channel.setMethodCallHandler { (call, result) in
            print("method = ", call.method, "arguments = ", call.arguments ?? "argumentsNULL", result)
            
            let method = call.method
            if method == "FlutterPopIOS" {
                print("FlutterPopIOS：返回来传的参数是 == ", call.arguments ?? "argumentsNULL")
                self.navigationController?.popViewController(animated: true)
            } else if method == "FlutterCickedActionPushIOSNewVC" {
                print("FlutterCickedActionPushIOSNewVC：返回来传的参数是 == ", call.arguments ?? "argumentsNULL")
                let vc = GAVerificationCodeViewController(nibName: "GAVerificationCodeViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            } else if method == "FlutterGetIOSArguments" {
                let dic = ["a":"值就是value，没错。"]
                print("传参给Flutter：", dic)
                result(dic)
            } else {
                
            }
        }
        self.navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
    @IBAction func dAction(_ sender: Any) {
        let flutterViewController = FlutterViewController(project: nil, nibName: nil, bundle: nil)
        let v = "GASplashScreenView".xibLoadView() as! GASplashScreenView
        v.frame = self.view.bounds
        flutterViewController.splashScreenView = v
        flutterViewController.setInitialRoute("/TestRooterPage")
        self.navigationController?.pushViewController(flutterViewController, animated: true)
    }
    
    deinit {
        print("GAFlutterRooterViewController deinit")
    }
}

