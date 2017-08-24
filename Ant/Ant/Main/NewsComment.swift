//
//  NewsComment.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/15.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class NewsComment: NSObject {
    var   id : NSNumber?
    var   msg_id : NSNumber?
    var   time : String?
    var   height : CGFloat?
    var   content : String? {
        didSet {
        self.height =  self.getLabHeight(labelStr: content!, font: UIFont.italicSystemFont(ofSize: 14), width: width - 90) +  CGFloat(110)
      
        }
    
    }
    
    var   user_info : NewsUserInfoModel?
    
    func getLabHeight(labelStr: String, font: UIFont, width: CGFloat) -> CGFloat {
        let statusLabelText = labelStr
        let size = CGSize(width: width, height: 900)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.height
    }

    

}
