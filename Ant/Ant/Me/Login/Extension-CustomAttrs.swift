//
//  Extension-UITextField.swift
//  Ant
//
//  Created by Weslie on 2017/7/12.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

var filePath: String?

extension UITextField {
    func changeColor() {
        tintColor = UIColor.white
        setValue(UIColor.white, forKeyPath: "_placeholderLabel.textColor")
        textColor = UIColor.white
    }
}

extension UIImageView {
    func changeAttrs() {
        backgroundColor = UIColor.init(white: 0.9, alpha: 0.1)
        layer.cornerRadius = 5
        layer.masksToBounds = true
    }
}

extension UIButton {
    func changeBtnStyle() {
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 5
        layer.masksToBounds = true
        titleLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func savePhoneNumber(phone number: String , token : String) {
        let userPhoneNum = UserInfo(phoneNumber: number, token: token)
        NSKeyedArchiver.archiveRootObject(userPhoneNum, toFile: UserInfoModel.shareInstance.accountPath)
        UserInfoModel.shareInstance.account = userPhoneNum
    }
    
    func saveUserData(phone number: String, password: String ,token : String) {
        let userInfo = UserInfo(phoneNumber: number, password: password ,token : token)
        NSKeyedArchiver.archiveRootObject(userInfo, toFile: UserInfoModel.shareInstance.accountPath)
        UserInfoModel.shareInstance.account = userInfo
    }
    
}

extension UIViewController {
    

        
    func presentHintMessage(target: UIViewController, hintMessgae: String) {
        let alert = UIAlertController(title: "提示", message: hintMessgae, preferredStyle: .alert)
        let ok = UIAlertAction(title: "好的", style: .cancel, handler: nil)
        alert.addAction(ok)
        target.present(alert, animated: true, completion: nil)
    }
    
    
}





extension String {
    
    var isValidePhoneNumber: Bool {
        get {
            let mobileRE: String = "^((13[0-9])|(147)|(15[0-3,5-9])|(18[0,0-9])|(17[0-3,5-9]))\\d{8}$"
            let regex = NSPredicate(format: "SELF MATCHES %@", mobileRE)
            
            if regex.evaluate(with: self) == true {
                return true
            } else {
                return false
            }
        }
        
        set {
            
        }
    }
    
//    func isValidePhoneNumber() -> Bool {
//            
//        let mobileRE: String = "^((13[0-9])|(147)|(15[0-3,5-9])|(18[0,0-9])|(17[0-3,5-9]))\\d{8}$"
//        let regex = NSPredicate(format: "SELF MATCHES %@", mobileRE)
//        
//        if regex.evaluate(with: self) == true {
//            return true
//        } else {
//            return false
//        }
//    }
}

