//
//  LunTanViewController.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class LunTanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let  lunTanCellID = "LunTanTopViewCell"
    var fistArr : NSMutableArray?
    var  secondeArr : NSMutableArray?

    func createModel() {
        let model1  =  lunTanModel()
        model1.name = "房屋出租"
        model1.image = "luntan_function_icon_houserent"
        let model2  = lunTanModel()
        model2.name = "房屋求租"
        model2.image = "luntan_function_icon_searchhouse"
        let model3  = lunTanModel()
        model3.name = "求职招聘"
        model3.image = "luntan_function_icon_findjob"
        let model4  = lunTanModel()
        model4.name = "汽车买卖"
        model4.image = "luntan_function_icon_carservice"
        let model5  = lunTanModel()
        model5.name = "二手市场"
        model5.image = "luntan_function_icon_secondhandmarket"
        let model6  = lunTanModel()
        model6.name = "同城交友"
        model6.image = "luntan_function_icon_makefriend"
        
        self.fistArr = [model1,model2,model3,model4,model5,model6]
        self.secondeArr = [model3,model4,model5,model6]
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
          createModel()
        let  tableView =   UITableView.init(frame: CGRect.init(x: 0, y:0, width: screenWidth , height: screenHeight - 108))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.navigationBar.isTranslucent = false
        
        //注册nib
        
          tableView.register(UINib.init(nibName: "LunTanTopViewCell", bundle: nil), forCellReuseIdentifier: lunTanCellID)
        
        
         self.view.addSubview(tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
    }
    

    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
      return 10
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       var height = 0
        if indexPath.section == 0 {
            height =  Int(lunTanModel.getmodelHeight(btnCount: (self.fistArr?.count)!))
        }else {
            height =  Int(lunTanModel.getmodelHeight(btnCount: (self.secondeArr?.count)!))
            
        }
        
        return CGFloat(height)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: lunTanCellID) as? LunTanTopViewCell
        if indexPath.section == 0 {
           cell?.searchTextField.isHidden = false
            cell?.headerView?.isHidden = true
            cell?.tempArr = self.fistArr
             cell?.addSubBtns()
            
        }else {
           cell?.headerView?.isHidden = false
           cell?.searchTextField.isHidden = true
            cell?.tempArr = self.secondeArr
            cell?.addSubBtns()
        }
        cell?.showVCClouse = {(VC) in
            
            self.navigationController?.show(VC, sender: nil)
            self.navigationController?.navigationBar.isTranslucent = false
        }
      
        return cell!
    }
    
    
}
