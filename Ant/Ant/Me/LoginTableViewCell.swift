//
//  LoginTableViewCell.swift
//  AntProfileDemo
//
//  Created by Weslie on 2017/7/7.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class LoginTableViewCell: UITableViewCell {

    @IBOutlet weak var avaImage: UIImageView!
    @IBOutlet weak var loginHint: UILabel!
    @IBOutlet weak var detialHint: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        let   profileNumber  = UserInfoModel.shareInstance.account?.phoneNumber
        loginHint.text = profileNumber != nil ? profileNumber :  "点击登录账号"
        detialHint.text = profileNumber != nil ? nil :  "登陆享用同步数据等完整功能"
        //接受通知
        NotificationCenter.default.addObserver(self, selector: #selector(didLogin), name: isLoginNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func didLogin() {
        if isLogin == true {
            loginHint.text = UserInfoModel.shareInstance.account?.phoneNumber
            detialHint.text = ""
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
