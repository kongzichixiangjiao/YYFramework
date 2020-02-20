//
//  PXMD.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/1.
//  Copyright © 2019 houjianan. All rights reserved.
//

/*
 一、统计类型
 1、界面访问及时长
 2、按钮事件（预约、登录、退出、分享等等）
 3、设备信息
 4、用户信息
 5、启动次数
 6、查看推送通知
 7、启动与退出（退到后台或者杀死进程）时间点
 8、H5加载url
 9、
 
 二、发送规则
 1、唤醒发送：将埋点数据缓存，App唤醒或者启动是发送给后台
 2、5条发送一次
 三、接口定义
 1、接收统计数据接口
 2、参数JSON
 
 四、字段定义
 eg：首页-home 我的-my
 eg：px001-预约按钮-预约 px002-退出登录-退出
 mdJSON: {
 // App信息
 appInfo: {
 name : "", // app名字
 version : "", // 大版本
 versionCode : "", // 小版本
 platform : "" // App渠道
 }
 // 定位信息
 location: {
 "streetname":"三元桥",
 "streetnameCode":"100000",
 "province":"河南",
 "provincecode":"1000223",
 "city":"郑州"
 "citycode":"10000"
 "lat":"37.0",
 "lng":"37.0",
 address: ""
 },
 // 用户信息
 userInfo: {
 userUUID : "", // 顾问工号 金服手机号
 },
 // 设备信息
 deviceInfo: {
 ip : "",
 net : "", // 网络状态 wifi 4G
 model : "", // iPhone iPad
 screenSize : "", // 屏幕尺寸
 factory : "apple", // apple/google/小米/华为
 UUID : "", // 设备唯一标识
 name : "", // 设备名字 iPhone11
 deviceType : "设备型号",
 internalMemory : "内存大小",
 localizedModel : "", // iPhone
 systemVersion : "", // 系统版本号 13.1
 systemName : "" // 系统名称 iOS OS 鸿蒙
 },
 // 事件统计
 events: [
 {
 "type" : "app", # page, button, tab, url等
 "time" : 1499672827876, # 事件的时间戳
 "event" : "in",  # in, out, click, swipe, enter, quit等
 "page" : "MainActivity", # 界面定义的类名或者文件名
 "name" : "首页", # 界面的名字、按钮的名字
 "code" : "px001" # 本次事件的唯一标识
 "describe" : "这是一个描述"
 "additional" : "JSON，参数"
 }
 ]
 }
 
 /*
 type:
 app: App启动时间和退到后台的时间统计 对应的event：enter（启动）， quit（退出）
 page: 界面访问统计，对应event：in（进入），out（离开）
 button：点击事件统计，对应的event：click（点击）
 tab：多个按钮排列，点击切换事件统计，对应event：click/swipe（点击或者滑动）
 url：H5界面加载Url统计
 video: 播放视频 对应event：playerStart（开始），playerEnd（结束）
 */
 
 
 注意：
 1、界面访问
 */


import Foundation

// MARK: 普信统计专用

enum PXMDEventType: String {
    case normal = "normal", In = "in", out = "out", enter = "enter", quit = "quit", click = "click", swipe = "swipe", playerStart = "playerStart", playerEnd = "playerEnd", dsBridge = "dsBridge", share = "share"
}

enum PXMDWidgetType: String {
    case page = "page", button = "button", alert = "alert", tab = "tab", tabbar = "tabbar", url = "url", video = "video", cell = "cell", web = "web"
}

let kPXMDFileName = "PXMD"

let kMaxUploadNum5 = 5
let kMaxUploadNum2 = 2
let kLearningMaxSeconds = 10

class PXMD {
    static let share: PXMD = PXMD()
    var isShowLog: Bool = false
    
    // 总json
    var mdJSON: [String : Any] = ["events":["":""], "events2":["":""]]
    // 用户
    var userInfo: [String : Any] = ["" : ""]
    // app
    var appInfo: [String : Any] = ["" : ""]
    // 设备
    var deviceInfo: [String : Any] = ["" : ""]
    // 定位
    var locationInfo: [String : Any] = ["" : ""]
    // 事件
    var mdEvents: [[String : Any]] = []
    
