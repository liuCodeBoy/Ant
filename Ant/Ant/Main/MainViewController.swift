//
//  MainViewController.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SVProgressHUD
class MainViewController: UIViewController,UIScrollViewDelegate {
    lazy  var   addBtn = UIButton()
    
    //左边按钮
    var chooseCityBtn : UIBarButtonItem?
    
    lazy var buttonArray = [CateModel]()
    
        //= ["推荐","关注","本地","中国" ,"科技","娱乐","社会"]

    var   newTableView : NewsTableView?
    
    var   buttonScrollView : BtnScrollView?
    
    //新闻视图页面
    var  newsScrolliew :  UIScrollView?
    
    //加载个数数组
    var   pageArr  : NSMutableArray = [0]
    //left按钮title
    var  cityTitle  = "南京"
    //
    var leftNavBtn : UIButton?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置导航栏控件
         setNavItem()
        //防止scrollview的自动设置内边距
        self.automaticallyAdjustsScrollViewInsets = false
       
        //加载滑动滚动条
        NetWorkTool.shareInstance.newsCate("1") { (newsCate, error) in
            weak var weakSelf = self
            if error == nil {
                let  result  = newsCate?["result"] as? NSArray
                for dict in result! {
                 let cartModel = CateModel.mj_object(withKeyValues: dict)
                     weakSelf?.buttonArray.append((cartModel)!)
                }
                weakSelf?.buttonScrollView =  BtnScrollView.init(btnArrays: (weakSelf?.buttonArray)! as NSArray)
                weakSelf?.view.addSubview((weakSelf?.buttonScrollView!)!)
                // 添加按钮
                weakSelf?.view.addSubview((weakSelf?.addBtn)!)
                weakSelf?.addScrollView()
                // 添加按钮
                weakSelf?.creatAddBtn()
          
            }
        }
        
    }
    
    func loadResume() -> () {
        NetWorkTool.shareInstance.newsCate("1") { (newsCate, error) in
            weak var weakSelf = self
           
             weakSelf?.buttonArray.removeAll()
            if error == nil {
                let  result  = newsCate?["result"] as? NSArray
                for dict in result! {
                    let cartModel = CateModel.mj_object(withKeyValues: dict)
                    weakSelf?.buttonArray.append((cartModel)!)
                }
              for chilren in self.view.subviews {
            chilren.removeFromSuperview()
     
              }
            //加载滑动滚动条
           weakSelf?.buttonScrollView =  BtnScrollView.init(btnArrays: self.buttonArray as NSArray)
           weakSelf?.view.addSubview(self.buttonScrollView!)
           weakSelf?.pageArr.removeAllObjects()
           weakSelf?.pageArr = [0]
           weakSelf?.addScrollView()
           // 添加按钮
          weakSelf?.view.addSubview((weakSelf?.addBtn)!)
          weakSelf?.newTableView?.reloadData()
            }
        }
    }
    
    
    func addScrollView() -> () {
        let newsScrolliew = UIScrollView.init(frame: CGRect.init(x: 0, y: 35, width: screenWidth , height: screenHeight - 143))
        newsScrolliew.isPagingEnabled = true
        newsScrolliew.bounces = false
        newsScrolliew.contentSize = CGSize.init(width: screenWidth * CGFloat((buttonArray.count)), height: screenHeight - 143)
        newsScrolliew.backgroundColor = UIColor.white
        newsScrolliew.showsVerticalScrollIndicator = false
        newsScrolliew.showsHorizontalScrollIndicator = false
        newsScrolliew.delegate = self
        self.newsScrolliew = newsScrolliew
        self.view.addSubview(self.newsScrolliew!)
       
        
        self.newTableView = NewsTableView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight - 143), style: .plain,cateID: 1)
         self.newTableView?.showNewsDetailClouse = {(newId , url) in

            let  newsDetailVCViewController = NewsDetailVCViewController()
            newsDetailVCViewController.newsID = newId!
            newsDetailVCViewController.url = url
            newsDetailVCViewController.title = "新闻详情"
            self.navigationController?.pushViewController(newsDetailVCViewController, animated: true)
        }
        self.newsScrolliew?.addSubview(self.newTableView!)
        
      
        //通过闭包添加新闻tableview
        self.buttonScrollView?.chageClosure = {[weak self](num) in
            //   默认已经加载了一号页面
            if self?.pageArr.contains(num!) == false {
                self?.pageArr.add(num!)
                let  tempTableView = NewsTableView.init(frame: CGRect.init(x:  CGFloat(num!) * screenWidth , y: 0, width: screenWidth, height:  screenHeight - 143), style: .plain, cateID: num! + 1)
                
                //添加传值闭包
                //新闻评论详情闭包
                tempTableView.showNewsDetailClouse = {(newId,url) in
                    let  newsDetailVCViewController = NewsDetailVCViewController()
                    newsDetailVCViewController.newsID = newId!
                    newsDetailVCViewController.url = url
                    newsDetailVCViewController.title = "新闻详情"
                    self?.navigationController?.pushViewController(newsDetailVCViewController, animated: true)
                }
                self?.newsScrolliew?.addSubview(tempTableView)
                
            }else{
            }
        }
        
        //通过闭包通知滑动
        self.buttonScrollView?.changeOffClosure = {(offSetNum) in
            //对滑动视图进行偏移
            UIView.animate(withDuration: 0.5, animations: {
                newsScrolliew.contentOffset = CGPoint.init(x: CGFloat(offSetNum!) * screenWidth, y: 0)
            })
            
        }
    }
    

    override func  viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        
    }
    

     // 添加按钮
    func creatAddBtn() -> (){
        self.addBtn.setTitle("+", for: .normal)
        self.addBtn.setTitleColor(UIColor.lightGray, for: .normal)
        self.addBtn.backgroundColor = UIColor.white
        self.addBtn.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        self.addBtn.frame =  CGRect.init(x: UIScreen.main.bounds.width - 45, y: (buttonScrollView?.frame.origin.y)!, width:45, height: 35)
    }
    
    func setNavItem() -> () {
        //左按钮搜索
        let leftBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        leftBtn.contentHorizontalAlignment = .left
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        leftBtn.setTitle( cityTitle, for: .normal)
        leftBtn.setImage(UIImage.init(named: "nav_icon_location"), for: .normal)
        leftBtn.addTarget(self, action: #selector(getter: UIDynamicBehavior.action), for: .touchUpInside)
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        self.leftNavBtn = leftBtn
        self.chooseCityBtn = UIBarButtonItem.init(customView: self.leftNavBtn!)
        self.navigationItem.leftBarButtonItem = self.chooseCityBtn
        // 右按钮
        let rightBtn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 100, height: 50))
        rightBtn.contentHorizontalAlignment = .right
        rightBtn.setImage(UIImage.init(named: "nav_icon_xiala"), for: .normal)
        rightBtn.addTarget(self, action: #selector(showRightBtn), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
    }
    
    
    func  action(){
      //弹出城市选择控制器
        let   cityPicktrueVC = ChoseCityVC()
        cityPicktrueVC.cityClouse = {(cityString) in
            self.loadResume()
             self.cityTitle = cityString!
            self.leftNavBtn?.setTitle(cityString!, for: .normal)

                }
        self.present(cityPicktrueVC, animated: true, completion: nil)
    }
    
    func showRightBtn(){
       
        let rightAlterVC = UIAlertController.init(title: "请问你需要发布还是搜索", message: nil, preferredStyle: .actionSheet)
        rightAlterVC.addAction(UIAlertAction.init(title: "搜索", style: .default, handler: { [weak self] (action) in
            let searchVC =  SearchViewController()
            self?.navigationController?.pushViewController(searchVC, animated: true)
        }))
        rightAlterVC.addAction(UIAlertAction.init(title: "发布消息", style: .default, handler: {[weak self] (acrion) in
            let  giveVC = GiveOutVC()
            giveVC.listTableView = HouseRentTabView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
            self?.navigationController?.pushViewController(giveVC, animated: true)
        }))
        rightAlterVC.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: nil))
    
      self.present(rightAlterVC, animated: true, completion: nil)
    }
    
    

}


//newsScrolliew
extension MainViewController {

    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / screenWidth)
         let btn  =  self.buttonScrollView?.viewWithTag(page + 1000)  as? UIButton
          self.buttonScrollView?.btnClick(btn: btn!)

    }
    
   

}



