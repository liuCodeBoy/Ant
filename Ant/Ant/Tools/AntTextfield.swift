//
//  AntTextfield.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/25.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class AntTextfield: UITextField {

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
       let inset =  CGRect.init(x: 0 , y: -(bounds.size.height / 2) + 25, width: bounds.size.width - 15, height: bounds.size.height)
        return inset
    }
   
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.origin.x + 15 , y: -(bounds.size.height / 2) + 25, width: bounds.size.width - 15, height: bounds.size.height)
        return inset
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let inset = CGRect.init(x: bounds.origin.x + 15 , y: -(bounds.size.height / 2) + 25, width: bounds.size.width - 15, height: bounds.size.height)
        return inset
    }
}
