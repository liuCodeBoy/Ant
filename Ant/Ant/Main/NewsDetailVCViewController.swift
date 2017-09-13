//
//  NewsDetailVCViewController.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/19.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import WebKit
import SDWebImage
import SVProgressHUD
class NewsDetailVCViewController: UIViewController,UITableViewDelegate, UITableViewDataSource, WKUIDelegate, WKNavigationDelegate,UITextFieldDelegate{
    let NewsTopTitleCell = "NewsTopTitleCell"
    let newsDetailSharedCell =  "newsDetailSharedCell"
    let hotCommandCell = "hotCommandCell"
    let  hotNewsCell = "hotNewsCell"
    lazy var tableView = UITableView()
    lazy var scrollView = UIScrollView()
    lazy var webView = WKWebView()
    var webViewHeight : CGFloat = 0
    var  textField  : UITextField?
    var detailView  : UIView?
    var collectionBtn : UIButton?
    var modelView  : UIView?
    var  valueLabel : UILabel?
    var  silderView : UISlider?
    var webFont = 100
    //新闻url 
    var  url : NSURL?
    //接受新闻id值
    var  newsID =  ""
    //newsmodel
    var newsModel : NewsDetailModel?
    //commentModel
    var commentModelArr = [NewsComment]()
    //hot_newsModel
    lazy var hot_newsModelArr = [NewsHotModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
         loadNewsDetail()
         createTableView()
        //初始化底部发布视图
        creatBottomView()
         //注册cell
        self.tableView.register(UINib.init(nibName: "NewsDetailSharedCell", bundle: nil), forCellReuseIdentifier: newsDetailSharedCell)
        self.tableView.register(UINib.init(nibName: "NewsHotCommondCell", bundle: nil), forCellReuseIdentifier: hotCommandCell)
        self.tableView.register(UINib.init(nibName: "HotNewsCell", bundle: nil), forCellReuseIdentifier: hotNewsCell)
        self.tableView.register(UINib.init(nibName: "NewsTopTitleCell", bundle: nil), forCellReuseIdentifier: NewsTopTitleCell)
        //注册微评论cell
        self.tableView.register(UINib.init(nibName: "NoCommandCell", bundle: nil), forCellReuseIdentifier: "NoCommandCell")
        //接受键盘输入通知
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(notific:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
         //接受键盘收回通知
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHidden(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
     
    }
    
    //请求新闻信息
    func  loadNewsDetail(){
       NetWorkTool.shareInstance.newsDet(self.newsID, finished: { (newsInfo, error) in
        if newsInfo?["code"] as? String == "200"{
           let result  = newsInfo?["result"] as? NSDictionary

           let newsDetail = result?["news_info"] as? NSDictionary
           let commentArray =  result?["comment"] as? NSArray
           let hot_newsArray =  result?["hot_news"] as? NSArray
           //创建newsDetail模型
            let newsDetailModel = NewsDetailModel.mj_object(withKeyValues: newsDetail)
            self.newsModel = newsDetailModel
           //创建comment模型
            for commentModel  in commentArray!{
                let commentModel = NewsComment.mj_object(withKeyValues: commentModel)
                self.commentModelArr.append(commentModel!)
            }
           //创建hot_news模型
            for hotModel  in hot_newsArray!{
                let hot_newsModel = NewsHotModel.mj_object(withKeyValues: hotModel)
                self.hot_newsModelArr.append(hot_newsModel!)
   
            }
            
            self.tableView.reloadData()
         }
       
       })
    }
    
 

    func collectionFunc(){
       self.collectionBtn?.isSelected  =  !((self.collectionBtn?.isSelected)!)
    }
    
    
    
    func createTableView() -> () {
        self.webViewHeight = 0.0;
        self.createWebView();
        self.tableView = UITableView.init(frame:CGRect.init(x: 0, y: 0, width: screenWidth, height: screenHeight - 44), style: .grouped)
    
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.showsVerticalScrollIndicator = false;
        self.tableView.showsHorizontalScrollIndicator = false;
        self.tableView.separatorStyle = .none
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "WebViewCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        self.view.addSubview(self.tableView)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    deinit {
        self.webView.scrollView.removeObserver(self, forKeyPath: "contentSize")
         NotificationCenter.default.removeObserver(self)
    }
 
   func createWebView()
    {
     let wkWebConfig = WKWebViewConfiguration()
     let wkUController = WKUserContentController()
     wkWebConfig.userContentController = wkUController
      
    
    // 自适应屏幕宽度js
    let jSString = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
     let wkUserScript = WKUserScript.init(source: jSString, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    // 添加js调用
     wkUController.addUserScript(wkUserScript)
    self.webView = WKWebView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 1), configuration: wkWebConfig)
    self.webView.backgroundColor = UIColor.clear
    self.webView.isOpaque = false;
    self.webView.isUserInteractionEnabled = false;
    self.webView.scrollView.bounces = false;
    self.webView.uiDelegate = self;
    self.webView.navigationDelegate = self;
//    self.webView.sizeToFit()
    self.webView.scrollView .addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    let  urlRequest = NSURLRequest(url: self.url! as URL)
    self.webView.load(urlRequest as URLRequest)
    self.scrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth , height: 1))
    self.scrollView.addSubview(self.webView)
    }
    

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context:
        UnsafeMutableRawPointer?) {
        
      self.webView.evaluateJavaScript("document.body.clientHeight") { (anyreult, error) in
        if (error == nil) {
        let height = anyreult as! CGFloat + 50
        self.webViewHeight = height
        self.webView.frame = CGRect.init(x: 15, y: 0, width: screenWidth - 30, height: height)
        self.scrollView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: height)
        self.scrollView.contentSize = CGSize.init(width: screenWidth, height: height)
        let indexArr = NSArray(array: [NSIndexPath.init(row: 0, section: 0)]) as? [IndexPath]
        self.tableView.reloadRows(at: indexArr!, with: .none)
        }else {
            SVProgressHUD.show()
            self.webView.reload()
             SVProgressHUD.showError(withStatus: "请求有误")
   
           }
        }
        
    }
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        SVProgressHUD.show()
        webView.reload()
    }
     
  
}





  //MARK: -  键盘通知方法
