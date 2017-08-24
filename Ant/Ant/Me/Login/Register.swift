//
//  LoginWithPwdVC.swift
//  Ant
//
//  Created by Weslie on 2017/7/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SVProgressHUD
class Register: UIViewController {
    
    fileprivate var countDownTimer: Timer?
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var idNumber: UITextField!
    @IBOutlet weak var pwdVisible: UIButton!
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

    
    
    @IBOutlet weak var NavBar: UINavigationBar!
    
    @IBAction func register(_ sender: UIButton) {
        
        if phoneNumber.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入手机号码")
            
        } else if phoneNumber.text?.isValidePhoneNumber == false {
            self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
        } else if password.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入密码")
        } else if idNumber.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入验证码")
        } else {
            if phoneNumber.text!.isValidePhoneNumber == true {
                
                SMSSDK.commitVerificationCode(idNumber.text!, phoneNumber: phoneNumber.text!, zone: "86", result: { (error: Error?) in
                    if error != nil {
                        self.presentHintMessage(target: self, hintMessgae: "验证码输入错误")
                    } else {
                        weak var weakSelf = self
                        NetWorkTool.shareInstance.UserRegister((weakSelf?.phoneNumber.text!)!, password: (weakSelf?.password.text!)!, finished: { (userInfo, error) in
                            if error == nil {
                            //存储手机号码和密码
                            sender.saveUserData(phone: self.phoneNumber.text!, password: self.password.text!, token: "")
                            //存储数据到服务器
                            let alert = UIAlertController(title: "提示", message: "注册成功", preferredStyle: .alert)
                            let ok = UIAlertAction(title: "好的", style: .default, handler: { (_) in
                            //登陆界面销毁
                            weakSelf?.navigationController?.popToRootViewController(animated: true)
                              })
                            alert.addAction(ok)
                            weakSelf?.present(alert, animated: true, completion: nil)

                            }
                        })
                    }
                })
            } else {
                self.presentHintMessage(target: self, hintMessgae: "请输入正确的手机号码")
            }
        }
        
        
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var bg1: UIImageView!
    @IBOutlet weak var bg2: UIImageView!
    @IBOutlet weak var bg3: UIImageView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadCustomAttrs()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.isCounting = false
    }
    
    func loadCustomAttrs() {
        
        phoneNumber.changeColor()
        phoneNumber.delegate = self
        password.changeColor()
        password.delegate = self
        idNumber.changeColor()
        sendIDNum.changeBtnStyle()
        sendIDNum.addTarget(self, action: #selector(sendSecurityCode), for: .touchUpInside)
        
        pwdVisible.addTarget(self, action: #selector(passwordVisible), for: .touchUpInside)
        
        bg1.changeAttrs()
        bg2.changeAttrs()
        bg3.changeAttrs()
        
        NavBar.subviews[0].alpha = 0.5
    }

    
}

extension Register {
    func passwordVisible() {
        password.isSecureTextEntry = !password.isSecureTextEntry
        if password.isSecureTextEntry == true {
            self.pwdVisible.setImage(#imageLiteral(resourceName: "login_icon_passwordeye_close"), for: .normal)
        } else {
            self.pwdVisible.setImage(#imageLiteral(resourceName: "login_icon_passwordeye_open"), for: .normal)
        }
    }
    
    func sendSecurityCode() {
        
        if phoneNumber.text == "" {
            self.presentHintMessage(target: self, hintMessgae: "请输入手机号码")
        }
        
        SMSSDK.getVerificationCode(by: SMSGetCodeMethodSMS, phoneNumber: phoneNumber.text, zone: "86", result: { (error: Error?) in
            if error != nil {
                print(error as Any)
            } else {
                self.phoneNumber.endEditing(true)
                self.presentHintMessage(target: self, hintMessgae: "验证码发送成功")
                self.isCounting = true
                
            }
        })
    }

    
}

extension Register: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        password.endEditing(true)
        idNumber.endEditing(true)
        
        return true
    }
}
