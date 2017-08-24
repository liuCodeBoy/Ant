//
//  BaseTabBarVC.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class BaseTabBarVC: UITabBarController {
    
    //全局导航栏颜色
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //创建基础四个控制器
   
        
        let mainVC = MainViewController()
        createdNewVC(VCName: "首页", childVC: mainVC, tabImageName: "tabbar_icon_home")
 
        let lunTanVC = LunTanViewController()
        createdNewVC(VCName: "论坛", childVC: lunTanVC, tabImageName: "tabbar_icon_luntan")
        
        let messageVC = MessageViewController()
        createdNewVC(VCName: "消息", childVC: messageVC, tabImageName: "tabbar_icon_message")

        let meVC = ProfileViewController()
        createdNewVC(VCName: "我", childVC: meVC, tabImageName: "tabbar_icon_profile")
 
    
    }

    
    func createdNewVC(VCName : String ,childVC : UIViewController,tabImageName : NSString) -> (){
        childVC.title = VCName
        let  title =  UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 44))
        title.text = "小蚂蚁"
        title.font = UIFont.systemFont(ofSize: 20)
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.white
        childVC.navigationItem.titleView = title
        let  selectedImage = UIImage(named: "\(tabImageName)_pre")
        selectedImage?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = UIImage(named: "\(tabImageName)_highlighted")
        
        let  normalImage = UIImage(named: tabImageName as String)
        normalImage?.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.image = normalImage
        childVC.tabBarItem.image?.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(UINavigationController(rootViewController: childVC))
        childVC.navigationController?.navigationBar.isTranslucent = false
    

    }
  


}
