//
//  GiveOutVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/12.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SVProgressHUD
import TZImagePickerController
private let picPickerCell = "picPickerCell"
private let edgeMargin : CGFloat = 15
//cellID

class GiveOutVC: UIViewController,TZImagePickerControllerDelegate{

     //pictrueView
    var picPickerView : PicPicKerCollectionView?
    
    //默认背景照片
    var  defaultImage  : UIImageView?
    
    //定义默认上传图片的最大数额
    let maxNum = 3
    
    //tableviewHeaderView
    var headerView : UIView?
    
    //headerLable
    var  headerLable : UILabel?
    //detailLable
    var  detailLable : UILabel?
    lazy var images = [UIImage]()
    
    //tableView
    var  listTableView : UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化tableview头部
        setUpHeaderImageView()
        //发送通知
        setupNotifications()
        //初始化tableiew
        craetTableView()
        //创建右导航按钮
        creatRightBtn()
        
    }
    
  
    
    
    
    
    func craetTableView() -> () {
        //初始化tableView 
        listTableView?.tableHeaderView = self.headerView
        self.view.addSubview(listTableView!)
        self.tabBarController?.tabBar.isHidden = true

    }
    
    func creatRightBtn() -> () {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "发布", style: .plain, target: self, action: #selector(GiveOutVC.sendOut))
        
    }
    
    func sendOut() {
        SVProgressHUD.showSuccess(withStatus: "发布成功")
    
    }
    
    
    private func  setUpHeaderImageView(){

        //初始化view成为tableview的headerView
        let  headerImageView =  UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 200))
       // self.view.addSubview(headerImageView)
        headerImageView.backgroundColor = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        self.headerView = headerImageView
    

        // 设置collectionView的layout
        let  layout =  UICollectionViewFlowLayout.init()
        let itemWH = (screenWidth - 5 * edgeMargin) / 4
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.minimumInteritemSpacing = edgeMargin
        layout.minimumLineSpacing = edgeMargin
        
        let  picPickerView = PicPicKerCollectionView(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 170), collectionViewLayout: layout)
        picPickerView.backgroundColor = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        self.headerView?.addSubview(picPickerView)
        self.picPickerView = picPickerView
        self.view.backgroundColor = UIColor.white

      // 创建默认视图
        let  imageView = UIImageView.init(image: UIImage.init(named: "luntan_houserent_addphoto_default"))
        imageView.frame = CGRect.init(x: 0, y: 0, width: screenWidth, height: 150)
        imageView.backgroundColor = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
        imageView.contentMode = .center
        self.headerView?.addSubview(imageView)
        self.defaultImage = imageView
        
       // 为默认视图添加事件
        let gesture =  UITapGestureRecognizer.init(target: self, action: #selector(GiveOutVC.ClickDisappare))
        self.defaultImage?.isUserInteractionEnabled = true
        self.defaultImage?.addGestureRecognizer(gesture)
        
        //添加默认lable
        let   headerLable = UILabel.init()
        headerLable.frame.origin.x =  screenWidth / 2 - 50
        headerLable.textAlignment = .center
        headerLable.frame.origin.y = (self.defaultImage?.frame.maxY)! - 30
        headerLable.frame.size = CGSize.init(width: 100, height: 30)
        headerLable.textColor = UIColor.lightGray
        headerLable.text = "添加照片"
        self.defaultImage?.addSubview(headerLable)
        self.headerLable = headerLable
        
        
        let   detailLable = UILabel.init()
        detailLable.frame.origin.x =  screenWidth / 2 - 50
        detailLable.textAlignment = .center
        detailLable.frame.origin.y = (self.headerLable?.frame.maxY)!
        detailLable.frame.size = CGSize.init(width: 100, height: 15)
        detailLable.textColor = UIColor.lightGray
        detailLable.font = UIFont.systemFont(ofSize: 10)
        detailLable.text = "个数不超过9张"
        self.defaultImage?.addSubview(detailLable)
        self.detailLable = detailLable
    }
    
    func ClickDisappare() -> () {
        self.defaultImage?.isHidden = true
        self.addPhotoClick()
    }
    
    
    
    private func setupNotifications() {
//        // 监听键盘的弹出
//        NotificationCenter.default.addObserver(self, selector: Selector(("keyboardWillChangeFrame:")), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        // 监听添加照片的按钮的点击
        NotificationCenter.default.addObserver(self, selector: #selector(GiveOutVC.addPhotoClick), name: PicPickerAddPhotoNote, object: nil)
        
        // 监听删除照片的按钮的点击
        NotificationCenter.default.addObserver(self, selector:  #selector(removePhotoClick(noti:)) , name: PicPickerRemovePhotoNote, object: nil)
    }

    deinit {
       
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.tabBarController?.tabBar.isHidden = false
    }
 
    
    
}






  //MARK: - 照片选择方法
extension GiveOutVC {
    func addPhotoClick() -> () {
         weak var  weakself = self
         let alert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
         alert.view.tintColor = UIColor.black
         let actionCancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
         let actionPhoto = UIAlertAction.init(title: "选择上传照片", style: .default) { (UIAlertAction) -> Void in
         if   (self.picPickerView?.images.count)! < (weakself?.maxNum)! {
         self.showLocalPhotoGallery()}
         else{
         SVProgressHUD.showError(withStatus: "你的上传图片已经达到最大数额")
         }
            }
            
            alert.addAction(actionCancel)
            alert.addAction(actionPhoto)
            self.present(alert, animated: true, completion: nil)
    }
    
    
    private func showLocalPhotoGallery(){
     weak var  weakself = self
      
        let  pushNumber = maxNum - (self.picPickerView?.images.count)!
        let  imagePickerVc = TZImagePickerController.init(maxImagesCount: pushNumber, delegate: self as TZImagePickerControllerDelegate)
      
        imagePickerVc?.didFinishPickingPhotosWithInfosHandle = {(photosArr , assets ,isSelectOriginalPhoto ,infos) in
         for i in  0..<photosArr!.count {
        weakself?.images.append((photosArr?[i])!)
        }
        self.picPickerView?.images = self.images

        }
        
     self.present(imagePickerVc!, animated: true, completion: nil)

  }
    
    func removePhotoClick(noti : Notification) ->  () {
        let removeAlert = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        
        removeAlert.view.tintColor = UIColor.black
        let actionCancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        let actionPhoto = UIAlertAction.init(title: "删除该上传照片", style: .destructive) { (UIAlertAction) -> Void in
            let  tag = ((noti.object as? UIButton)?.tag)! - 1000
            self.images.remove(at: tag)
            self.picPickerView?.images = self.images
        }
        removeAlert.addAction(actionCancel)
        removeAlert.addAction(actionPhoto)
        self.present(removeAlert, animated: true, completion: nil)
        
    }
    
}

