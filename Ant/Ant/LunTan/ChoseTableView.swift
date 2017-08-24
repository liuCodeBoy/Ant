//
//  ChoseTableView.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/11.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

//选择类型穿值闭包类型
typealias chooseBtnType  = (String?) -> Void

class ChoseTableView: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let dequeueCell = "ChoseTableView"
    
    //定义闭包
    var  choseBtnClouse : chooseBtnType?
    
    var  resourceArr =  NSMutableArray()
    var  tableView : UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()

    }

   
    
    func initTableView() -> () {
        self.tableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight - 44), style: .plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.sectionIndexColor = UIColor.init(red: 252/255.0, green: 74/255.0, blue: 132/255.0, alpha: 1.0)
        self.view.addSubview(self.tableView!)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resourceArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        var cells: UITableViewCell?
   
            cells = tableView.dequeueReusableCell(withIdentifier: dequeueCell)
 
            if cells == nil {
                cells = UITableViewCell.init(style: .default, reuseIdentifier: dequeueCell)
            }
        cells?.textLabel?.text = self.resourceArr[indexPath.row] as? String
        cells?.textLabel?.textColor = UIColor.lightGray
        return cells!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let  btnName = self.resourceArr[indexPath.row] as? String
        if self.choseBtnClouse != nil {
           self.choseBtnClouse!(btnName)
        }
        self.navigationController?.popViewController(animated: true)
        
    }

}
