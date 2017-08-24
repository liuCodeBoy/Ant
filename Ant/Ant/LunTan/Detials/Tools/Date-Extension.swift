//
//  Date-Extension.swift
//  DemoOfWeibo
//
//  Created by Weslie on 2017/5/28.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import Foundation

extension Date {
    
    static func createDateString(_ createAtStr: String) -> String {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "EEE MM dd HH:mm:ss Z yyyy"
        fmt.locale = Locale(identifier: "en")
        
        guard let createDate = fmt.date(from: createAtStr) else {
            return ""
        }
        
        
// MARK:- 修改入住时间内容
        
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince(createDate))
        
        
        if interval < 60 {
            return "刚刚"
        }
        if interval < 60 * 60 {
            return "\(interval / 60)分钟前"
        }
        if interval < 60 * 60 * 24 {
            return "\(interval / (60 * 60))小时前"
        }
        
        let calendar = Calendar.current
        if calendar.isDateInYesterday(createDate) {
            fmt.dateFormat = "昨天 HH:mm"
            let timeString = fmt.string(from: createDate)
            return timeString
        }
        
        let components = (calendar as NSCalendar).components(.year, from: createDate, to: nowDate, options: [])
        if components.year! < 1 {
            fmt.dateFormat = "MM-dd HH:mm"
            let timeString = fmt.string(from: createDate)
            return timeString
        }
        
        if components.year! >= 1 {
            fmt.dateFormat = "yyyy-MM-dd HH:mm"
            let timeString = fmt.string(from: createDate)
            return timeString
        }
        return ""
    }
    
}
