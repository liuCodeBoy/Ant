//
//  CarSaleVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//


import UIKit

class CarSaleVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let listViewCell = "LunTanListWithLocationCell"
    let topPlistName = ["job_recruit_type","job_recruit_visa","job_recruit_nature"]
    var category : CategoryVC?
    var categoryDetial : CategoryDetialVC?
    
    //定义顶部列表栏
    var topView: UIView?
    //导航分类箭头image
    var   arrowImag  : UIImageView?
    var nowButton = UIButton()
    //定义全局plist名
    var  plistName : String?
    var  tableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        //定义发布按钮
        creatRightBtn()
        //加载头部
        loadListView()
        //注册cell
        tableView?.register(UINib.init(nibName: "LunTanListWithLocationCell", bundle: nil), forCellReuseIdentifier: listViewCell)
        
        
    }
    
    
    
    func creatRightBtn() -> () {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发布", style: .plain, target: self, action: #selector(JobSearchVC.showJobInfoVC))
        
    }
    
    
    func showJobInfoVC() -> () {
        let  giveVC = GiveOutVC()
        giveVC.title = "汽车买卖"
        giveVC.listTableView = JobSearchInfoView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        self.navigationController?.pushViewController(giveVC, animated: true)
        
    }

    func initTableView() -> () {
        self.view.backgroundColor = UIColor.white
        self.tableView = UITableView.init(frame:CGRect.init(x: 0, y: 30, width: screenWidth, height: screenHeight - 44), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.sectionIndexColor = UIColor.init(red: 252/255.0, green: 74/255.0, blue: 132/255.0, alpha: 1.0)
        self.view.addSubview(self.tableView!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  110
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let  cell = tableView.dequeueReusableCell(withIdentifier: listViewCell)
        return cell!
    }
//    CarBusinessDVC
    // tableView点击触发事件
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let carBusinessDVC =  CarBusinessDVC()
        self.navigationController?.pushViewController(carBusinessDVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK: - TopListChoose
extension  CarSaleVC {
    func loadListView() {
        self.topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let  topListArray = ["品牌" ,"来源","交易方式"]
        addTopButton(topListArrays: topListArray as NSArray ,topPlistName : topPlistName as NSArray)
        self.view.addSubview(self.topView!)
    }
    
    func addCascadeList(nowTopListBtn : UIButton ) {
        self.nowButton =  nowTopListBtn
        let  btnImageView = self.topView?.viewWithTag( nowTopListBtn.tag - 100)
        //执行旋转动画
        self.loadRotationImg(sender: btnImageView as! UIImageView)
        //取出button展现的plist
        if self.nowButton.isSelected == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.category?.tableView.removeFromSuperview()
                self.categoryDetial?.tableView.removeFromSuperview()
                self.categoryDetial?.view.removeFromSuperview()
                self.category?.view.removeFromSuperview()
                self.category?.removeFromParentViewController()
                self.categoryDetial?.removeFromParentViewController()
            }, completion: { (_) in
            })
            self.nowButton.isSelected  = !self.nowButton.isSelected
        } else {
            self.category?.tableView.removeFromSuperview()
            self.categoryDetial?.tableView.removeFromSuperview()
            self.categoryDetial?.view.removeFromSuperview()
            self.category?.view.removeFromSuperview()
            self.category?.removeFromParentViewController()
            self.categoryDetial?.removeFromParentViewController()
            
            let tempcategory = CategoryVC()
            tempcategory.plistName =  topPlistName[nowTopListBtn.tag - 200]
            tempcategory.view.frame.origin = CGPoint.init(x: 0, y: 30)
            let  tempcategoryDetial = CategoryDetialVC()
            tempcategoryDetial.view.frame.origin = CGPoint.init(x: 0, y: 30)
            
            self.category =  tempcategory
            self.categoryDetial = tempcategoryDetial
            category?.categoryDelegate = categoryDetial
            //闭包传值
            category?.selectClosure = {[weak self](item) in
                self?.nowButton.setTitleColor(UIColor.red, for: .normal)
                self?.nowButton.setTitle(item, for: .normal)
                let  btnImageView = self?.topView?.viewWithTag( nowTopListBtn.tag - 100)
                self?.loadRotationImg(sender: btnImageView as! UIImageView)
                self?.nowButton.isSelected = false
                self?.category?.tableView.removeFromSuperview()
                self?.categoryDetial?.tableView.removeFromSuperview()
                self?.categoryDetial?.view.removeFromSuperview()
                self?.category?.view.removeFromSuperview()
                self?.category?.removeFromParentViewController()
                self?.categoryDetial?.removeFromParentViewController()
            }
            addChildViewController(category!)
            addChildViewController(categoryDetial!)
            categoryDetial?.view.frame.origin = CGPoint.init(x: width * 0.4, y: 30)
            //闭包传值
            categoryDetial?.selectClosure = {[weak self](item) in
                self?.nowButton.setTitle(item, for: .normal)
                self?.nowButton.setTitleColor(UIColor.red, for: .normal)

                let  btnImageView = self?.topView?.viewWithTag( nowTopListBtn.tag - 100)
                self?.loadRotationImg(sender: btnImageView as! UIImageView)
                self?.nowButton.isSelected = false
                self?.category?.tableView.removeFromSuperview()
                self?.categoryDetial?.tableView.removeFromSuperview()
                self?.categoryDetial?.view.removeFromSuperview()
                self?.category?.view.removeFromSuperview()
                self?.category?.removeFromParentViewController()
                self?.categoryDetial?.removeFromParentViewController()
            }
            self.view.addSubview((category?.view)!)
            self.view.addSubview((categoryDetial?.view)!)
            self.nowButton.isSelected  = !self.nowButton.isSelected
        }
    }
    
    func addTopButton(topListArrays : NSArray, topPlistName : NSArray) {
        
        for i in 0..<topListArrays.count {
            let  btn = UIButton.init(frame:  CGRect(x: ((screenWidth - 2) / CGFloat(topListArrays.count) ) *  CGFloat(i) , y: 0, width:  (screenWidth - 2) / CGFloat(topListArrays.count) , height: 40))
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitle(topListArrays[i] as? String, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.addTarget(self, action: #selector(addCascadeList(nowTopListBtn:)), for: .touchUpInside)
            btn.tag = i + 200
            //定义尖头image
            let arrowImag =  UIImageView.init(frame: CGRect.init(x: btn.frame.maxX - 15, y: 15, width: 9, height: 4.5))
            arrowImag.image = #imageLiteral(resourceName: "triangle")
            self.arrowImag = arrowImag
            arrowImag.tag = i + 100
            if i != topListArrays.count - 1 {
            let lineView1: UIView = UIView(frame: CGRect(x: arrowImag.frame.maxX + 5, y: 8, width: 1, height: 24))
            lineView1.backgroundColor = UIColor.lightGray
                self.topView?.addSubview(lineView1)
            }
            self.topView?.addSubview(btn)
            self.topView?.addSubview(arrowImag)
           
        }
        
    }
    
    
    func loadRotationImg(sender: UIImageView) {
        // 1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2.设置动画的属性
        if self.nowButton.isSelected  == false {
            rotationAnim.fromValue = 0
            rotationAnim.toValue = Double.pi
        } else {
            rotationAnim.fromValue = Double.pi
            rotationAnim.toValue = 0
        }
        rotationAnim.duration = 0.2
        rotationAnim.isRemovedOnCompletion = false
        rotationAnim.fillMode = kCAFillModeForwards
        
        // 3.将动画添加到layer中
        sender.layer.add(rotationAnim, forKey: nil)
    }
}



