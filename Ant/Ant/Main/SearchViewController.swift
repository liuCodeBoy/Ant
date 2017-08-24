//
//  SearchViewController.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/24.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    //搜索控件
    var searchBar : UISearchBar?
    //取消按钮
    var cancelBtn : UIButton?
    //lineView
    var lineView : UIView?
    
    var tempY : CGFloat =  0
    override func viewDidLoad() {
        super.viewDidLoad()
     //布局子控件
        let searchTopView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 70))
        searchTopView.backgroundColor = UIColor.red
        self.view.addSubview(searchTopView)

        //添加搜索框
        let  searchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 20, width: screenWidth - 50, height:60))
        searchBar.backgroundImage = UIImage.init()
        searchBar.barTintColor = UIColor.red
        searchBar.placeholder = "请输入关键词"
        self.searchBar = searchBar
        searchTopView.addSubview(searchBar)
        
        // 添加取消按钮
        let  cancelBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 50))
        cancelBtn.frame.origin.x = searchBar.frame.maxX
        cancelBtn.frame.origin.y = searchBar.frame.origin.y + 5
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.addTarget(self, action:#selector(SearchViewController.dismissVC), for: .touchUpInside)
        cancelBtn.setTitleColor(UIColor.white, for: .normal)
        self.cancelBtn = cancelBtn
        searchTopView.addSubview(cancelBtn)
        
        //热门搜索
        let searchlabel = UILabel.init(frame: CGRect.init(x: 15, y: 80, width: 100, height: 50))
        searchlabel.textAlignment = .left
        searchlabel.text  = "热门搜索"
        self.view.addSubview(searchlabel)
        
        //分界线
        let lineView = UIView.init(frame: CGRect.init(x: 15, y: searchlabel.frame.maxY , width: screenWidth - 30 , height: 1))
        lineView.backgroundColor = UIColor.lightGray
        self.lineView = lineView
        self.view.addSubview(lineView)
        
        
        //创建image分组
        let mainImage = UIImage.init(named: "tabbar_icon_home_pre")
      
        let mainImageView = UIImageView.init(image:mainImage)
        mainImageView.frame = CGRect.init(x: 15, y: lineView.frame.maxY + 5, width: 35, height: 35)
        mainImageView.image?.withRenderingMode(.alwaysOriginal)
        mainImageView.contentMode = .scaleAspectFill
        self.view.addSubview(mainImageView)
        let  mainArray = ["科技","娱乐","社会"]
        self.tempY = (self.lineView?.frame.maxY)!
        addBtnFuction(btnTempArray: mainArray as NSArray, tempY:  self.tempY)
       //创建luntan分组
        let  luntanArray = ["租房","找房","找工作","科技","交友","二手市场"]
        let luntanImageView = UIImageView.init(image: UIImage.init(named: "tabbar_icon_luntan"))
        luntanImageView.frame = CGRect.init(x: 15, y: self.tempY  + 10, width: 35, height: 35)
        self.view.addSubview(luntanImageView)
        addBtnFuction(btnTempArray: luntanArray as NSArray, tempY:  self.tempY + 10)
        
        self.view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        //创建组分割段
        let seperatedView =  UIView.init(frame: CGRect.init(x: 0, y: tempY + 10, width: screenWidth, height: 10))
        seperatedView.backgroundColor = UIColor.init(red: 239/255, green: 244/255, blue: 247/255, alpha: 1.0)
        self.tempY += 20
        self.view.addSubview(seperatedView)
        
        
        //添加历史记录栏
        let historylabel = UILabel.init(frame: CGRect.init(x: 15, y: self.tempY + 10, width: 100, height: 40))
        historylabel.textAlignment = .left
        historylabel.text  = "历史记录"
        historylabel.textColor = UIColor.black
        self.view.addSubview(historylabel)
        //定义清除按钮
        let clearBtn = UIButton.init(frame: CGRect.init(x: screenWidth - 35, y: self.tempY + 15, width: 35, height: 25))
        clearBtn.setTitle("清除", for: .normal)
        clearBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        clearBtn.addTarget(self, action: #selector(cLearHistory), for: .touchUpInside)
        clearBtn.titleLabel?.textAlignment = .left
        clearBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.view.addSubview(clearBtn)
        self.tempY += 50
        
        
        //分界线
        let historyLine = UIView.init(frame: CGRect.init(x: 15, y: historylabel.frame.maxY , width: screenWidth - 30 , height: 1))
        historyLine.backgroundColor = UIColor.lightGray
        self.view.addSubview(historyLine)
        
        //创建历史btnArray
        let historyArr = ["找房"]
        addBtnFuction(btnTempArray: historyArr as NSArray, tempY: self.tempY + 5)
        

       
    }

    //添加button方法
    func addBtnFuction(btnTempArray : NSArray, tempY : CGFloat) -> () {
        for i in 0..<btnTempArray.count{
            let  col =  i % 4
            let  row = (i) / 4
            let btn = UIButton.init(frame: CGRect.init(x: 70 + CGFloat(70 * col), y: (CGFloat(row * (25 + 10)) + tempY + 8 ), width: 60, height: 25))
            btn.setTitle(btnTempArray[i] as? String, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
            btn.layer.cornerRadius =  5
            btn.layer.masksToBounds = true
            if i == btnTempArray.count - 1{
            self.tempY = btn.frame.maxY
            }
            self.view.addSubview(btn)
            
        }

    }
    
    //点击推出控制器
    func dismissVC() -> () {
        self.navigationController?.popViewController(animated: true)
    }
    
    //清除历史记录
    func cLearHistory(){
      print("删除历史记录")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
   

}
