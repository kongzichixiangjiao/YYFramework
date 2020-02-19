//
//  MD（埋点）.swift
//  YYFramework
//
//  Created by houjianan on 2019/8/6.
//  Copyright © 2019 houjianan. All rights reserved.
//  统计类

/*
一、统计类型
 1、界面访问及时长
 2、按钮事件（预约、登录、退出、分享等等）
 3、设备信息
 4、用户信息
 5、启动次数
 6、查看推送通知
 7、启动与退出（退到后台或者杀死进程）时间点
 
二、发送规则
 1、唤醒发送：将埋点数据缓存，App唤醒或者启动是发送给后台
 2、十个事件发送一次  待议
三、接口定义
 1、接收统计数据接口
 2、参数JSON
 
四、字段定义
 eg：首页-home 我的-my
 eg：px001-预约按钮-预约 px002-退出登录-退出
 json: {
     appInfo: {
         name : "",
         version : "",
         platform : ""
     }
     userInfo: {
         phone : "",
         name : "",
     },
     deviceInfo: {
         model : "",
         screenSize : "",
         factory : "apple",
         system : "",
         UUID : ""
     },
     enterApp: {
         time: ""
     },
     outApp: {
         time: ""
     },
     pages: [
        {
            "type" : "app", # page, button, alert, tab等
            "time" : 1499672827876, # 时间戳
            "event" : "in",  # in, out, click, swipe等
            "page" : "MainActivity",
            "name" : "首页"
            "code" : "px001"
            "describe" : "这是一个描述"
        },
        {
            name: "",  #程序内的文件名或者类名
            pageName: "A",
            pageCode: "",
            time: "",
            type: "enter"
        },
        {
            name: "",
            pageName: "A",
            pageCode: "",
            time: "",
            type: "out"
        },
        {
            name: "",
            pageName: "B",
            pageCode: "",
            time: "",
            type: "enter"
        },
        {
            name: "",
            pageName: "B",
            pageCode: "",
            time: "",
            type: "out"
        },
     ],
     events: [
        {
            eventName: "注册",
            eventCode: "",
            describe: "",
            time: ""
        }
        {
            eventName: "预约",
            eventCode: "",
            describe: "",
            time: ""
        }
     ]
 }
注意：
 1、界面访问
 */


import Foundation

class MD {

    static let share: MD = MD()
    
    var mdJSON: [String : Any] = ["":""]
    
    // 统计基本事件
    static func md_event(id: String, label: String = "") {
//        if !label.isEmpty {
//            BaiduMobStat.default()?.logEvent(id, eventLabel: label)
//        }
//
//        MobClick.event(id, label: label)
    }
    
    // 页面开始
    static func md_pageStart(name: String) {
//        BaiduMobStat.default()?.pageviewStart(withName: name)
//
//        MobClick.beginLogPageView(name)
        
//        print("pageStart:\(Date())")
    }
    
    // 页面离开
    static func md_pageEnd(name: String) {
//        BaiduMobStat.default()?.pageviewEnd(withName: name)
//
//        MobClick.endLogPageView(name)
        
//        print("pageEnd:\(Date())")
    }
    
    // 登录
    static func md_signIn(id: String) {
//        MobClick.profileSignIn(withPUID: id)
    }

    // web统计
    // 代理方法： -(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
    static func md_webView(name: String, body: [AnyHashable : Any]) {
//        BaiduMobStat.default()?.didReceiveScriptMessage(name, body: body)
    }

}
