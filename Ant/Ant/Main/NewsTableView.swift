//
//  NewsTableView.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/7/3.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import MJRefresh
import SDWebImage
import SVProgressHUD
//定义闭包类型
typealias  showNewsDetailType = (String?, NSURL?) -> ()
class NewsTableView: UITableView ,UITableViewDelegate, UITableViewDataSource{
    //定义跳转闭包
    var showNewsDetailClouse : showNewsDetailType?
    //定义页号p值
    var p = 1
    //定义加载的新闻分类号
    var cate_id  = 0
    var  tableView = UITableView()
    //模型数组
    lazy var  modelArray =  [NewsListModel]()
    //轮播新闻数组
    lazy var  rotaionArray = [NewsRotationModel]()
    let  imageArray = ["http://news.xinhuanet.com/photo/2017-07/07/1121277850_14993686707431n.jpg",
                       "https://imgsa.baidu.com/news/q%3D100/sign=b65364338826cffc6f2abbb289004a7d/a1ec08fa513d269758f81af75ffbb2fb4316d874.jpg",
                        "https://imgsa.baidu.com/news/q%3D100/sign=23c77afa3ea85edffc8cfa23795509d8/fd039245d688d43f18628258771ed21b0ff43b54.jpg"]
    
    //创建模型数组\
    let  cellID = "NewsOne"
    let  threeCellId = "threeCell"
    
    //天气控件
    lazy   var  weatherView  = UIView()
    
    var imageScrollView : TopScrollView?
  
    
    init(frame: CGRect, style: UITableViewStyle , cateID : Int) {
        super.init(frame: frame, style: style)
        tableView = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.separatorStyle = .none
        // 注册单图片nib
        tableView.register(UINib.init(nibName: "NewsTypeTableCell", bundle: nil), forCellReuseIdentifier: cellID)
        //注册多图片nib
        tableView.register(UINib.init(nibName:"NewsThreeImageCell", bundle: nil), forCellReuseIdentifier: threeCellId)
          SVProgressHUD.show()
        NetWorkTool.shareInstance.newsList("\(cateID)", p: "\(p)") { (newsInfo, error) in
            
            weak var weakSelf  = self
            self.cate_id = cateID
            if error == nil {
                SVProgressHUD.dismiss()
                let result = newsInfo?["result"] as? NSDictionary
                let listArr = result?["list"] as? NSArray
                for i  in 0..<listArr!.count {
                    let dict = listArr?[i] as? NSDictionary
                    
                    let  newListModel = NewsListModel.mj_object(withKeyValues: dict)
                    if(newListModel != nil){
                        weakSelf?.modelArray.append(newListModel!)
                    }
                }
             weakSelf?.tableView.separatorStyle = .singleLine
                weakSelf?.reloadData()
            }
        }
        //设置回调
        //默认下拉刷新
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(NewsTableView.refresh))
        // 马上进入刷新状态
        self.tableView.mj_header.beginRefreshing()
        //上拉刷新
        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(NewsTableView.loadMore))
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        self.tableView.mj_header.isAutomaticallyChangeAlpha = true
        //创建分页控制器
        creatPageVC(cateID: cateID)
    }
    
    func  loadMore() {
        self.p += 1
        NetWorkTool.shareInstance.newsList("\(cate_id)", p: "\(p)") { (newsInfo, error) in
            weak var weakSelf  = self
            if error == nil {
                 let result = newsInfo?["result"] as? NSDictionary
                 let listArr  = result?["list"] as? NSArray
                 let  arrayCount =  weakSelf?.modelArray.count
                for i  in 0..<listArr!.count {
                    let dict = listArr?[i] as? NSDictionary
                    let  newListModel = NewsListModel.mj_object(withKeyValues: dict)
                    if(newListModel != nil){
                        weakSelf?.modelArray.append(newListModel!)
                    }

                }
                if arrayCount ==  weakSelf?.modelArray.count{ //结束刷新
                    weakSelf?.mj_footer.endRefreshingWithNoMoreData()
                }else {
                    weakSelf?.mj_footer.endRefreshing()
                }
                //重新调用数据接口
                self.reloadData()
            }
        }
    }
    
    
    func  refresh() {
        weak var  weakself = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
            //结束刷新
            weakself?.mj_header.endRefreshing()
            //重新调用数据接口
            self.reloadData()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //创建分页控制器
    func creatPageVC(cateID : Int) -> () {
        if cateID  == 1 {
        //网路请求url
        NetWorkTool.shareInstance.rotationList { [weak self](info, error) in
            if info?["code"] as? String == "200"{
                let result  = info?["result"] as? NSArray
                for  news  in result! {
                    let rotationModel = NewsRotationModel.mj_object(withKeyValues: news)
                    self?.rotaionArray.append(rotationModel!)
                }
         
                let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 160)
                self?.imageScrollView = TopScrollView(rotaionArray : (self?.rotaionArray)!, frame: frame, isAutoScroll: true)
                self?.imageScrollView?.imageClickedHandler = { i  in
                    let  model =  self?.rotaionArray[i]
                    let number = (model?.id)!
                    let url = NSURL.init(string: (model?.url!)!)
                    if self?.showNewsDetailClouse != nil {
                        self?.showNewsDetailClouse!("\(String(describing: number))", url)
                    }
                }
                let   headerView = UIView(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 190))
                headerView.addSubview((self?.imageScrollView!)!)
                self?.weatherView = (self?.createWheather())!
                headerView.addSubview((self?.weatherView)!)
                self?.tableView.tableHeaderView = headerView
    
            }
        }
     }
    }
    
    //创建天气显示界面
    func createWheather() -> (UIView) {
          let   weatherView =   UIView(frame: CGRect.init(x: 0, y: (self.imageScrollView?.frame.maxY)!, width: screenWidth, height: 30))
          weatherView.layer.borderWidth = 1
          weatherView.layer.borderColor = UIColor.lightGray.cgColor

           // 创建日期lable
           let dateLable = UILabel()
           dateLable.frame.size = CGSize.init(width: 70, height: 15)
           dateLable.center.y  = weatherView.frame.height / 2
           dateLable.textColor = UIColor.lightGray
           dateLable.frame.origin.x = 20
  
           dateLable.font = UIFont.systemFont(ofSize: 15)
            weatherView.addSubview(dateLable)
         //创建天气图标
          let  weatherImage = UIImageView.init()
          weatherImage.frame.size = CGSize.init(width: 25, height: 25)
          weatherImage.center.y = dateLable.center.y
          weatherImage.frame.origin.x = (screenWidth / 2) - 50
         weatherView.addSubview(weatherImage)
        // 创建天气button
          let weatherBtn = UIButton()
          weatherBtn.frame.size = CGSize.init(width: 90, height: 40)
          weatherBtn.contentHorizontalAlignment = .left
          weatherBtn.center.y = dateLable.center.y
          weatherBtn.frame.origin.x = (screenWidth / 2) - 15
          weatherBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
          weatherBtn.setTitleColor(UIColor.lightGray, for: .normal)
          weatherView.addSubview(weatherBtn)
      
        
        
           // 创建温度lable
        let tempLable = UILabel()
        tempLable.frame.size = CGSize.init(width: 50, height: 15)
        tempLable.center.y  = weatherView.frame.height / 2
        tempLable.frame.origin.x = screenWidth - 60
        tempLable.font = UIFont.systemFont(ofSize: 15)
        tempLable.textColor = UIColor.lightGray
        weatherView.addSubview(tempLable)
        
        NetWorkTool.shareInstance.weather("Canberra") { (weatherInfo, error) in
         
            if error == nil {
                let result = weatherInfo?["result"] as? NSDictionary
                let  weatherModel = WeatherModel.mj_object(withKeyValues: result)
                  dateLable.text = weatherModel?.time
                  weatherBtn.setTitle(weatherModel?.txt, for: .normal)
                  weatherImage.sd_setImage(with: NSURL.init(string: (weatherModel?.code!)!)! as URL)
                
                  tempLable.text = weatherModel?.tmp
            }
        }
        
        return weatherView
    }
    
    
  
}











