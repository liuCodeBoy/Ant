//
//  CustomButton.swift
//  E
//
//  Created by LiuXinQiang on 17/3/21.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    fileprivate  let  kTitleRatio:CGFloat  = 0.4
    // 设置button内部image尺寸
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageX:CGFloat = contentRect.size.width * 0.3
        let imageY:CGFloat = contentRect.size.height * 0.08
        let imageWidth:CGFloat = contentRect.size.width * 0.4
        let imageHeight:CGFloat = contentRect.size.height * (1 -  kTitleRatio)
        return CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
        
    }
    
    //设置button内部titlechicun
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        let  titleX : CGFloat = contentRect.size.width * 0.3
        let  titleHeight : CGFloat  = contentRect.size.height * kTitleRatio
        let  titleY : CGFloat = contentRect.size.height - titleHeight * 0.9
        let  titleWidth : CGFloat = contentRect.size.width
        return CGRect(x: titleX, y: titleY, width: titleWidth, height: titleHeight)
    }

}

class MallButton: UIButton {
    fileprivate  let  kTitleRatio:CGFloat  = 0.4
    // 设置button内部image尺寸
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        let imageX:CGFloat = contentRect.size.width * 0.3
        let imageY:CGFloat = contentRect.size.height * 0.08
        let imageWidth:CGFloat = contentRect.size.width * 0.6
        let imageHeight:CGFloat = contentRect.size.height * (1 -  kTitleRatio)
        return CGRect(x: imageX, y: imageY, width: imageWidth, height: imageHeight)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.font = UIFont.systemFont(ofSize: 13 * ((appdelgate?.fontSize)! - 0.15) )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //设置button内部titlechicun
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
      
     //   let  titleX : CGFloat = contentRect.size.width * 0.3
        let  titleHeight : CGFloat  = contentRect.size.height * kTitleRatio
        let  titleY : CGFloat = contentRect.size.height - titleHeight * 0.9
        let  titleWidth : CGFloat = contentRect.size.width
        return CGRect(x: (self.imageView?.center.x)! - ( titleWidth / 2), y: titleY, width: titleWidth, height: titleHeight)
       

    }
  
    
}
