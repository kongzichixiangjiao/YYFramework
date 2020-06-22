//
//  ZHRequest.swift
//  YYFramework
//
//  Created by 侯佳男 on 2019/1/30.
//  Copyright © 2019年 houjianan. All rights reserved.
//

import Foundation
import Alamofire
import HandyJSON

open class ZHReuqest {
    
    static let share: ZHReuqest = ZHReuqest()
    
    public var sessionManagers: [String : DataRequest] = [String : DataRequest]()
    public var downloadRequests: [DownloadRequest] = []
    
    private var _sessionManager: SessionManager!
    private let _configuration = URLSessionConfiguration.default
    
    init() {
        _sessionManager = Alamofire.SessionManager(configuration: _configuration)
    }
    
    /**
     *  数据请求
     *  api: 接口字符串
     *  method: 默认post
     *  parameters: [String:Any]类型
     *  encoding: 默认JSON。支持三种参数编码：URL、JSON和PropertyList。还支持遵循了ParameterEncoding协议的自定义编码
     *  headers: [String:String]类型
     **/
    func request(baseUrlType: ZHUrlType? = .url, zhUrlApi api: String, method: HTTPMethod = .post, parameters: Parameters? = nil, rsaParametersString: String = "", encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, queue: DispatchQueue = DispatchQueue.main, successHandler: @escaping (_ result: ZHModel) -> (), errorHandler: @escaping (_ errorType: ZHReuqestError, _ errorCode: ZHReuqestErrorCode) -> ()) -> DataRequest? {
        if _validateNet(errorHandler: errorHandler) {
            return _request(baseUrlType: baseUrlType, zhUrlApi: api, method: method, parameters: parameters, rsaParametersString: rsaParametersString, encoding: encoding, headers: headers, queue: queue, successHandler: successHandler, errorHandler: errorHandler)
        }
        return nil
    }
    /**
     *  上传图片
     **/
    func uploadImage(baseUrlType: ZHUrlType? = .url, zhUrlApi api: String, parameters: Parameters? = ["":""], rsaParametersString: String = "", headers: HTTPHeaders? = nil, resourceData: [Data], fileNames:[String], mimeType: ZHImageType = .png, successHandler: @escaping (_ result: ZHModel) -> (), downloadProgress: @escaping (_ progress: Double) -> (), errorHandler: @escaping (_ errorType: ZHReuqestError, _ errorCode: ZHReuqestErrorCode) -> ()) {
        if _validateNet(errorHandler: errorHandler) {
            _uploadImage(baseUrlType: baseUrlType, zhUrlApi: api, parameters: parameters, rsaParametersString: rsaParametersString, headers: headers, resourceData: resourceData, fileNames: fileNames, mimeType: mimeType, successHandler: successHandler, downloadProgress: downloadProgress, errorHandler: errorHandler)
        }
    }
    /**
     *  取消全部网络请求
     **/
    func cancleAllRequests() {
        _cancleAllRequests()
    }
    /**
     *  取消任意请求
     **/
    func cancleReuqest(api: ZHRequestApi) {
        _cancleReuqest(api: api)
    }
    
    // MARK: 网络请求
    private func _request(baseUrlType: ZHUrlType? = .url, zhUrlApi api: String, method: HTTPMethod = .post, parameters: Parameters? = nil, rsaParametersString: String = "", encoding: ParameterEncoding = JSONEncoding.default, headers: HTTPHeaders? = nil, queue: DispatchQueue = DispatchQueue.main, successHandler: @escaping (_ result: ZHModel) -> (), errorHandler: @escaping (_ errorType: ZHReuqestError, _ errorCode: ZHReuqestErrorCode) -> ()) -> DataRequest? {
        
        guard let url = _url(baseUrlType: baseUrlType!, api: api) else {
            ZHReuqestLog.errorLog(error: .urlError(message: "url 格式错误"))
            return nil
        }
        
//        let baseHeaders = _headers(headers: headers)
        let baseHeaders = headers ?? nil
        
        let baseParameters = _parameters(p: parameters, rsa: rsaParametersString, headers: baseHeaders!)

        let dataRequest = _sessionManager.request(url, method: method, parameters: baseParameters, encoding: encoding, headers: baseHeaders).responseJSON(queue: queue) { (dataResponse) in
            #if DEBUG
            // (延迟，请求时间，序列化时间，总时间)
            print(dataResponse.timeline)
            /*
             { "Latency延迟": 0.143 secs,
                "Request Duration请求持续时间": 0.145 secs,
                "Serialization Duration请求序列化时间": 0.001 secs,
                "Total Duration总时间": 0.146 secs }
             */
            #endif
            
            self.sessionManagers.removeValue(forKey: api)
            
            switch(dataResponse.result) {
            case .success(let value):
                #if DEBUG
                    print(value)
                #endif
                if let valueDic = value as? [String : Any] {
                    guard let model = ZHModel.deserialize(from: valueDic) else {
                        ZHReuqestLog.errorLog(error: .valueError(message: "数据结构不正确"))
                        errorHandler(.valueError(message: "数据结构不正确"), ZHReuqestErrorCode.formatError)
                        return
                    }
                    
                    guard let code = model.returnCode else {
                        ZHReuqestLog.errorLog(error: .valueError(message: "code = nil 后台没有返回"))
                        errorHandler(.valueError(message: "code = nil 后台没有返回"), ZHReuqestErrorCode.formatError)
                        return
                    }

                    if code == 200 {
                        let resultDic = model.result as? [String : Any]
                        model.resultDic = resultDic
                        
                        successHandler(model)
                    } else {
                        ZHReuqestLog.errorLog(error: .valueError(message: "处理特殊code"))
                        successHandler(model)
                    }
                } else {
                    ZHReuqestLog.errorLog(error: .valueError(message: "数据结构不正确"))
                    errorHandler(.valueError(message: "数据结构不正确"), ZHReuqestErrorCode.formatError)
                }
            case .failure(let error):
                ZHReuqestLog.errorLog(error: .resultError(message: error))
                #if DEBUG
                    print("请求失败返回的描述内容：", error.localizedDescription)
                #endif
                if error.localizedDescription == "cancleCode" {
                    errorHandler(.failedError(message: "取消网络请求"), ZHReuqestErrorCode.cancleCode)
                } else {
                    errorHandler(.failedError(message: "网络繁忙"), ZHReuqestErrorCode.failure)
                }
            }
        }
        sessionManagers[api] = dataRequest
        
        return dataRequest
    }
    
