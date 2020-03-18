//
//  GADate.swift
//  YYFramework
//
//  Created by houjianan on 2019/5/16.
//  Copyright © 2019 houjianan. All rights reserved.
//  日期管理 尽量使用真机运行

import Foundation

enum GADateFormatType: String {
    case y_m = "yyyy-MM", y_m_d = "yyyy-MM-dd", y_m_d_h_m_s = "yyyy-MM-dd HH:mm:ss", y_m_d_chinese = "yyyy年MM月dd日", y_m_d_h_m_s_chinese = "yyyy年MM月dd日HH:mm:ss", h_m_s = "HH:mm:ss", utc = "EEE MMM dd yyyy HH:mm:ss 'GMT'Z '(UTC)'"
}

enum GADateNextDayType: String {
    case Yesterday = "昨天", Tomorrow = "明天"
}

enum GADateNextWeekType: String {
    case before = "上一周", next = "下一周"
}

class GADate {
    
    static var calendar = Calendar(identifier:Calendar.Identifier.gregorian)
    
    static var currentDate: Date {
        let date = Date()
        let zone = NSTimeZone.local
        let interval:NSInteger = zone.secondsFromGMT(for: date)
        let now = date.addingTimeInterval(TimeInterval(interval))
        return now
    }
    
    static var systemDate: Date {
        return Date()
    }
    
    static func date(year: Int, month: Int, day: Int, h: Int = 12, m: Int = 12, s: Int = 12) -> Date? {        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d_h_m_s.rawValue
        let date = dateFormatter.date(from: "\(year)"+"-\(month)"+"-\(day)"+" \(h)"+":\(m)"+":\(s)")
        return date ?? nil
    }
    