    // 事件 2条事件上传使用
    var mdEvents2: [[String : Any]] = []
    
    // 登录（是否有用户在同一个设备登录不同账号）
    var signIns: [Any] = []
    
    // 实时统计-学习
    var realTimeLearning: [[String : Any]] = []
    
    // MARK: 启动时调用 -- 上传统计数据
    func md_launched() {
        if let json = GAPlistManager.share.readDicPlist(fileName: kPXMDFileName) {
            mdJSON = json
        }
        
        if let json = mdJSON as? [String : [String : String]] {
            if json == ["events" : ["":""]] {
                
            } else {
                md_uploadData()
            }
        } else {
            md_uploadData()
        }
    }
    
    func md_initBaseData() {
        
        appInfo = ["name" : Bundle.main.infoDictionary! ["CFBundleName"] as! String,
                   "version" : Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String,
                   "platform" : "PX001"]
        mdJSON["appInfo"] = appInfo
        
        userInfo = ["userUUID" : "CacheTool.getDefault(cacheKey: .employeeId)"]
        mdJSON["userInfo"] = userInfo
        
        deviceInfo = ["UUID" : UIDevice.current.identifierForVendor?.uuidString ?? "",
                      "name" : UIDevice.current.name,
                      "model" : UIDevice.current.model,
                      "localizedModel" : UIDevice.current.localizedModel,
                      "systemVersion" : UIDevice.current.systemVersion,
                      "systemName" : UIDevice.current.systemName,
                      "ip" : "ip".md_ipAddress,
                      "net" : "",
                      "screenSize" : "\(UIScreen.main.bounds)",
                      "factory" : "apple",
                      "deviceType" : UIDevice.current.normalize_modelName,
                      "internalMemory" : GAStorageSpace.getTotalSpace().ga_toMB()
        ]
        
        mdJSON["deviceInfo"] = deviceInfo
        
        locationInfo = ["locationInfo":"合并代码再优化"]
        mdJSON["location"] = locationInfo
    }
    
    // 数据发送到后台 处理完成删除本地缓存
    func md_uploadData() {
        if mdEvents.count % kMaxUploadNum5 == 0 {
            md_initBaseData()
            if mdEvents.count == 0 {
                return
            }
            mdJSON["events"] = mdEvents
            
            md_reuqest(events: mdJSON, successHandler: {eventCount in
                let _ = GAPlistManager.share.removeArrayPlist(fileName: kPXMDFileName) {
                    [weak self] b in
//                    print("是否删除成功?", b)
                    if let weakSelf = self {
                        weakSelf.mdEvents.removeSubrange(0..<(weakSelf.mdEvents.count > eventCount ? eventCount : weakSelf.mdEvents.count))
                        weakSelf.mdJSON["events"] = weakSelf.mdEvents
                    }
                }
            }) {
                // 传输失败 不做处理
            }
        }
    }
    
    // MARK: 退到后台或杀死进程 -- 退到后台保存数据 时机是否正确？
    func md_backgroundOrKill() {
        mdJSON["events"] = mdEvents
        mdJSON["signIns"] = signIns
        
        GAPlistManager.share.writeDicPlist(data: mdJSON, fileName: kPXMDFileName) { (b) in
            print("退出后台/或者杀死App 保存是否成功？", b)
        }
    }
    
    // MARK: 统计基本事件
    /*
     *  code: 必填-事件唯一标示 需要统一定义
     *  name: 事件的名称、按钮的名称等
     *  page: 在哪个界面处理的事件
     *  describe: 相关描述
     *  widgetType: 控件类型
     *  event: 事件类型
     *  time: 时间戳
     */
    func md_event(code: String, name: String = "", page: String = "", describe: String = "", widgetType: PXMDWidgetType = .button, event: PXMDEventType = .click, additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : widgetType.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : event.rawValue,
            "additional" : additional] as [String : Any]
        #if DEBUG
//        print("md_event：", dic)
        #endif
        mdEvents.append(dic)
        