    private func _validateNet(errorHandler: @escaping (_ errorType: ZHReuqestError, _ errorCode: ZHReuqestErrorCode) -> ()) -> Bool {
        let del = UIApplication.shared.delegate as! AppDelegate
        if del.zh_netWorkManager.isReachable {
            return true
        } else {
            ZHReuqestLog.errorLog(error: .noNetwork(message: "无网络"))
            errorHandler(.noNetwork(message: "无网络"), ZHReuqestErrorCode.noNet)
            return false
        }
    }
    
    private func _url(baseUrlType type: ZHUrlType, api: String) -> URL? {
        if !_validatedApi(s: api) {
            ZHReuqestLog.errorLog(error: .urlError(message: "错误的api 开始字符不是/"))
            return nil
        }
        
        let urlString = ZHRequestURL.baseURL(type: type) + api
        let url = URL(string: urlString)
        return url
    }
    
    private func _validatedApi(s: String) -> Bool {
//        let endIndex = String.Index.init(encodedOffset: 1)
        let endIndex = String.Index.init(utf16Offset: 1, in: s)
        let subStr = s[s.startIndex..<endIndex]
        return String(subStr) == "/"
    }
    
    private func _parameters(p: [String : Any]?, rsa: String, headers: [String : Any]) -> [String : Any]? {
        guard let type = ZHRequestAppName.init(rawValue: Bundle.main.infoDictionary! ["CFBundleName"] as! String) else {
            return p
        }
        switch type {
        case .px_jf:
            return p
        case .px_cfgw:
            return p
        case .ly_cffw, .ly_lcs:
            let dic = ["bizParam" : rsa, "header" : headers] as [String : Any]
            return dic
        case .normal:
            return p
        case .test:
            return p
        }
    }
    
    private func _headers(headers: [String : String]?) -> [String: String] {
        var dic = [
            "Accept": "application/json",
            "Content-Type": "application/json",
            
            "packageName":Bundle.main.infoDictionary! ["CFBundleIdentifier"] as! String,
            "appName":Bundle.main.infoDictionary! ["CFBundleName"] as! String,
            "version":Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String,
            "os":"ios",
            "channel":"appStore",
            "platform":UIDevice.current.systemVersion,
            "model":UIDevice.current.model,
            "factory":"apple",
            "screenSize":"\(UIScreen.main.bounds)",
            "imei":"",
            "mac":"",
            "sign":"",
            "pid":"pid",
            /*
             * clientId, token, pushRegistrationId 在GANormalizeOther中配置为固定的
             */
//            "clientId":UserDefaults.standard.object(forKey: "clientId") ?? "",
//            "token":UserDefaults.standard.object(forKey: "token") ?? "",
//            "registrationId":UserDefaults.standard.object(forKey: "pushRegistrationId") ?? "",
        ]
        
        if let item = headers {
            for key in item.keys {
                dic[key] = item[key]
            }
        }
        return dic
    }
    