extension NewsDetailVCViewController{
    //键盘的弹起监控
    func keyboardWillChangeFrame(notific: NSNotification) {
        let info = notific.userInfo
        let  keyBoardBounds = (info?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let duration = (info?[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let deltaY = keyBoardBounds.size.height
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.detailView?.transform = CGAffineTransform(translationX: 0 , y: -((self.detailView?.frame.height)! + deltaY))
        }
        
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((info?[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
            
        }else{
            animations()
        }
    }
    //键盘的收起监控
    func keyboardWillHidden(note: NSNotification) {
        let userInfo  = note.userInfo!
        let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber).doubleValue
        
        let animations:(() -> Void) = {
            //键盘的偏移量
            self.detailView!.transform = .identity
        }
        if duration > 0 {
            let options = UIViewAnimationOptions(rawValue: UInt((userInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).intValue << 16))
            
            UIView.animate(withDuration: duration, delay: 0, options:options, animations: animations, completion: nil)
        }else{
            animations()
        }
    }
    
   
}




  //MARK: - 底部初始化视图与功能
extension NewsDetailVCViewController {
    //初始化底部发布视图
    func creatBottomView() {
        let bottomView = UIView.init(frame: CGRect.init(x: 0, y: screenHeight - 108 , width: screenWidth, height: 44))
        bottomView.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
        //评论按钮
        let  writeCommentBtn = UIButton.init(frame: CGRect.init(x: 10, y: 7, width: screenWidth *  0.52, height: 30))
        writeCommentBtn.addTarget(self, action: #selector(NewsDetailVCViewController.editMessage), for: .touchUpInside)
        writeCommentBtn.setTitle("发表评论", for: .normal)
        writeCommentBtn.backgroundColor = UIColor.white
        writeCommentBtn.setTitleColor(UIColor.lightGray, for: .normal)
        writeCommentBtn.contentMode = .left
        writeCommentBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        bottomView.addSubview(writeCommentBtn)
        
        //评论数btn
        let commandBtn = UIButton.init(frame: CGRect.init(x: writeCommentBtn.frame.maxX + 10 , y: writeCommentBtn.frame.origin.y, width: screenWidth *  0.1, height: 30))
        commandBtn.center.y = writeCommentBtn.center.y
        commandBtn.showBadgOnImage(imageStr: "icon_comment_red")
        commandBtn.setTitle("30", for: .normal)
        commandBtn.setTitleColor(UIColor.lightGray, for: .normal)
        commandBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        commandBtn.addTarget(self, action:  #selector(NewsDetailVCViewController.showAllComment), for: .touchUpInside)
        bottomView.addSubview(commandBtn)
        //收藏按钮
        let collectionBtn = UIButton.init(frame: CGRect.init(x: commandBtn.frame.maxX + 30 , y: writeCommentBtn.frame.origin.y, width: screenWidth *  0.05, height: 20))
        collectionBtn.center.y = writeCommentBtn.center.y
        collectionBtn.setImage(UIImage.init(named: "icon_collect_white_defalt"), for: .normal)
        collectionBtn.setImage(UIImage.init(named:"icon_collect_red_highlighted"), for: .selected)
        collectionBtn.setTitleColor(UIColor.lightGray, for: .normal)
        collectionBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        collectionBtn.addTarget(self, action: #selector(NewsDetailVCViewController.collectionFunc), for: .touchUpInside)
        self.collectionBtn = collectionBtn
        bottomView.addSubview(self.collectionBtn!)
        //字体按钮
        let fontBtn = UIButton.init(frame: CGRect.init(x: collectionBtn.frame.maxX + 30 , y: writeCommentBtn.frame.origin.y, width: screenWidth *  0.05, height: 20))
        fontBtn.center.y = writeCommentBtn.center.y
        fontBtn.setImage(UIImage.init(named:"icon_fontsize"), for: .normal)
        fontBtn.setTitleColor(UIColor.lightGray, for: .normal)
        fontBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        fontBtn.addTarget(self, action: #selector(NewsDetailVCViewController.addSliderView), for: .touchUpInside)
        bottomView.addSubview(fontBtn)
        self.view.addSubview(bottomView)
    }
    
    
    //定义编辑发送功能
    func  editMessage() {
        self.detailView = UIView.init(frame: CGRect.init(x: 0, y: screenHeight - 64, width: screenWidth, height: 180))
        self.detailView?.backgroundColor = UIColor.init(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1.0)
        let detailScriptLable  = UILabel.init(frame: CGRect.init(x: (screenWidth - 100) / 2 , y: 5, width: 100, height: 20))
        detailScriptLable.text = "写评论"
        detailScriptLable.textAlignment = .center
        detailScriptLable.textColor = UIColor.lightGray
        detailScriptLable.font = UIFont.systemFont(ofSize: 15)
        detailView?.addSubview(detailScriptLable)
        //定义取消按钮
        let  cancelBtn = UIButton.init(frame:  CGRect.init(x: 0 , y: 5, width: 100, height: 20))
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(UIColor.lightGray, for: .normal)
        cancelBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        cancelBtn.addTarget(self, action: #selector(NewsDetailVCViewController.cancelCommandFunc), for: .touchUpInside)
        detailView?.addSubview(cancelBtn)
        
        //定义发送按钮
        let  sendBtn = UIButton.init(frame:  CGRect.init(x: screenWidth - 100 , y: 5, width: 100, height: 20))
        sendBtn.setTitle("发送", for: .normal)
        sendBtn.setTitleColor(UIColor.lightGray, for: .normal)
        sendBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        sendBtn.addTarget(self, action: #selector(NewsDetailVCViewController.sendCommandFunc), for: .touchUpInside)
        detailView?.addSubview(sendBtn)
        
        
        let detailDescriptFiled = CustomTextField.init(frame: CGRect.init(x: 10, y: 30, width: screenWidth - 20 , height: 140), placeholder: "字数在150字以内", clear: true, leftView: nil, fontSize: 12)
        //创建取消按钮
        detailDescriptFiled?.backgroundColor = UIColor.white
        detailDescriptFiled?.borderStyle = .none
        self.textField = detailDescriptFiled
        self.textField?.becomeFirstResponder()
        detailView?.addSubview(detailDescriptFiled!)
        self.view.addSubview(detailView!)
    }
    
    
    //发送评论方法
    func  sendCommandFunc() {
        self.textField?.resignFirstResponder()
        
    }
    
    //取消评论方法
    func  cancelCommandFunc() {
        self.textField?.resignFirstResponder()
    }
    //添加Slider
    func addSliderView() {
        let modelView = UIView.init(frame: CGRect.init(x: 0, y: screenHeight - 64, width: screenWidth, height: 200))
        modelView.backgroundColor = UIColor.init(white: 0.9, alpha: 0.5)
        self.modelView = modelView
        let silderView = UISlider.init(frame: CGRect.init(x: 20, y: 90, width: screenWidth - 40, height: 20))
        silderView.minimumValue = 100
        silderView.maximumValue = 200
        silderView.isContinuous = false
        silderView.minimumTrackTintColor = appdelgate?.theme
        silderView.setValue(Float((self.webFont)),animated:true)
        //添加当前值label
        self.valueLabel = UILabel.init(frame: CGRect.init(x: (screenWidth - 200) / 2, y: silderView.frame.maxY + 10 , width: 200, height: 40))
        self.valueLabel?.textAlignment = .center
        self.valueLabel?.text = String(format: "设置字体倍数为百分之%.2fX", silderView.value)
        self.valueLabel?.font = UIFont.systemFont(ofSize: 13)
        self.valueLabel?.textColor = appdelgate?.theme
        self.modelView?.addSubview(self.valueLabel!)
        
        silderView.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        self.modelView?.addSubview(silderView)
        self.silderView = silderView
        UIView.animate(withDuration: 0.25, animations: {
            self.view.addSubview(self.modelView!)
            self.modelView!.transform = CGAffineTransform(translationX: 0 , y: -((self.modelView?.frame.height)!))
        })
      
    }
    // slider变动时改变label值
    func  sliderValueChanged(sender : UISlider) {
        let  alterVC = UIAlertController.init(title: "确认修改", message: nil, preferredStyle: .alert)
        alterVC.addAction(UIAlertAction.init(title: "确认", style: .default, handler: { [weak self](action) in
            self?.webFont = Int(CGFloat(sender.value))
            self?.modelView?.transform = .identity
            let  str1 = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(Int(CGFloat(sender.value)))%'"
            self?.webView.evaluateJavaScript(str1, completionHandler: { [weak self](object, error) in
    
                
        })
            
            self?.modelView?.removeFromSuperview()
        }))
        alterVC.addAction(UIAlertAction.init(title: "取消", style: .destructive, handler: {[weak self](action) in
            self?.modelView?.transform = .identity
            self?.modelView?.removeFromSuperview()
            
        }))
        self.present(alterVC, animated: true, completion: nil)
        
    }


}

 //MARK: -  tableView代理方法
extension  NewsDetailVCViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3;
        }else if(section == 1 ){
            let commentNum =  self.commentModelArr.count != 0 ? self.commentModelArr.count : 1
            return commentNum;
        }else {
            return self.hot_newsModelArr.count
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 50
        case 2:
            return 50
        default:
            return 0.001
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 70
        default:
            return 0.001
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //初始化热点评论
        let recommendView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 50))
        recommendView.backgroundColor = UIColor.white
        let topBackView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 15))
        topBackView.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
        recommendView.addSubview(topBackView)
        
        let  hotCommandImage = UIImageView.init(frame:  CGRect.init(x: 10, y: 25, width: 70, height: 25))
        hotCommandImage.image = UIImage.init(named: "img_title_hotreviews")
        recommendView.addSubview(hotCommandImage)
        
        //初始化热点新闻
        let hotNewsView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 50))
        hotNewsView.backgroundColor = UIColor.white
        let topView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 15))
        topView.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
        hotNewsView.addSubview(topView)
        let  hotBtn = UIButton.init(frame: CGRect.init(x: 10, y: 25, width: 100, height: 25))
        hotBtn.setImage(UIImage.init(named: "img_fire"), for: .normal)
        hotBtn.setTitle("热点新闻", for: .normal)
        hotBtn.setTitleColor(UIColor.red, for: .normal)
        hotBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        hotNewsView.addSubview(hotBtn)
        
