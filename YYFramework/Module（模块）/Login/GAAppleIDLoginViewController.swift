//
//  GAAppleIDLogin.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/8.
//  Copyright © 2020 houjianan. All rights reserved.
//

//override func viewDidLoad() {
//       super.viewDidLoad()
//       
//       if #available(iOS 13.0, *) {
//           let v = initAuthorizationAppleIDButton()
//           v.frame = CGRect(x: 0, y: 0, width: kScreenWidth - 20.0 * 2, height: 50)
//           appleIDButton.addSubview(v)
//       } else {
//           
//       }
//}

//override func loginSuccess(_ userIdentifier: String, _ personName: PersonNameComponents?, _ email: String) {
//    print("请求后台验证")
//}

import UIKit
import AuthenticationServices

class GAAppleIDLoginViewController: UIViewController {
    
    // 子类重写此方法进行回调
    func loginSuccess(_ userIdentifier: String, _ personName: PersonNameComponents?, _ email: String) {

    }

    func showLogin() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        } else {
            
        }
    }
    
    // 子类调用此方法初始化UI
    @available(iOS 13.0, *)
    func initAuthorizationAppleIDButton() -> ASAuthorizationAppleIDButton {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        return authorizationButton
    }
    
    @objc func handleAuthorizationAppleIDButtonPress() {
        GAShowWindow.ga_show(type: .loading, duration: 10)
        showLogin()
    }
    
}

extension GAAppleIDLoginViewController: ASAuthorizationControllerDelegate {
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email ?? ""
            
            do {
                try KeychainItem(service: KeychainItem.mKeychainService, account: KeychainItem.mKeychainAccount).saveItem(userIdentifier)
                loginSuccess(userIdentifier, fullName, email)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            let _ = passwordCredential.user
            let _ = passwordCredential.password
        } else {
            
        }
    }
    
    @available(iOS 13.0, *)
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }
}

@available(iOS 13.0, *)
extension GAAppleIDLoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIApplication.shared.keyWindow ?? UIWindow()
    }
}
