//
//  GACalanderDataViewController.swift
//  YYFramework
//
//  Created by houjianan on 2019/11/28.
//  Copyright © 2019 houjianan. All rights reserved.
//

import UIKit

class GACalanderDataViewController: GANavViewController {
    
    var calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()

        b_showNavigationView(title: "日历数据")
        
        /*
         NSCalendarIdentifierGregorian         公历
         NSCalendarIdentifierBuddhist          佛教日历
         NSCalendarIdentifierChinese           中国农历
         NSCalendarIdentifierHebrew            希伯来日历
         NSCalendarIdentifierIslamic           伊斯兰日历
         NSCalendarIdentifierIslamicCivil      伊斯兰教日历
         NSCalendarIdentifierJapanese          日本日历
         NSCalendarIdentifierRepublicOfChina   中华民国日历（台湾）
         NSCalendarIdentifierPersian           波斯历
         NSCalendarIdentifierIndian            印度日历
         NSCalendarIdentifierISO8601           ISO8601
         */
//        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
        
        
        calendar.locale = Locale(identifier: "zh_CN")
        calendar.timeZone = TimeZone(abbreviation: "EST")!
        calendar.timeZone = TimeZone(secondsFromGMT: +28800)!
        
        // 设定每周的第一天从星期几开始
        /*
            1 代表星期日开始，2 代表星期一开始，以此类推。默认值是 1
        */
        calendar.firstWeekday = 1
        // 设置每年及每月第一周必须包含的最少天数
        /*
            设定第一周最少包括 3 天，则 value 传入 3
        */
        calendar.minimumDaysInFirstWeek = 7
        
        let calendarIdentifier = calendar.identifier

        // 获取地区信息
        let localeIdentifier1 = calendar.locale?.identifier
            
        // 获取时区信息
        let timeZone = calendar.timeZone
            
        // 获取每周的第一天从星期几开始
        let firstWeekday = calendar.firstWeekday
            
        // 获取第一周必须包含的最少天数
        let minimumDaysInFirstWeek = calendar.minimumDaysInFirstWeek
        
        print(calendarIdentifier, localeIdentifier1 ?? "", timeZone, firstWeekday, minimumDaysInFirstWeek)
        print(Date())
        let count = calendar.ordinality(of: Calendar.Component.weekday, in: Calendar.Component.weekOfMonth, for: Date())
        print(count ?? 0)
    }

    func getCount() {
        
    }
    
    // 今天是几号
    func getCurrentDateDay() -> Int {
        return calendar.ordinality(of: Calendar.Component.day, in: Calendar.Component.month, for: Date()) ?? -1
    }
    
    func getMonthHasDays(y: Int, m: Int) -> Int {
        GADate.getCountOfDaysInMonth(year: 0, month: 0)
        return calendar.ordinality(of: Calendar.Component.day, in: Calendar.Component.month, for: Date()) ?? -1
    }

}
