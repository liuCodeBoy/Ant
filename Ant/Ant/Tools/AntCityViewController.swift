//
//  AntCityViewController.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/7.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

//typealias cityClouseType = (String?) -> ()

class AntCityViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

      let app = UIApplication.shared.delegate as? AppDelegate
    // 定义城市tabeleView
    lazy var  cityTableView  = UITableView()
    
    //当前城市数据源
    lazy var dataSourceArr = NSMutableArray()
    
    //索引数据源
    lazy  var indexSourceArr =  NSMutableArray()
    
    
    //定义传值闭包
    var  cityClouse : cityClouseType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        initNav()
        
        initDataSource()
        
        initTableView()
    }

    
    
    //初始化导航栏
    func initNav() {
      let bgView =  UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 64))
      bgView.backgroundColor = UIColor.init(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
      self.view.addSubview(bgView)
        
      //取消按钮
      let  closeBtn = UIButton(type: .custom)
      closeBtn.frame = CGRect.init(x: 20, y: 30, width: 20, height: 20)
      closeBtn.setImage(UIImage.init(named: "icon_nav_quxiao_normal"), for: .normal)
      closeBtn.addTarget(self, action:#selector(AntCityViewController.closeBtn), for: .touchUpInside)
      bgView.addSubview(closeBtn)
        
      //标题
        let titleLabel = UILabel(frame: CGRect.init(x: screenWidth/2 - 50, y: 30, width: 100, height: 25))
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = "选择城市"
        bgView.addSubview(titleLabel)
    }
    
    func closeBtn() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    
    //初始化数据源
    func initDataSource() -> () {
       let  plistPath =  Bundle.main.path(forResource: "city", ofType: "plist")
       let  cityArr = NSMutableArray(contentsOfFile: plistPath!)
       self.dataSourceArr = self.sortArray(originalArray: cityArr!)
    }
    
    
    //数组分组排序
    func sortArray(originalArray: NSMutableArray) -> (NSMutableArray) {
        let  array = NSMutableArray()
        //根据拼音对数组进行排序
        let  sortDescriptors = NSArray(object: NSSortDescriptor(key: "pinyin", ascending: true))
        //排序
        originalArray.sort(using: sortDescriptors as! [NSSortDescriptor])
        
        var tempArr : NSMutableArray? = nil
        var  flag : Bool = false
        
        //分组
        for i in 0..<originalArray.count {
          let pinyin = (originalArray[i] as AnyObject).object(forKey: "pinyin")
          let firstChar = (pinyin as! NSString).substring(to: 1)
            if(indexSourceArr.contains(firstChar.uppercased()) == false){
                indexSourceArr.add(firstChar.uppercased())
                tempArr = NSMutableArray.init()
                flag = false
            }
            if (indexSourceArr.contains(firstChar.uppercased())) {
                tempArr?.add(originalArray[i])
                if(flag == false){
                array.add(tempArr ?? NSMutableArray())
                flag = true
                }
            }
          
        }
       return array
    }
    
    
    
    //
    func initTableView() -> () {
        self.cityTableView = UITableView.init(frame:CGRect.init(x: 0, y: 64, width: screenWidth, height: screenHeight - 64), style: .plain)
        self.cityTableView.delegate = self
        self.cityTableView.dataSource = self
        self.cityTableView.sectionIndexColor = UIColor.init(red: 252/255.0, green: 74/255.0, blue: 132/255.0, alpha: 1.0)
        self.view.addSubview(self.cityTableView)
        
        
    }
    
    
    
    
}

  //MARK: -  tableView 代理方法
extension AntCityViewController {

    func numberOfSections(in tableView: UITableView) -> Int {
        return  self.dataSourceArr.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.dataSourceArr[section] as AnyObject).count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.indexSourceArr.object(at: section) as? String
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
         return self.indexSourceArr as? [String]
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let   cellIndentifier = "cell"
        var   cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier)
        if (cell == nil) {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIndentifier)
        }
        cell?.textLabel?.text = ((self.dataSourceArr[indexPath.section] as AnyObject).objectAt(indexPath.row) as AnyObject).object(forKey: "name") as? String
        
        return  cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        app?.theme = UIColor.purple
        let mainVC = MainViewController()
        mainVC.buttonScrollView?.removeFromSuperview()
        
        tableView.deselectRow(at: indexPath, animated: true)
        if self.cityClouse != nil {
            self.cityClouse!(((self.dataSourceArr[indexPath.section] as AnyObject).objectAt(indexPath.row) as AnyObject).object(forKey: "name") as? String)
        self.dismiss(animated: true, completion: nil)
        }
    }


}
