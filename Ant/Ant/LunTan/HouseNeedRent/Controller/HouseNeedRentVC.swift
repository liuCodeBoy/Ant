//
//  HuseNeedRentVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/20.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import MJRefresh
class HouseNeedRentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let houseNeedRentCellID = "LunTanListWithAvatarCell"
       let topPlistName = ["job_recruit_type","job_recruit_visa","house_rent_create_time","job_recruit_nature"]
    var category : CategoryVC?
    var categoryDetial : CategoryDetialVC?
    
    //定义顶部列表栏
    fileprivate var topView: UIView?
    //导航分类箭头image
    fileprivate var arrowImag  : UIImageView?
    fileprivate lazy var nowButton = UIButton()
    //定义全局plist名
    var plistName : String?

    var tableView : UITableView?
    //定义当前页数
    var page  = 1
    //定义当前的page总页数
    var  pages  = 1
    fileprivate lazy var modelInfo: [LunTanDetialModel] = [LunTanDetialModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        loadCellData(page: page)
        // 定义发布按钮
        creatRightBtn()
        //加载头部
        loadListView()

       //注册cell
        tableView?.register(UINib.init(nibName: "LunTanListWithAvatarCell", bundle: nil), forCellReuseIdentifier: houseNeedRentCellID)
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 100
       
     
    }

    
    func initTableView() -> () {
        self.view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
        self.tableView = UITableView.init(frame:CGRect.init(x: 0, y: 40, width: screenWidth, height: screenHeight - 44), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.sectionIndexColor = UIColor.init(red: 252/255.0, green: 74/255.0, blue: 132/255.0, alpha: 1.0)
        self.tableView?.showsVerticalScrollIndicator = false

        self.view.addSubview(self.tableView!)
        //设置回调
        //默认下拉刷新
        tableView?.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction:#selector(HouseRentListVC.refresh))
        // 马上进入刷新状态
        self.tableView?.mj_header.beginRefreshing()
        //上拉刷新
        tableView?.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(HouseRentListVC.loadMore))
    }
    
    
    //MARK: -  refresh
    func  loadMore() {
        self.loadCellData(page: self.page)
    }
    
    
    func  refresh() {
        weak var  weakself = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            //结束刷新
            weakself?.tableView?.mj_header.endRefreshing()
            //重新调用数据接口
            weakself?.tableView?.reloadData()
        })
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: houseNeedRentCellID) as! LunTanListWithAvatarCell
        cell.viewModel = modelInfo[indexPath.row]
        //头像点击事件
        cell.avatarClick = {
            self.present(UIStoryboard.init(name: "Others", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
        }
        return cell
    }
    // tableView点击触发事件
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  model = self.modelInfo[indexPath.row]
        let rentNeedVC =  RentNeedDVC()
        rentNeedVC.rentNeedID = Int(model.id!)
        rentNeedVC.modelInfo = model
        self.navigationController?.pushViewController(rentNeedVC, animated: true)

    }    
  


}

//MARK: -房屋求租发布
extension HouseNeedRentVC{

    
    func creatRightBtn(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发布", style: .plain, target: self, action: #selector(showHouseRent))
        
    }
    
    func showHouseRent(){
        let  giveVC = GiveOutVC()
        giveVC.title = "房屋求租"
        let listTableview = HouseRentTabView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight), style: .grouped)
        giveVC.listTableView = listTableview
        
        listTableview.pushModifyVCClouse = {[weak self](text , index) in
            //获取当前故事版
            let storyBoard = UIStoryboard(name: "SelfProfile", bundle: nil)
            let  dest  = storyBoard.instantiateViewController(withIdentifier: "modify") as? SelfDetialViewController
            dest?.info = text!
            self?.navigationController?.pushViewController(dest!, animated: true)
            giveVC.cateDict = listTableview.houseRentDic
            dest?.changeClosure = {(changeText) in
                listTableview.changeTableData(indexPath: index, text: changeText!)
                giveVC.cateDict = listTableview.houseRentDic
                listTableview.reloadData()
            }
        }
        listTableview.pushChooseVCClouse = {[weak self](strArr , index) in
            let choseVC = ChoseTableView()
            //初始化闭包
            choseVC.choseBtnClouse = {(name) in
                listTableview.changeTableData(indexPath: index, text: name!)
                giveVC.cateDict = listTableview.houseRentDic
                listTableview.reloadData()
            }
            choseVC.resourceArr = strArr as! NSMutableArray
            self?.navigationController?.pushViewController(choseVC, animated: true)
        }
        self.navigationController?.pushViewController(giveVC, animated: true)
        
    }

}





//MARK: - TopListChoose
extension HouseNeedRentVC {
    
    fileprivate func loadListView() {
        self.topView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        let  topListArray = ["区域" ,"类型","排序时间","租金"]
        addTopButton(topListArrays: topListArray as NSArray ,topPlistName : topPlistName as NSArray)
        self.view.addSubview(self.topView!)
    }
    
    // MARK:- add cascade list view
    @objc fileprivate func addCascadeList(nowTopListBtn : UIButton ) {
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
                // 马上进入刷新状态
                self?.tableView?.mj_header.beginRefreshing()
                self?.refresh()
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
                // 马上进入刷新状态
                self?.tableView?.mj_header.beginRefreshing()
                self?.refresh()
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
            if categoryDetial?.subcategories?.count == 0 {
                self.categoryDetial?.view.isHidden = true
            }else {
                self.categoryDetial?.view.isHidden = false
            }
            
            self.nowButton.isSelected  = !self.nowButton.isSelected
        }
    }
    
    //添加小三角
    fileprivate func addTopButton(topListArrays : NSArray, topPlistName : NSArray) {
        
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
    
    //小三角旋转动画
    fileprivate func loadRotationImg(sender: UIImageView) {
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
extension HouseNeedRentVC {
    
    // MARK:- DispatchGroup
    fileprivate func loadCellData(page : Int) {
        if   self.page != self.pages {
            self.page += 1
        }
        let group = DispatchGroup()
        //将当前的下载操作添加到组中
        group.enter()
        NetWorkTool.shareInstance.infoList(VCType: .seek, cate_2 : "", cate_3 : "", cate_4 : "", p: page) { [weak self](result, error)  in
            //在这里异步加载任务
            
            if error != nil {
                print(error ?? "load house info list failed")
                return
            }
            
            guard let resultDict = result!["result"] else {
                return
            }
            
            guard let resultList  = resultDict["list"]   as? NSArray else {
                return
            }
            guard let pages  = resultDict["pages"]   as? Int else {
                return
                
            }
            self?.pages = pages
            for i in 0..<resultList.count {
                let dict = resultList[i]
                let basic = LunTanDetialModel.init(dict: dict as! [String : AnyObject])
          
                self?.modelInfo.append(basic)
            }
            if   self?.page == self?.pages {
                self?.tableView?.mj_footer.endRefreshingWithNoMoreData()
            }else {
                self?.tableView?.mj_footer.endRefreshing()
            }

            //离开当前组
            group.leave()
            
            
        }
        group.notify(queue: DispatchQueue.main) {
            //在这里告诉调用者,下完完毕,执行下一步操作
            self.tableView?.reloadData()
            
        }
    }
    
}
