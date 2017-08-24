//
//  RegisterVC.swift
//  Ant
//
//  Created by Weslie on 2017/7/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import  SVProgressHUD
class LoginWithPwd: UIViewController {

    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var Nav: UINavigationBar!
    
    @IBAction func login(_ sender: UIButton) {
        
        if phoneNumber.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入手机号码")
        } else if phoneNumber.text?.isValidePhoneNumber == false {
            self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
        } else if password.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入密码")
        } else if phoneNumber.text?.isValidePhoneNumber == true {
            //检查密码是否与服务器数据匹配
            weak var weakSelf = self
            NetWorkTool.shareInstance.UserLogin((weakSelf?.phoneNumber.text)!, password: (weakSelf?.password.text)!, type: "pas", finished: { (userInfo, error) in
                if error == nil {
                let  userInfoDict = userInfo!
                let loginStaus =  userInfoDict["code"] as? String
                if  loginStaus == "200" {
                    let  resultDict = userInfoDict["result"] as? NSDictionary
                    let token = resultDict?["token"]
                    // 存储手机号码
                    sender.savePhoneNumber(phone: (weakSelf?.phoneNumber.text!)!, token: token as! String)
                    let alert = UIAlertController(title: "提示", message: "登录成功", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "好的", style: .default, handler: { (_) in
                        isLogin = true
                        //发送值到profileVC
                        NotificationCenter.default.post(name: isLoginNotification, object: nil)
                        
                        //登陆界面销毁
                        weakSelf?.navigationController?.popToRootViewController(animated: true)
                    })
                    alert.addAction(ok)
                    weakSelf?.present(alert, animated: true, completion: nil)
                }else{
                    SVProgressHUD.showError(withStatus:userInfoDict["msg"]! as! String )
                    }
                }
            })
 
        } else {
            self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
        }
        
        }
    
    
    @IBAction func loginWithIDNumber(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func forgetPwd(_ sender: UIButton) {
        print("forgetpwd")
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet weak var bg1: UIImageView!
    @IBOutlet weak var bg2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomAttrs()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func loadCustomAttrs() {
        phoneNumber.changeColor()
        phoneNumber.delegate = self
        password.changeColor()
        password.delegate = self
        
        bg1.changeAttrs()
        bg2.changeAttrs()
        
        Nav.subviews[0].alpha = 0.5
        
    }

}

extension LoginWithPwd: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        phoneNumber.endEditing(true)
        password.endEditing(true)
        
        return true
    }
}