    //MARK: - 当前时间相关
    //MARK: 今年
    static func currentYear() ->Int {
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.year!
    }
    //MARK: 今月
    static func currentMonth() ->Int {
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.month!
        
    }
    //MARK: 今日
    static func currentDay() -> Int {
        let com = calendar.dateComponents([.year,.month,.day], from: Date())
        return com.day!
        
    }
    //MARK: 今天星期几
    static func currentWeekDay() -> Int{
        let interval = Int(Date().timeIntervalSince1970)
        let days = Int(interval/24*60*60)
        let weekday = ((days + 4)%7+7)%7
        return weekday == 0 ? 7 : weekday
    }
    //MARK: 本月天数
    static func countOfDaysInCurrentMonth() -> Int {
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: Date())
        return (range?.length)!
        
    }
    //MARK: 当月第一天是星期几
    static func firstWeekDayInCurrentMonth() -> Int {
        //星期和数字一一对应 星期日：7
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d_h_m_s.rawValue
        let date = dateFormatter.date(from: String(Date().year)+"-"+String(Date().month) + "-1 1:1:1")
        let calender = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        var week = comps?.weekday
        if week == 1 {
            week = 8
        }
        return week! - 1
    }
    //MARK: 指定月份第一天是星期几
    static func firstWeekDay(year: Int, month: Int) -> Int {
        //星期和数字一一对应 星期日：7
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d_h_m_s.rawValue
        let date = dateFormatter.date(from: "\(year)"+"-"+"\(month)" + "-1 1:1:1")
        let calender = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calender as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        var week = comps?.weekday
        if week == 1 {
            week = 8
        }
        return week! - 1
    }
    
    //MARK: - 获取指定日期各种值
    //根据年月得到某月天数
    static func getCountOfDaysInMonth(year: Int,month: Int) ->Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d_h_m_s.rawValue
        let date = dateFormatter.date(from: "\(year)"+"-"+"\(month)" + "-1 1:1:1")
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let range = (calendar as NSCalendar?)?.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: date!)
        return (range?.length)!
    }
    
    //MARK: 根据年月得到某月第一天是周几
    static func getfirstWeekDayInMonth(year: Int, month: Int) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d_h_m_s.rawValue
        let date = dateFormatter.date(from: "\(year)"+"-"+"\(month)" + "-1 1:1:1")
        let calendar = Calendar(identifier:Calendar.Identifier.gregorian)
        let comps = (calendar as NSCalendar?)?.components(NSCalendar.Unit.weekday, from: date!)
        let week = comps?.weekday
        return week! - 1
    }
    
    //MARK: 当前日期周一到周日
    static func getWeekTime(_ dateStr: String) -> Array<String> {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d.rawValue
        let nowDate = dateFormatter.date(from: dateStr)
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: nowDate!)
        
        // 获取今天是周几
        let weekDay = comp.weekday
        // 获取几天是几号
        let day = comp.day
        
        // 计算当前日期和本周的星期一和星期天相差天数
        var firstDiff: Int
        var lastDiff: Int
        // weekDay = 1;
        if (weekDay == 1) {
            firstDiff = -6;
            lastDiff = 0;
        } else {
            firstDiff = calendar.firstWeekday - weekDay! + 1
            lastDiff = 8 - weekDay!
        }
        
        // 在当前日期(去掉时分秒)基础上加上差的天数
        var firstDayComp = calendar.dateComponents([.year, .month, .day], from: nowDate!)
        firstDayComp.day = day! + firstDiff
        let firstDayOfWeek = calendar.date(from: firstDayComp)
        
        var lastDayComp = calendar.dateComponents([.year, .month, .day], from: nowDate!)
        lastDayComp.day = day! + lastDiff
        let lastDayOfWeek = calendar.date(from: lastDayComp)
        
        let firstDay = dateFormatter.string(from: firstDayOfWeek!)
        let lastDay = dateFormatter.string(from: lastDayOfWeek!)
        let weekArr = [firstDay, lastDay]
        
        return weekArr;
    }
    
    //MARK: 当前日期周日到周六
    static func getWeekDates(_ date: Date, formateType: GADateFormatType = .y_m_d) -> [Date] {
        
        let nowDate = GADate.formatterDate(date: date, formateType: formateType)
        
        let calendar = Calendar.current
        let comp = calendar.dateComponents([.year, .month, .day, .weekday], from: nowDate)
        
        // 获取今天是周几
        let weekDay = comp.weekday
        
        let y = weekDay!
        let t = 7 - weekDay!
        var dates: [Date] = [nowDate]
        
        if y > 0 {
            for _ in 1..<y {
                dates.insert(GADate.newTargetDate(dates.first!, type: .Yesterday), at: 0)
            }
        }
        if t > 0 {
            for _ in 0..<t {
                dates.insert(GADate.newTargetDate(dates.last!, type: .Tomorrow), at: dates.count)
            }
        }
        return dates
    }
    
    //MARK: 前一周所有日期 后一周所有日期 （周日到周六）
    static func getNextWeek(_ date: Date, type: GADateNextWeekType) -> [Date] {
        let arr = GADate.getWeekDates(date)
        let targetDate = type == .next ? arr.last : arr.first
        let newTargetDate = type == .next ? GADate.newTargetDate(targetDate!, type: .Tomorrow) : GADate.newTargetDate(targetDate!, type: .Yesterday)
        let arrDates = GADate.getWeekDates(newTargetDate)
        return arrDates
    }
    
    //MARK: 昨天/明天
    static func newTargetDate(_ nowDate: Date, type: GADateNextDayType, formateType: GADateFormatType = .y_m_d) -> Date {
        
        let date = GADate.formatterDate(date: nowDate, formateType: formateType)
        
        var newTime: TimeInterval!
        if type == .Yesterday {
            newTime = -(24*60*60) // 昨天
        } else if type == .Tomorrow {
            newTime = 24*60*60 // 明天
        } else {
            
        }
        
        let newDate = date.addingTimeInterval(newTime)
        return newDate
    }
    
    //MARK: date转日期字符串
    static func dateToDateString(_ date: Date, dateFormat: String) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        
        let date = formatter.string(from: date)
        return date
    }
    
    //MARK: 当前date转日期字符串
    static func currentDateToDateString(dateFormat: String) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        
        let date = formatter.string(from: GADate.currentDate)
        return date
    }
    
    //MARK: 日期字符串转date
    static func dateStringToDate(_ dateStr: String, fromateType: GADateFormatType) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        //        dateFormatter.dateFormat = GADateFormatType.y_m_d.rawValue
        dateFormatter.dateFormat = fromateType.rawValue
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    //MARK: 时间字符串转date
    static func timeStringToDate(_ dateStr: String, _ type: GADateFormatType) -> Date {
        let dateFormatter = DateFormatter()
        //        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = type.rawValue
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    static func formatterDate(date: Date, formateType: GADateFormatType) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = formateType.rawValue
        let dateString = dateFormatter.string(from: date)
        let date = GADate.dateStringToDate(dateString, fromateType: formateType)
        return date
    }
    
    //MARK: 计算天数差
    static func dateDifference(_ dateA: Date, from dateB: Date) -> Double {
        let interval = dateA.timeIntervalSince(dateB)
        return interval/86400
    }
    
    //MARK: 比较时间先后
    static func compareOneDay(oneDay: Date, withAnotherDay anotherDay: Date) -> Int {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.dateFormat = GADateFormatType.y_m_d.rawValue
        let oneDayStr:String = dateFormatter.string(from: oneDay)
        let anotherDayStr:String = dateFormatter.string(from: anotherDay)
        let dateA = dateFormatter.date(from: oneDayStr)
        let dateB = dateFormatter.date(from: anotherDayStr)
        let result:ComparisonResult = (dateA?.compare(dateB!))!
        //Date1  is in the future
        if(result == ComparisonResult.orderedDescending ) {
            return 1
            
        }
            //Date1 is in the past
        else if(result == ComparisonResult.orderedAscending) {
            return 2
            
        }
            //Both dates are the same
        else {
            return 0
        }
    }
    
    //MARK: 时间与时间戳之间的转化
    //将时间转换为时间戳
    static func stringToTimeStamp(_ stringTime: String) -> Int {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = GADateFormatType.y_m_d_h_m_s.rawValue
        
        dfmatter.locale = Locale.current
        
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        
        return dateSt
    }
    
    //将时间戳转换为年月日
    static func timeStampToString(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = GADateFormatType.y_m_d_chinese.rawValue
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    //将时间戳转换为具体时间
    static func timeStampToStringDetail(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = GADateFormatType.y_m_d_h_m_s_chinese.rawValue
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    //将时间戳转换为时分秒
    static func timeStampToHHMMSS(_ timeStamp: String) -> String {
        let string = NSString(string: timeStamp)
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = GADateFormatType.h_m_s.rawValue
        let date = Date(timeIntervalSince1970: timeSta)
        return dfmatter.string(from: date)
    }
    
    //获取系统的当前时间戳
    static func getStamp() -> Int{
        //获取当前时间戳
        let date = Date()
        let timeInterval:Int = Int(date.timeIntervalSince1970)
        return timeInterval
    }
    
    //月份数字转汉字
    static func numberToChina(monthNum: Int) -> String {
        let ChinaArray = ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"]
        let ChinaStr:String = ChinaArray[monthNum - 1]
        return ChinaStr
    }
    
    //MARK: 数字前补0
    static func add0BeforeNumber(_ number: Int) -> String {
        if number >= 10 {
            return String(number)
        }else{
            return "0" + String(number)
        }
    }
    
    //MARK: 将时间显示为（几分钟前，几小时前，几天前）
    static func compareCurrentTime(str: String, type: GADateFormatType) -> String {
        let timeDate = self.timeStringToDate(str, type)
        let currentDate = NSDate()
        let timeInterval = currentDate.timeIntervalSince(timeDate)
        var temp:Double = 0
        var result:String = ""
        
        if timeInterval/60 < 1 {
            result = "刚刚"
        }else if (timeInterval/60) < 60{
            temp = timeInterval/60
            result = "\(Int(temp))分钟前"
        }else if timeInterval/60/60 < 24 {
            temp = timeInterval/60/60
            result = "\(Int(temp))小时前"
        }else if timeInterval/(24 * 60 * 60) < 30 {
            temp = timeInterval / (24 * 60 * 60)
            result = "\(Int(temp))天前"
        }else if timeInterval/(30 * 24 * 60 * 60)  < 12 {
            temp = timeInterval/(30 * 24 * 60 * 60)
            result = "\(Int(temp))个月前"
        }else{
            temp = timeInterval/(12 * 30 * 24 * 60 * 60)
            result = "\(Int(temp))年前"
        }
        return result
    }
    
    // UTC时间
    static func oe_getDateString(s: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en")
        df.dateFormat = "EEE MMM dd yyyy HH:mm:ss 'GMT'Z '(UTC)'"
        
        guard let date = df.date(from: s) else {return ""}
        
        df.dateFormat = "yyyy-MM-dd"
        return df.string(from: date)
    }
    
    static func oe_getTime(s: String) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "en")
        df.dateFormat = "EEE MMM dd yyyy HH:mm:ss 'GMT'Z '(UTC)'"
        
        guard let date = df.date(from: s) else {return ""}
        
        df.dateFormat = "HH:mm:ss"
        return df.string(from: date)
    }
}

extension Date {
    /// 获取当前 秒级 时间戳 - 10位
    var timeStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
    
    /// 获取当前 毫秒级 时间戳 - 13位
    var milliStamp : String {
        let timeInterval: TimeInterval = self.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        return "\(millisecond)"
    }
}
