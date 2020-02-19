//
//  String+RSA.swift
//  YYFramework
//
//  Created by houjianan on 2019/9/24.
//  Copyright © 2019 houjianan. All rights reserved.
//

import Foundation
import SwiftyRSA

extension String {
    // MARK: rsa 加密
    func rsa_pem() -> String {
        let publicKey = try! PublicKey(pemNamed: "rsa_public_key")
        let clear = try! ClearMessage(string: self, using: .utf8)
        let encrypted = try! clear.encrypted(with: publicKey, padding: .PKCS1)
        
        let _ = encrypted.data
        let base64String = encrypted.base64String
        
        return base64String
    }
}