//MARK: - tableview  代理方法
extension  NewsTableView {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
          var  cell : UITableViewCell?
         let  model =  self.modelArray[indexPath.row]
        if (model.picture?.count)! < 3 {
        let  cellone = tableView.dequeueReusableCell(withIdentifier: cellID) as! NewsTypeTableCell
        cellone.newsSource.text = model.source
        cellone.newsTitle.text = model.title
        cellone.newsImage.sd_setImage(with: NSURL.init(string: model.picture![0] as! String)! as URL, placeholderImage: UIImage.init(named: "moren"))
        cellone.newlistModel = self.modelArray[indexPath.row]
        cell = cellone
        }else {
         let   cellThree = tableView.dequeueReusableCell(withIdentifier: threeCellId) as? NewsThreeImageCell
         cellThree?.newsTitle.text = model.title
         cellThree?.scourceText.text = model.source
         cellThree?.newsFirstImageView.sd_setImage(with: NSURL.init(string: model.picture![0] as! String)! as URL, placeholderImage: UIImage.init(named: "moren"))
          
         cellThree?.newsSecondImageView.sd_setImage(with: NSURL.init(string: model.picture![1] as! String)! as URL, placeholderImage: UIImage.init(named: "moren"))
         cellThree?.newsThridImageView.sd_setImage(with: NSURL.init(string: model.picture![2] as! String)! as URL, placeholderImage: UIImage.init(named: "moren"))
         cell = cellThree
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var  tempNum  :  CGFloat?
        let  model =  self.modelArray[indexPath.row]
        if (model.picture?.count)! < 3 {
         tempNum = 110
        }else {
            tempNum  = 150
        }
        return tempNum!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let  model =  self.modelArray[indexPath.row]
          let number = model.id!
          let url = NSURL.init(string: model.url!)
        if self.showNewsDetailClouse != nil {
            self.showNewsDetailClouse!("\(String(describing: number))", url)
        }
        
    }

}
