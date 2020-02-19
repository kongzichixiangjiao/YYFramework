//
//  PZRequest.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/2/1.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation
import Alamofire

enum PXSpecialCodeType: Int {
    case logOut = 1111
}

class PXRequest: ZHReuqest {
    
    static let sharePX: PXRequest = PXRequest()
    
    func requestPX(baseUrlType: ZHUrlType? = .url, zhUrlApi api: String, method: HTTPMethod = .post, parameters: Parameters? = nil, encoding: ParameterEncoding = JSONEncoding.default, queue: DispatchQueue = DispatchQueue.main, successHandler: @escaping (ZHModel) -> (), errorHandler: @escaping (ZHReuqestError, ZHReuqestErrorCode) -> ()) {
        
        /*
         * clientId, token, pushRegistrationId 在GANormalizeOther中配置为固定的
         */
        let headers = ["clientId":UserDefaults.standard.object(forKey: "clientId") ?? "",
                       "token":UserDefaults.standard.object(forKey: "token") ?? "",
                       "registrationId":UserDefaults.standard.object(forKey: "pushRegistrationId") ?? "",]
        
        let _ = request(baseUrlType: baseUrlType, zhUrlApi: api, method: method, parameters: parameters, encoding: encoding, headers: headers as? HTTPHeaders, queue: queue, successHandler: {
            [weak self] model in
            if let weakSelf = self {
                guard let code = model.returnCode else {
                    return
                }
                if code == PXSpecialCodeType.logOut.rawValue {
                    weakSelf._loginOut()
                }
                successHandler(model)
            }
        }) { (errorType, errorCode) in
            errorHandler(errorType, errorCode)
        }
    }
    
    func uploadImagePX(baseUrlType: ZHUrlType?, zhUrlApi api: ZHRequestApi, parameters: Parameters? = nil, rsaParametersString: String, headers: HTTPHeaders?, resourceData: [Data], fileNames: [String], mimeType: ZHImageType, successHandler: @escaping (ZHModel) -> (), errorHandler: @escaping (ZHReuqestError, ZHReuqestErrorCode) -> ()) {
        uploadImage(baseUrlType: baseUrlType, zhUrlApi: api.rawValue, parameters: parameters, rsaParametersString: rsaParametersString, headers: headers, resourceData: resourceData, fileNames: fileNames, mimeType: mimeType, successHandler: {
            [weak self] model in
            if let weakSelf = self {
                guard let code = model.returnCode else {
                    return
                }
                if code == PXSpecialCodeType.logOut.rawValue {
                    weakSelf._loginOut()
                }
            }
        }, downloadProgress: { (progress) in
            #if DEBUG
            print(progress)
            #endif
        }) { (errorType, errorCode) in
            errorHandler(errorType, errorCode)
        }
    }
    
    private func _loginOut() {
        
    }
    
}