        md_uploadData()
    }
    
    func md_event_clicked(code: String, name: String = "", page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        md_event(code: code, name: name, page: page, describe: describe, widgetType: .button, event: .click, additional: additional)
    }
    
    // MARK: 页面开始
    /*
     *  code: 必填-界面唯一标示 需要统一定义
     *  name: 界面的title
     *  page: 当前控制器名称
     *  describe: 相关描述
     */
    func md_pageStart(code: String, name: String, page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : PXMDWidgetType.page.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : PXMDEventType.enter.rawValue,
            "additional" : additional] as [String : Any]
        #if DEBUG
//        print("md_event：", dic)
        #endif
        mdEvents.append(dic)
        
        md_uploadData()
        
//        md_realTime_learning_pageStart(code: code, name: name, page: page, describe: describe, additional: additional)
    }
    
    // MARK: 页面离开
    /*
     *  code: 必填-界面唯一标示 需要统一定义
     *  name: 界面的title
     *  page: 当前控制器名称
     *  describe: 相关描述
     */
    func md_pageEnd(code: String, name: String, page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : PXMDWidgetType.page.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : PXMDEventType.out.rawValue,
            "additional" : additional] as [String : Any]
        #if DEBUG
//        print("md_event：", dic)
        #endif
        mdEvents.append(dic)
        
        md_uploadData()
        
//        md_realTime_learning_pageEnd(code: code, name: name, page: page, describe: describe, additional: additional)
    }
    
    // MARK: 登录
    func md_signIn(id: String) {
        signIns.append(["id":id])
    }
    
    // MARK: web统计
    // 代理方法： -(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
    func md_webView(name: String, body: [AnyHashable : Any]) {
        
    }
    
    func md_reuqest(events: [String : Any], successHandler: @escaping (_ eventCount: Int) -> (), errorHandler: @escaping () -> ()) {
//        PXNetWorkManager.share.request(false, pathType: .buriedData, method: .post, params: events, success: { (result) in
//            successHandler((events["events"] as! [[String : Any]]).count)
//        }, failure: { (error) in
//            errorHandler()
//        }) { (finish) in
//
//        }
    }
}

// MARK: 实时上传
/*
 PXMD.share.md_pageStart(code: kMD_xxpl, name: "信息披露", additional: ["id" : "1321"])
 PXMD.share.md_pageEnd(code: kMD_xxpl, name: "信息披露", additional: ["id" : "1321"])
 */
extension PXMD {
    
    private func md_realTimeReuqest(detailsType: String, duration: Double, id: String, pdfUrl: String, date: String, videoPath: String, successHandler: @escaping () -> (), errorHandler: @escaping () -> ()) {
        _ = ["type":1,
                      "detailsType":detailsType,
                      "employeeId":"CacheTool.getDefault(cacheKey: .employeeId)",
                      "duration":Int(duration),
                      "frequency":1,
                      "id":id,
                      "pdfUrl":pdfUrl,
                      "date":date] as [String : Any]
        #if DEBUG
//        print(params)
        #endif
//        PXNetWorkManager.share.request(false, pathType: .statisticalBehaviorData, method: .post, params: params, success: { (result) in
//            successHandler()
//        }, failure: { (error) in
//            errorHandler()
//        }) { (finish) in
//
//        }
    }
    
     func md_realTime_learning_pageStart(code: String, name: String, page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : PXMDWidgetType.page.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : PXMDEventType.In.rawValue,
            "additional" : additional] as [String : Any]
        