        switch section {
        case 1:
            return recommendView
        case 2:
            return hotNewsView
        default:
            return nil
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let recommendBtnView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 70))
        recommendBtnView.backgroundColor = UIColor.white
        let  commandSearchBtn = UIButton.init(frame: CGRect.init(x: (screenWidth - 160) / 2, y: 25, width: 160, height: 30))
        commandSearchBtn.setTitle("查看全部评论", for: .normal)
        commandSearchBtn.addTarget(self, action: #selector(NewsDetailVCViewController.showAllComment), for: .touchUpInside)
        commandSearchBtn.layer.borderWidth = 1
        commandSearchBtn.layer.borderColor = UIColor.red.cgColor
        commandSearchBtn.titleLabel?.textAlignment = .center
        commandSearchBtn.setTitleColor(UIColor.red, for: .normal)
        recommendBtnView.addSubview(commandSearchBtn)
        switch section {
        case 1:
            return recommendBtnView
        default:
            return nil
        }
    }
    
    //弹出全部评论列表
    func  showAllComment() {
        let commentListVC = CommentListVC()
        commentListVC.title = "评论列表"
        self.navigationController?.pushViewController(commentListVC, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            switch (indexPath.row) {
            case 0:
                return 80
            case 1:
                return webViewHeight;
            case 2:
                return 300;
            default:
                return 0;
            }
        }else if(indexPath.section == 1 ){
            guard self.commentModelArr.count != 0 else {
                return 800
            }
            
            let height = self.commentModelArr[indexPath.row].height != nil ? self.commentModelArr[indexPath.row].height : 800
            return height!;
            
        }else {
            return 100;
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var  cell : UITableViewCell?
        if indexPath.section == 0{
            switch indexPath.row {
            case 0:
               let  topCell = (tableView.dequeueReusableCell(withIdentifier: "NewsTopTitleCell", for: indexPath) as? NewsTopTitleCell)!
                topCell.time.text = self.newsModel?.publish_time
                topCell.title.text = self.newsModel?.title
                topCell.source.text = self.newsModel?.source
                cell = topCell
                
            case 1:
                let  webViewCell = tableView.dequeueReusableCell(withIdentifier: "WebViewCell", for: indexPath)
                webViewCell.contentView.addSubview(self.scrollView)
                cell = webViewCell

            case 2:
                 let sharecell = tableView.dequeueReusableCell(withIdentifier: newsDetailSharedCell, for: indexPath) as? NewsDetailSharedCell
                 let statement  =  self.newsModel?.statement != nil ?  self.newsModel?.statement : ""
                     sharecell?.statement.text = "                    \(String(describing: (statement)!))"
                 let interest = self.newsModel?.interest != nil ? self.newsModel?.interest : 0
                     sharecell?.interestBtn.setTitle("\(interest!)人喜欢", for: .normal)
                    cell = sharecell
                // }
               
            default:
                let defaultCell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
                defaultCell.textLabel?.text = "asdasdasdasdas"
                return defaultCell;
            }
        }else if(indexPath.section == 1 ){
            
            if   self.commentModelArr.count != 0{
                let  commmandCell = tableView.dequeueReusableCell(withIdentifier: hotCommandCell, for: indexPath) as? NewsHotCommondCell
                if  let commentModel = self.commentModelArr[indexPath.row] as? NewsComment {
                    if let picture = commentModel.user_info?.head_portrait{
                        if  let imageURL = URL.init(string: picture) {
                            commmandCell?.userPicImage.sd_setImage(with:  imageURL as URL, placeholderImage: #imageLiteral(resourceName: "img_headportrait"))
                        }
                    }
            
                    commmandCell?.areaLabel.text = commentModel.user_info?.area
                    commmandCell?.nameLabel.text = commentModel.user_info?.name
                    commmandCell?.timeLabel.text = commentModel.time
                    commmandCell?.zanLabel.text = "\((commentModel.msg_id)!)"
                    commmandCell?.commentLabel.text  = commentModel.content
       
                }
                cell = commmandCell
            }else{
            let  deafultCommentCell = tableView.dequeueReusableCell(withIdentifier: "NoCommandCell", for: indexPath) as? NoCommandCell
            deafultCommentCell?.designTitle.text = "此新闻暂无评论"
            cell = deafultCommentCell
            }
            
        }else if(indexPath.section == 2){
            let hotNewsCell = tableView.dequeueReusableCell(withIdentifier: "hotNewsCell", for: indexPath) as? HotNewsCell
            if  let hotmodel = self.hot_newsModelArr[indexPath.row] as? NewsHotModel{
            hotNewsCell?.hotNewsTitle.text = hotmodel.title
            hotNewsCell?.hotNewsTime.text = hotmodel.publish_time
            hotNewsCell?.hotNewsSource.setTitle("\((describing: hotmodel.source!))", for: .normal)
            hotNewsCell?.hotNewsPic.sd_setImage(with: URL.init(string: hotmodel.picture!), placeholderImage: UIImage.init(named: "moren"))
            cell = hotNewsCell
            }
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 2){
          let newsDetailVC = NewsDetailVCViewController()
            if let hotmodel = self.hot_newsModelArr[indexPath.row] as? NewsHotModel{
            let url = NSURL.init(string: hotmodel.url!)
            newsDetailVC.newsID = "\(String(describing: hotmodel.id!))"
            newsDetailVC.url = url
            self.navigationController?.pushViewController(newsDetailVC, animated: true)
            }
            
        }
    }


}
