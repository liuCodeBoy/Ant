//
//  Menu.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/18.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class Menu: UIView {

    var view:UIView?
    
//    var wechatID: String = ""
    var phoneURL: String = ""
    var emailURL: String = ""
    var qqURL: String = ""
    
    @IBAction func favourite(_ sender: UIButton) {
    }
    
    @IBAction func wechat(_ sender: UIButton) {
        

        jumpToApp(URLString: "wechat://")
    }
    
    @IBAction func talk(_ sender: UIButton) {
    }
    
    @IBAction func phoneCall(_ sender: UIButton) {
        jumpToApp(URLString: "tel://\(phoneURL)")
    }
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    //初始化方法。
    func initFromXib(){
        //获取Xib文件名字
        let xibName = NSStringFromClass(self.classForCoder)
        let xibClassName = xibName.characters.split{$0 == "."}.map(String.init).last
        //使用Xib初始化一个View
        let view = Bundle.main.loadNibNamed(xibClassName!, owner: self, options: nil)?.first as! UIView
        view.frame = self.bounds
        view.translatesAutoresizingMaskIntoConstraints = true
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.addSubview(view)
        self.view = view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initFromXib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)!
        initFromXib()
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let phone = viewModel?.contact_phone {
                self.phoneNumber.text = phone
            }
            if let name = viewModel?.contact_name {
                self.name.text = name
            }
        }
    }
    
}