    // MARK: 上传资源文件
    private func _uploadImage(baseUrlType: ZHUrlType? = .url, zhUrlApi api: String, parameters: Parameters? = ["":""], rsaParametersString: String = "", headers: HTTPHeaders? = nil, resourceData: [Data], fileNames:[String], mimeType: ZHImageType = .png, successHandler: @escaping (_ result: ZHModel) -> (), downloadProgress: @escaping (_ progress: Double) -> (), errorHandler: @escaping (_ errorType: ZHReuqestError, _ errorCode: ZHReuqestErrorCode) -> ()) {
        
        guard let url = _url(baseUrlType: baseUrlType!, api: api) else {
            ZHReuqestLog.errorLog(error: .urlError(message: "url 格式错误"))
            return
        }
        
        var baseHeaders = [String : String]()
        if let keyValues = headers {
            baseHeaders = _headers(headers: keyValues)
        }
        
        let baseParameters = _parameters(p: parameters!, rsa: rsaParametersString, headers: baseHeaders)
        
        _sessionManager.upload(multipartFormData: { (multipartFormData) in
            if let p = baseParameters {
                for (key,value) in p {
                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
            }
            
            for i in 0..<resourceData.count {
                multipartFormData.append(resourceData[i], withName: "file", fileName: fileNames[i], mimeType: "image/" + mimeType.rawValue)
            }
        }, to: url, headers: baseHeaders) { (result) in
            switch result {
            case .success(let response, _, _):
                response.responseJSON(completionHandler: { (value) in
                    #if DEBUG
                    // (延迟，请求时间，序列化时间，总时间)
                    print(value.timeline)
                    #endif
                    if let valueDic = value.result.value as? [String : Any] {
                        guard let model = ZHModel.deserialize(from: valueDic) else {
                            ZHReuqestLog.errorLog(error: .valueError(message: "数据结构不正确"))
                            errorHandler(.valueError(message: "数据结构不正确"), ZHReuqestErrorCode.formatError)
                            return
                        }
                        
                        guard let code = model.returnCode else {
                            ZHReuqestLog.errorLog(error: .valueError(message: "code = nil 后台没有返回"))
                            errorHandler(.valueError(message: "code = nil 后台没有返回"), ZHReuqestErrorCode.formatError)
                            return
                        }
                        
                        if code == 200 {
                            successHandler(model)
                        } else {
                            ZHReuqestLog.errorLog(error: .valueError(message: "处理特殊code"))
                            successHandler(model)
                        }
                    } else {
                        ZHReuqestLog.errorLog(error: .valueError(message: "数据结构不正确"))
                        errorHandler(.valueError(message: "数据结构不正确"), ZHReuqestErrorCode.formatError)
                    }
                }).downloadProgress(closure: { (progress) in
                    downloadProgress(progress.fractionCompleted)
                })
            case .failure(let error):
                ZHReuqestLog.errorLog(error: .resultError(message: error))
                errorHandler(.failedError(message: "网络繁忙"), ZHReuqestErrorCode.failure)
            }
        }
    }
    
    func _download(baseUrlType: ZHUrlType? = .url, zhUrlApi api: String, method: HTTPMethod? = .post, parameters: Parameters? = ["":""], queue: DispatchQueue? = DispatchQueue.global(qos: .utility), encoding: ParameterEncoding? = JSONEncoding.default, headers: HTTPHeaders? = nil) -> DownloadRequest? {
        guard let url = _url(baseUrlType: baseUrlType!, api: api) else {
            ZHReuqestLog.errorLog(error: .urlError(message: "url 格式错误"))
            return nil
        }
        var baseHeaders = [String : String]()
        if let keyValues = headers {
            baseHeaders = _headers(headers: keyValues)
        }
        
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(api)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let downloadRequest = _sessionManager.download(url, method: method!, parameters: parameters, encoding: encoding!, headers: baseHeaders, to: destination)
            .downloadProgress(queue: queue!) { (progress) in
                print(progress)
            }
            .responseData { (data) in
                if data.error == nil, let imagePath = data.destinationURL?.path {
                    let _ = UIImage(contentsOfFile: imagePath)
                }
        }
        downloadRequests.append(downloadRequest)
        return downloadRequest
    }
    /*
     suspend()：暂停底层的任务和调度队列
     resume()：恢复底层的任务和调度队列。如果manager的startRequestsImmediately不是true，那么必须调用resume()来开始请求。
     cancel()：取消底层的任务，并产生一个error，error被传入任何已经注册的响应handlers。
     */
    private func _cancleAllRequests() {
        for (_, sessionManager) in sessionManagers {
           sessionManager.cancel()
        }
        #if DEBUG
        print("网络请求 全部 取消。一共\(sessionManagers.count)个")
        #endif
        sessionManagers.removeAll()
    }
    
    private func _cancleReuqest(api: ZHRequestApi) {
        guard let sessionManager = sessionManagers[api.rawValue] else {
            ZHReuqestLog.errorLog(error: .cancleRequestError(message: "api 不在请求范围内"))
            return
        }
        sessionManager.cancel()
        #if DEBUG
        print(api.rawValue, "网络请求 已经 取消")
        #endif
    }
    
}



