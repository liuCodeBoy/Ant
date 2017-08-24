//
//  ViewController.swift
//  AntProfileDemo
//
//  Created by Weslie on 2017/7/6.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit
let isLoginNotification = NSNotification.Name(rawValue:"didLogin")
 let appdelegate = UIApplication.shared.delegate as? AppDelegate
class ProfileViewController: UIViewController {
    var  modelView : UIView?
    var tableView: UITableView?
    var valueLabel : UILabel?
    var silderView : UISlider?
    var items = ["我的发布", "我的收藏", "正文字体", "个人设置"]
    var imgs = [#imageLiteral(resourceName: "profile_icon_edit"), #imageLiteral(resourceName: "profile_icon_collect"), #imageLiteral(resourceName: "profile_icon_textfont"), #imageLiteral(resourceName: "profile_icon_setting")]
    
    var isLogin: Bool = UserInfoModel.shareInstance.isLogin
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.delegate = self
        initTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

      }

    }


extension ProfileViewController {
    
    @objc func needLogin() {
        let alert = UIAlertController(title: "提示", message: "需要先登录才能进行改操作", preferredStyle: .alert)
        let notLogin = UIAlertAction(title: "暂不登陆", style: .cancel, handler: nil)
        let login = UIAlertAction(title: "立即登录", style: .default) { (_) in
            self.loadLoginViewController()
        }
        
        alert.addAction(login)
        alert.addAction(notLogin)
       
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    fileprivate func initTableView() {
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        self.tableView = UITableView(frame: frame, style: .grouped)
        self.tableView?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
        
        let avaNib = UINib(nibName: "LoginTableViewCell", bundle: nil)
        
        tableView?.register(avaNib, forCellReuseIdentifier: "login")
        
        
        self.view.addSubview(self.tableView!)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 4
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 120
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 0.000001
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            //            isLogin ? print("you have login") : loadLoginViewController()
            loadLoginViewController()
        }
        
        
        if indexPath.section == 1 && indexPath.row == 2{
              addSliderView()
            
        }
        if indexPath.section == 1 && indexPath.row != 2 {
            needLogin()
        }
    }
    

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cells: UITableViewCell?
        
        if indexPath.section == 0 && indexPath.row == 0 {
            
            cells = tableView.dequeueReusableCell(withIdentifier: "login")
            
        } else {
            var commonCell = tableView.dequeueReusableCell(withIdentifier: "header")
            
            if commonCell == nil {
                commonCell = antTableViewCell.init(style: .default, reuseIdentifier: "header")
            }
            
            switch indexPath.section {
            case 1: commonCell?.textLabel?.text = items[indexPath.row]
            commonCell?.imageView?.image = imgs[indexPath.row]
            case 2: commonCell?.textLabel?.text = "建议反馈"
            commonCell?.imageView?.image = #imageLiteral(resourceName: "profile_icon_suggest")
            default: commonCell?.textLabel?.text = ""
            }
            cells = commonCell
        }
        cells?.selectionStyle = .none
        return cells!
        
    }
    
 
    
    
    
}

  //MARK: - silder方法
extension  ProfileViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.modelView?.removeFromSuperview()
    }
    // slider变动时改变label值
    func  sliderValueChanged(sender : UISlider) {
        self.valueLabel?.text = String(format: "设置字体倍数为%.2fX", sender.value)
        
        let  alterVC = UIAlertController.init(title: "确认修改", message: "确认修改后请重启应用", preferredStyle: .alert)
        alterVC.addAction(UIAlertAction.init(title: "确认", style: .default, handler: { [weak self](action) in
            
            appdelegate?.fontSize = CGFloat(sender.value)
            self?.modelView?.removeFromSuperview()
        }))
        alterVC.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: {[weak self](action) in
            self?.modelView?.removeFromSuperview()
            
        }))
        self.present(alterVC, animated: true, completion: nil)
        
    }
    //添加Slider
    func addSliderView() {
        let modelView = UIView.init(frame: CGRect.init(x: 0, y: screenHeight * 0.3, width: screenWidth, height: 200))
        modelView.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
        self.modelView = modelView
        let silderView = UISlider.init(frame: CGRect.init(x: 20, y: 90, width: screenWidth - 40, height: 20))
        silderView.minimumValue = 1.0
        silderView.maximumValue = 1.5
        silderView.isContinuous = false
        silderView.minimumTrackTintColor = appdelgate?.theme
        silderView.setValue(Float((appdelegate?.fontSize)!),animated:true)
        //添加当前值label
        self.valueLabel = UILabel.init(frame: CGRect.init(x: (screenWidth - 200) / 2, y: silderView.frame.maxY + 10 , width: 200, height: 40))
        self.valueLabel?.textAlignment = .center
        self.valueLabel?.text = String(format: "设置字体倍数为%.2fX", silderView.value)
        self.valueLabel?.textColor = appdelgate?.theme
        self.modelView?.addSubview(self.valueLabel!)
        
        silderView.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        self.modelView?.addSubview(silderView)
        self.silderView = silderView
        UIView.animate(withDuration: 0.25, animations: {
            self.view.addSubview(self.modelView!)
        })
        
    }

}

extension ProfileViewController {
    
     fileprivate func loadLoginViewController() {
        
        let loginVC = LoginViewController()
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.pushViewController(loginVC, animated: true)
        
        
    }
}

extension ProfileViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        let isLoginVC = viewController is LoginViewController || viewController is LoginWithPwd || viewController is Register
        self.navigationController?.setNavigationBarHidden(isLoginVC, animated: true)
        if isLoginVC {
            self.tabBarController?.tabBar.isHidden = true
        }
    }
}








