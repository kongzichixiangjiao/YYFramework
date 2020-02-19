//
//  GAAppleIDLogin.swift
//  YYFramework
//
//  Created by houjianan on 2020/1/8.
//  Copyright © 2020 houjianan. All rights reserved.
//

import UIKit
import AuthenticationServices

class GAAppleIDLoginViewController: UIViewController {
    
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
    
    @available(iOS 13.0, *)
    func initAuthorizationAppleIDButton() -> ASAuthorizationAppleIDButton {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        return authorizationButton
    }
    
    @objc
    func handleAuthorizationAppleIDButtonPress() {
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
            
            loginSuccess(userIdentifier, fullName, email)
            // Create an account in your system.
            // For the purpose of this demo app, store the userIdentifier in the keychain.
            do {
                try KeychainItem(service: "jianan.YYFramework", account: "userIdentifier").saveItem(userIdentifier)
            } catch {
                print("Unable to save userIdentifier to keychain.")
            }
            
        } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
            // Sign in using an existing iCloud Keychain credential.
            let _ = passwordCredential.user
            let _ = passwordCredential.password
            
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
