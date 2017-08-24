//
//  File.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/6/22.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import  Foundation
import SDWebImage

//定义传值闭包
typealias pageClosureType  = (_ number : CGFloat?) -> Void
class ImageScrollview: UIScrollView ,UIScrollViewDelegate{
    
      lazy var imageArray =  Array<UIImage>()
    
      var   imageScrollview =  UIScrollView()
    
      var    imageCount : Int?
    
      //定义定时器对象
      var   timer : Timer?
  
    //将申明闭包设置成属性
      var pageNumBlock : pageClosureType?
    
    
    
    
    convenience init(imageArray : NSArray) {
        self.init()
        self.imageScrollview = self
        imageScrollview.frame =  CGRect.init(x: 0, y: 0, width:screenWidth, height: 160)
        imageScrollview.contentSize = CGSize(width: screenWidth * CGFloat(imageArray.count), height: 160)
        imageScrollview.bounces = false
        imageScrollview.delegate = self
        imageScrollview.isPagingEnabled = true
        imageScrollview.showsVerticalScrollIndicator = false
        imageScrollview.showsHorizontalScrollIndicator = false
        
        self.imageCount = imageArray.count
        //取出数组中的相册图片
        for i  in 0..<imageArray.count {
        let imageName = imageArray[i] as? String
        let imageURL = NSURL.init(string: imageName!)
        let  cycleImageView = UIImageView()
            //网络请求图片
            cycleImageView.sd_setImage(with: imageURL as URL!, placeholderImage: UIImage.init(named: "moren"), options: [.continueInBackground , .lowPriority]){ (image, error, type, url) in
                
               if(error == nil){
                    self.imageArray.append(image!)
              }else{
                     print(error as Any)
              }
            }
     
           
        cycleImageView.frame = CGRect.init(x: screenWidth * CGFloat(i), y: 0, width: screenWidth, height: 160)
        imageScrollview.addSubview(cycleImageView)

         //图片标题
            let  titleView  = UIView(frame: CGRect.init(x: screenWidth * CGFloat(i), y: 125, width: screenWidth, height: 35))
            titleView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
            let   textLable = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 35))
            textLable.text = "   \(i)"
            textLable.textAlignment = .left
            textLable.textColor = UIColor.white
            titleView.addSubview(textLable)
          imageScrollview.addSubview(titleView)
        }
          addTimer()
   
    }
  
    deinit {
        self.removeTimer()
        
    }
    
}


  //MARK: - imageScrollView定时器                   
extension ImageScrollview  {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.removeTimer()
    }
    
    func  scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addTimer()
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
         let x = scrollView.contentOffset.x
         let width = self.frame.width
         if x >= 2*width {
//            currentPage = (currentPage!+1) % self.images!.count
//            pageControl!.currentPage = currentPage!
//            refreshImages()
         }
      if x <= 0 {
//            currentPage = (currentPage!+self.images!.count-1) % self.images!.count
//            pageControl!.currentPage = currentPage!
//            refreshImages()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: true)
        let   pageNumber =  scrollView.contentOffset.x / screenWidth
        
        if (pageNumBlock != nil) {
            pageNumBlock!(pageNumber)
        }
        
    }
    
    
    //开启定时器
    func addTimer(){
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(ImageScrollview.nextImage), userInfo: nil, repeats: true)
    }
    //关闭定时器
    func removeTimer(){
        self.timer?.invalidate()
    }
    func nextImage(){
        let page = Int(self.imageScrollview.contentOffset.x / screenWidth)
        
        if (page == self.imageCount! - 1){
            self.imageScrollview.contentOffset.x = 0
            if (pageNumBlock != nil) {
                pageNumBlock!(self.imageScrollview.contentOffset.x / screenWidth)
            }
        }else{
            self.imageScrollview.contentOffset.x  +=  screenWidth
            if (pageNumBlock != nil) {
                pageNumBlock!(self.imageScrollview.contentOffset.x / screenWidth)
            }
        }
        
    }
}
