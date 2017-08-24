//
//  Extension.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/18.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

extension UIView {
    func changeBorderLineStyle(target: UIView, borderColor: UIColor) {
        target.layer.borderColor = borderColor.cgColor
        target.layer.cornerRadius = 2
        target.layer.borderWidth = 1
        target.layer.masksToBounds = true
    }
    
}

extension UIButton {
    func addSingleUnderline(color: UIColor) {
        let text = titleLabel?.text ?? ""
        let attrs = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue, NSUnderlineColorAttributeName: color] as [String : Any]
        setAttributedTitle(NSAttributedString(string: text, attributes: attrs), for: .normal)

    }
}

extension UILabel {
    //获取高度
    func getLabHeight(labelStr: String, font: UIFont, width: CGFloat) -> CGFloat {
        let statusLabelText = labelStr
        let size = CGSize(width: width, height: 900)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.height
    }
}

extension UILabel {
    func setTitleWithSpace(_ input: String) {
        text = "  " + input + "  "
    }
    
    func setPrice(_ input: String) {
        text = "$" + input
    }
}
