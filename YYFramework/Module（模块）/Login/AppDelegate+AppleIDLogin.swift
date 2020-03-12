//
//  AppDelegate+AppleIDLogin.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/8.
//  Copyright © 2020 houjianan. All rights reserved.
//

//func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    apple_login()
//}

import Foundation
import AuthenticationServices

extension AppDelegate {
    func apple_login() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: KeychainItem.currentUserIdentifier) { (credentialState, error) in
                switch credentialState {
                case .authorized:
                    // The Apple ID credential is valid.
                    break
                case .revoked:
                    // The Apple ID credential is revoked.
                    break
                case .notFound:
                    // No credential was found, so show the sign-in UI.
                    DispatchQueue.main.async {
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let tabbarVC = storyBoard.instantiateViewController(withIdentifier: "YYTabBarViewController")
                        let loginVC = YYLoginViewController(nibName: "YYLoginViewController", bundle: nil)
                        loginVC.backWay = .root(vc: tabbarVC)
                        UIApplication.shared.keyWindow?.rootViewController = loginVC
                    }
                default:
                    break
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}
