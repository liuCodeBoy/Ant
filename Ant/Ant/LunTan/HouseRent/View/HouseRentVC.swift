//
//  HouseRentVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class HouseRentVC: UIViewController {

    
    @IBOutlet weak var areBtn: UIButton!
    @IBOutlet weak var waysBtn: UIButton!
    @IBOutlet weak var houseTypeBtn: UIButton!
    @IBOutlet weak var sourceBtn: UIButton!
    @IBOutlet weak var setOutTime: UIButton!

    @IBOutlet weak var backGroundScrollView: UIScrollView!
    
    lazy var timePickerVC : MyTimePickerVC = MyTimePickerVC()
    override func viewDidLoad() {
        super.viewDidLoad()
    
         setNavgationItem()

    }

    
    
       override func viewWillAppear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = true

    }
    override func viewWillDisappear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false

    }
    
    @IBAction func searchInformation(_ sender: Any) {
        let houseRentVC =  HouseRentListVC()
         houseRentVC.title = "房屋出租"
        self.navigationController?.pushViewController(houseRentVC, animated: true)
        
        
    }
    //发布信息
    func sendOutInformation() -> () {
        
        
        let  giveVC = GiveOutVC()
        giveVC.listTableView  = HouseRentTabView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        self.navigationController?.pushViewController(giveVC, animated: true)
//        let alert = UIAlertController(title: "提示", message: "需要先登录才能进行改操作", preferredStyle: .alert)
//        let notLogin = UIAlertAction(title: "暂不登陆", style: .cancel, handler: nil)
//        let login = UIAlertAction(title: "立即登录", style: .destructive) { (_) in
//            
//        }
//        alert.addAction(login)
//        alert.addAction(notLogin)
//        self.present(alert, animated: true, completion: nil)
    }
    
    //设置导航栏
    func setNavgationItem() -> () {
        let  title =  UILabel(frame: CGRect.init(x: 0, y: 0, width: 100, height: 44))
        title.text = "房屋出租"
        title.font = UIFont.systemFont(ofSize: 20)
        title.textAlignment = NSTextAlignment.center
        title.textColor = UIColor.white
        self.navigationItem.titleView = title
        let  rightBtn =   UIBarButtonItem.init(title: "发布信息", style: .plain, target: self, action: #selector(HouseRentVC.sendOutInformation))
        rightBtn.setTitleTextAttributes([
            NSForegroundColorAttributeName: UIColor.white,
            NSFontAttributeName: UIFont.systemFont(ofSize: 12)
            ], for: .disabled)
        self.navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    //选择区域
    @IBAction func choseArea(_ sender: Any) {
        
    }
    //选择方式
    @IBAction func choseWay(_ sender: Any) {
        let  wayArr = ["不限","单间","客厅","整租","share"]
        let choseVC = ChoseTableView()
        //初始化闭包
        choseVC.choseBtnClouse = {(name) in
             self.waysBtn.setTitle(name, for: .normal)
        }
        choseVC.resourceArr = wayArr as! NSMutableArray
        self.navigationController?.pushViewController(choseVC, animated: true)
        
        
    }
    //选择户型
    @IBAction func choseHouseType(_ sender: Any) {
        let  houseStyleArr = ["不限","Apartment","House","Unit","Studio","Town House","Office","仓库/车库","其它"]
        let choseVC = ChoseTableView()
        //初始化闭包
        choseVC.choseBtnClouse = {(name) in
            self.houseTypeBtn.setTitle(name, for: .normal)
        }
        choseVC.resourceArr = houseStyleArr as! NSMutableArray
        self.navigationController?.pushViewController(choseVC, animated: true)

    }
    
    //选择来源
    @IBAction func choseSource(_ sender: Any) {
        let  houseSourceArr = ["不限","个人","中介"]
        let choseVC = ChoseTableView()
        //初始化闭包
        choseVC.choseBtnClouse = {(name) in
            self.sourceBtn.setTitle(name, for: .normal)
        }
        choseVC.resourceArr = houseSourceArr as! NSMutableArray
        self.navigationController?.pushViewController(choseVC, animated: true)
        
    }
    //选择发布时间
    @IBAction func choseSetOutTime(_ sender: Any) {
        
         weak var  weakself = self
        
           self.addChildViewController(self.timePickerVC)
          timePickerVC.view.frame = CGRect.init(x: 0, y: screenHeight, width: screenWidth, height: 250)
          let  timePickerVCView = timePickerVC.view
          self.view.addSubview(timePickerVCView!)
        
        
         //计算button偏差
          let   offsetY = 250 - (screenHeight - self.setOutTime.frame.maxY)
           UIView.animate(withDuration: 0.3, animations: {
           weakself?.backGroundScrollView.contentOffset = CGPoint.init(x: 0, y: offsetY)
             weakself?.timePickerVC.view?.frame = CGRect.init(x: 0, y: screenHeight - 250, width: screenWidth, height: 250)
           }, completion: {(bool) in
            weakself?.timePickerVC.timeClouse = {(timeString) in
                self.setOutTime.setTitle(timeString, for: .normal)
            }
           })
        
        self.timePickerVC.closeClouse = {() in
              UIView.animate(withDuration: 0.3, animations: {
                            weakself?.timePickerVC.view.frame = CGRect.init(x: 0, y:screenHeight, width: screenWidth, height: 250)
                           weakself?.backGroundScrollView.contentOffset = CGPoint.zero
                        }, completion: {(bool) in
                          
                            weakself?.timePickerVC.removeFromParentViewController()
              })
            
        }
    

    }

}
