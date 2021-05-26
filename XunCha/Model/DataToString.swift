//
//  DataToString.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/12.
//

import Foundation
import UIKit

extension Data {
    //日期 -> 字符串
    static func dateToString(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        formatter.dateFormat = dateFormat
        let date = formatter.string(from: date)
        return date
    }
    
    //日期 -> 字符串
    static func nowDateToString(dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = dateFormat// 自定义时间格式
        let time = dateformatter.string(from: Date())
        return time
    }
}
