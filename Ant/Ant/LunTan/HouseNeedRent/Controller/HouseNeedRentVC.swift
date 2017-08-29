//
//  HuseNeedRentVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/20.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class HouseNeedRentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let houseNeedRentCellID = "LunTanListWithAvatarCell"
    
    var tableView : UITableView?
    
    fileprivate lazy var modelInfo: [HouseRentStatus] = [HouseRentStatus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
        loadCellData()
       //注册cell
        tableView?.register(UINib.init(nibName: "LunTanListWithAvatarCell", bundle: nil), forCellReuseIdentifier: houseNeedRentCellID)
        
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 100
       
     
    }

    
    func initTableView() -> () {
        self.view.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
        self.tableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight - 44), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.sectionIndexColor = UIColor.init(red: 252/255.0, green: 74/255.0, blue: 132/255.0, alpha: 1.0)
        self.view.addSubview(self.tableView!)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: houseNeedRentCellID) as! LunTanListWithAvatarCell
        cell.viewModel = modelInfo[indexPath.row]
        return cell
    }
    // tableView点击触发事件
    func  tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rentNeedVC =  RentNeedDVC()
        self.navigationController?.pushViewController(rentNeedVC, animated: true)
          }
    
  


}

// MARK:- Pass the data to the tableView
extension HouseNeedRentVC {
    
    // MARK:- DispatchGroup
    
    fileprivate func loadCellData() {
        let group = DispatchGroup()
        //将当前的下载操作添加到组中
        group.enter()
        NetWorkTool.shareInstance.infoList(VCType: .house, p: 1) { [weak self](result, error)  in
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
            for i in 0..<resultList.count - 1 {
                let dict = resultList[i]
                let basic = HouseRentStatus.mj_object(withKeyValues: dict)
                self?.modelInfo.append(basic!)
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
