//
//  ThemeColor.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/18.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit


extension UIColor {
    
    
    //主题色
    class func applicationMainColor() -> UIColor {
         let app = UIApplication.shared.delegate as? AppDelegate
        return (app?.theme)!
      // return UIColor(red: 238/255, green: 64/255, blue: 86/255, alpha:1)
       //
        //return  UIColor.purple

    }
    
    //第二主题色
    class func applicationSecondColor() -> UIColor {
//        return UIColor.lightGray
//        return  UIColor.purple
        let app = UIApplication.shared.delegate as? AppDelegate
        return (app?.theme)!
    }
    
    //警告颜色
    class func applicationWarningColor() -> UIColor {
        return UIColor(red: 0.1, green: 1, blue: 0, alpha: 1)
    }
    
    //链接颜色
    class func applicationLinkColor() -> UIColor {
        return UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha:1)
    }
    
}