        realTimeLearning.append(dic)
    }
    
     func md_realTime_learning_pageEnd(code: String, name: String, page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : PXMDWidgetType.page.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : PXMDEventType.out.rawValue,
            "additional" : additional] as [String : Any]
        
        _isRealTime_learning(code: code, dic: dic)
    }
    
    private func _isRealTime_learning(code: String, dic: [String : Any]) {
        var index: Int = -1
        for i in 0..<realTimeLearning.count  {
            let item = realTimeLearning[i]
            let codeTemp = item["code"] as? String
            let typeTemp = item["event"] as? String
            let additionalTemp = item["additional"] as? [String : Any]
            let additionalIdTemp = additionalTemp?["id"] as? String
            let additionalPDFUrlTemp = additionalTemp?["pdfUrl"] as? String
            
            let additional = dic["additional"] as? [String : Any]
            let additionalId = additional?["id"] as? String
            
            let additionalPDFUrl = additional?["pdfUrl"] as? String
            
            let detailsType = additional?["detailsType"] as? String
            let date = additional?["date"] as? String
            
            let videoPath = additional?["videoPath"] as? String
            
            if codeTemp == code && typeTemp == PXMDEventType.In.rawValue && (additionalIdTemp == additionalId || additionalPDFUrl == additionalPDFUrlTemp) {
                index = i
                let outTime = item["time"] as! Double
                let inTime = dic["time"] as! Double
                let duration = (inTime - outTime)
                if duration < 10 {
                    md_realTime_learning_removeRedundant(code: code)
                    return
                }
                md_realTimeReuqest(detailsType: detailsType ?? "", duration: duration, id: additionalId ?? "", pdfUrl: additionalPDFUrl ?? "", date: date ?? "", videoPath: videoPath ?? "", successHandler: {
                    
                }) {
                    
                }
            }
        }
        if index != -1 {
            realTimeLearning.remove(at: index)
        }
    }
    
    // 不满足需求的删除
    func md_realTime_learning_removeRedundant(code: String) {
        for (i, v) in realTimeLearning.enumerated() {
            let itemCode = v["code"] as! String
            if itemCode == code {
                realTimeLearning.remove(at: i)
            }
        }
    }
    
}

//MARK: 两条事件上传策略
extension PXMD {
    
    func md_special_pageStart(code: String, name: String, page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : PXMDWidgetType.page.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : PXMDEventType.In.rawValue,
            "additional" : additional] as [String : Any]
        #if DEBUG
//        print("md_event：", dic)
        #endif
        mdEvents.append(dic)
        
        md_uploadData()
    }
    
    func md_special_pageEnd(code: String, name: String, page: String = "", describe: String = "", additional: [String : Any] = ["":""]) {
        let dic = [
            "code" : code,
            "name" : name,
            "page" : page,
            "describe" : describe,
            "type" : PXMDWidgetType.page.rawValue,
            "time" : Date().timeIntervalSince1970,
            "event" : PXMDEventType.out.rawValue,
            "additional" : additional] as [String : Any]
        #if DEBUG
//        print("md_event：", dic)
        #endif
        mdEvents.append(dic)
        
        md_uploadData()
    }
    
    func md_uploadData2() {
        if mdEvents.count % kMaxUploadNum2 == 0 {
            md_initBaseData()
            mdJSON["events2"] = mdEvents
            md_reuqest(events: mdJSON, successHandler: {eventCount in
                let _ = GAPlistManager.share.removeArrayPlist(fileName: kPXMDFileName) {
                    [weak self] b in
                    #if DEBUG
//                    print("是否删除成功?", b)
                    #endif
                    if let weakSelf = self {
                        weakSelf.mdEvents2.removeSubrange(0..<(weakSelf.mdEvents.count > eventCount ? eventCount : weakSelf.mdEvents.count))
                        weakSelf.mdJSON["events2"] = weakSelf.mdEvents
                    }
                }
            }) {
                // 传输失败 不做处理
            }
        }
    }
    
}

extension String {
    public var md_ipAddress: String {
        var addresses = [String]()
        var ifaddr : UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while (ptr != nil) {
                let flags = Int32(ptr!.pointee.ifa_flags)
                var addr = ptr!.pointee.ifa_addr.pointee
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                            if let address = String(validatingUTF8:hostname) {
                                addresses.append(address)
                            }
                        }
                    }
                }
                ptr = ptr!.pointee.ifa_next
            }
            freeifaddrs(ifaddr)
        }
        return addresses.first ?? "0.0.0.0"
    }
}
