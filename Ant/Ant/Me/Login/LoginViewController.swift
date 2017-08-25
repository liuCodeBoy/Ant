//
//  LoginViewController.swift
//  Ant
//
//  Created by Weslie on 2017/7/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SVProgressHUD

var isLogin: Bool = UserInfoModel.shareInstance.isLogin

class LoginViewController: UIViewController {
    

    
    private var countDownTimer: Timer?
    
    @IBOutlet weak var phoneNum: UITextField!
    //验证码
    @IBOutlet weak var idNum: UITextField!
    //发送验证
    @IBOutlet weak var sendIDNum: UIButton!
    
    fileprivate var remainingSeconds: Int = 0 {
        willSet {
            sendIDNum.setTitle("重新发送\(newValue)秒", for: .normal)
            if newValue <= 0 {
                sendIDNum.setTitle("发送验证码", for: .normal)
                isCounting = false
            }
        }
    }
    
    fileprivate var isCounting = false {
        willSet {
            if newValue {
                countDownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
                remainingSeconds = 60
            } else {
                countDownTimer?.invalidate()
                countDownTimer = nil
            }
            sendIDNum.isEnabled = !newValue
        }
    }
    
    @objc fileprivate func updateTime() {
        remainingSeconds -= 1
    }
    
    @IBAction func login(_ sender: UIButton) {
        
    
        
        if phoneNum.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入手机号码")
            
        } else if phoneNum.text?.isValidePhoneNumber == false {
            self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
        } else if idNum.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入验证码")
        } else {
            if phoneNum.text!.isValidePhoneNumber == true {
                
                SMSSDK.commitVerificationCode(idNum.text!, phoneNumber: phoneNum.text!, zone: "86", result: { (error: Error?) in
                    if error != nil {
                        print(error as Any)
                        self.presentHintMessage(target: self, hintMessgae: "验证码输入错误")
                    } else {
                         weak var weakSelf = self
                    NetWorkTool.shareInstance.UserLogin((weakSelf?.phoneNum.text!)!, password: "", type: "sms", finished: { (userInfo, error) in
                            let  userInfoDict = userInfo!
                        let loginStaus =  userInfoDict["code"]  as? String
                            if  loginStaus == "200" {
                                let  resultDict = userInfoDict["result"] as? NSDictionary
                                let token = resultDict?["token"]
                                // 存储手机号码
                                sender.savePhoneNumber(phone: (weakSelf?.phoneNum.text!)!, token: token as! String)
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
                        })
                    }
                })
            } else {
                self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
            }
        }
        
    }
    
    @IBAction func loginWithPwd(_ sender: UIButton) {
        let loginWithPwd = LoginWithPwd()
        self.navigationController?.pushViewController(loginWithPwd, animated: true)
    }
    
    @IBAction func register(_ sender: UIButton) {
        let registerVC = Register()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    
    @IBOutlet weak var bg1: UIImageView!
    @IBOutlet weak var bg2: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCustomAttr()
        
        let target = self.navigationController?.interactivePopGestureRecognizer!.delegate
        let pan = UIPanGestureRecognizer(target:target, action:Selector(("handleNavigationTransition:")))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        //同时禁用系统原先的侧滑返回功能
        self.navigationController?.interactivePopGestureRecognizer!.isEnabled = false
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.isCounting = false
    }

    func loadCustomAttr() {
        phoneNum.changeColor()
        phoneNum.delegate = self
        idNum.changeColor()
        idNum.delegate = self
        
        sendIDNum.changeBtnStyle()
        sendIDNum.addTarget(self, action: #selector(sendSecurityCode), for: .touchUpInside)
        
        bg1.changeAttrs()
        bg2.changeAttrs()
        
        
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.idNum.endEditing(true)
        return true
    }
}

extension LoginViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if self.childViewControllers.count == 1 {
            return false
        }
        return true
    }
}

extension LoginViewController {
    func sendSecurityCode() {
        
        if phoneNum.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入手机号码")
        }else if  phoneNum.text?.isValidePhoneNumber == false{
              self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
        }
        
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: phoneNum.text, zone: "86", result: { (error: Error?) in
            if error != nil {
                print(error as Any)
            } else {
                print("发送成功")
                self.phoneNum.endEditing(true)
                self.presentHintMessage(target: self, hintMessgae: "验证码发送成功")
                self.isCounting = true
                
            }
        })
    }

}



