//
//  AppJump-Extension.swift
//  Ant
//
//  Created by Weslie on 2017/9/5.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import Foundation

extension UIView {
    func jumpToApp(URLString : String) {
//        1.获取对应应用程序的url
        guard let url = URL(string: URLString) else {return}
        
//        2.判断url是否可以打开
        guard UIApplication.shared.canOpenURL(url) else {return}
        
//        3.打开对应应用程序
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
//    URL:tel://电话号码
//    openURL(URLString: "tel://10010")
//    URL:sms://电话号码
//    openURL(URLString: "sms://10010")
//    mqq://
    
}
