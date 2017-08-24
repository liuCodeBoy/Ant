//
//  JobSearchVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/1.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class JobSearchVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let recruitCellID = "LunTanListWithAvatarCell"
    let topPlistName = ["job_recruit_type","job_recruit_visa","job_recruit_nature","job_recruit_industry"]
    var category : CategoryVC?
    var categoryDetial : CategoryDetialVC?
    
    //定义顶部列表栏
    var topView: UIView?
    //导航分类箭头image
    var arrowImag : UIImageView?
    var nowButton = UIButton()
    //定义全局plist名
    var plistName : String?

    var tableView : UITableView?
    
    fileprivate lazy var modelInfo: [JobSearchStatus] = [JobSearchStatus]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCellData()
        //定义发布按钮
        creatRightBtn()
        //初始化tableview
        initTableView()
        //加载头部
        loadListView()
        //注册cell
        tableView?.register(UINib.init(nibName: "LunTanListWithAvatarCell", bundle: nil), forCellReuseIdentifier: recruitCellID)
       
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    func creatRightBtn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发布", style: .plain, target: self, action: #selector(JobSearchVC.showJobInfoVC))
        
    }
    
    func showJobInfoVC() {
        
        let giveVC = GiveOutVC()
        giveVC.title = "求职信息"
        giveVC.listTableView = JobSearchInfoView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        self.navigationController?.pushViewController(giveVC, animated: true)
    
    }
    
    func initTableView() {
        self.view.backgroundColor = UIColor.white
        self.tableView = UITableView.init(frame:CGRect.init(x: 0, y: 30, width: screenWidth, height: screenHeight - 44), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.showsVerticalScrollIndicator = false
        self.tableView?.sectionIndexColor = UIColor.init(red: 252/255.0, green: 74/255.0, blue: 132/255.0, alpha: 1.0)
        self.view.addSubview(self.tableView!)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return  140
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: recruitCellID) as! LunTanListWithAvatarCell
//        cell.viewModel = self.modelInfo[indexPath.row] as
        return cell
    }
    // tableView点击触发事件
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let wantJobDVC =  WantJobDVC()
        self.navigationController?.pushViewController(wantJobDVC, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    
}

//MARK: - TopListChoose
extension JobSearchVC {
    func loadListView() {
        self.topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        let  topListArray = ["类型" ,"签证","性质","行业"]
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
            let  btn = UIButton.init(frame:  CGRect(x: ((screenWidth - 2) / 4 ) *  CGFloat(i) , y: 0, width:  (screenWidth - 2) / 4, height: 40))
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
            let lineView1: UIView = UIView(frame: CGRect(x: arrowImag.frame.maxX + 5, y: 8, width: 1, height: 24))
            lineView1.backgroundColor = UIColor.lightGray
            self.topView?.addSubview(btn)
            self.topView?.addSubview(arrowImag)
            self.topView?.addSubview(lineView1)
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

// MARK:- Pass the data to the tableView
extension JobSearchVC {
    
    // MARK:- DispatchGroup
    
    fileprivate func loadCellData() {
        let group = DispatchGroup()
        //将当前的下载操作添加到组中
        group.enter()
        NetWorkTool.shareInstance.infoList(VCType: .job, p: 1) { [weak self](result, error)  in
            //在这里异步加载任务
            
            if error != nil {
                print(error ?? "load house info list failed")
                return
            }
            
            guard let resultDict = result!["result"] else {
                return
            }
            
            guard let resultList  = resultDict["list"] as? NSArray else {
                return
            }
            for i in 0..<resultList.count {
                let dict = resultList[i]
                let basic = JobSearchStatus(dict: dict as! [String : AnyObject])
                self?.modelInfo.append(basic)
            }
            //离开当前组
            group.leave()
            print(resultList)
            
            
        }
        group.notify(queue: DispatchQueue.main) {
            //在这里告诉调用者,下完完毕,执行下一步操作
            self.tableView?.reloadData()
            
        }
    }
    
}

