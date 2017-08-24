//
//  BtnScrollView.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/6/8.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
typealias   changeScrollType = (Int?) -> Void
typealias changeScrollOffsetType = (Int?) -> Void
class BtnScrollView: UIScrollView ,UIScrollViewDelegate{
    var  tempBtnValue : Int = 0
    
    
    var chageClosure : changeScrollType?
    
    
    var  changeOffClosure : changeScrollOffsetType?
    
    //初始化下滑视图
    var  sliderView : UIView?
    
    
    convenience init(btnArrays : NSArray) {
        self.init()
        let  scrollView = self
        scrollView.delegate = self
        scrollView.frame = CGRect.init(x: 0, y: 0, width:UIScreen.main.bounds.width - 45 , height: 35)
        scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        scrollView.backgroundColor =  UIColor.white
        scrollView.contentSize = CGSize.init(width: 60 * btnArrays.count, height: 35)
        scrollView.showsHorizontalScrollIndicator = false
        
        
        // 添加下滑控件
        self.sliderView = UIView()
        self.sliderView?.frame = CGRect.init(x: 0, y: 33, width: 60, height: 2)
        self.sliderView?.backgroundColor = UIColor.applicationMainColor()
        self.addSubview(self.sliderView!)
        
        
        //添加button
        for  i in   0..<btnArrays.count {
            let  button  = UIButton.init()
            button.tag = i + 1000
            var cartModel = CateModel()
             cartModel =  btnArrays[i] as! CateModel
            button.setTitle(cartModel.name, for: .normal)
            button.setTitleColor(UIColor.lightGray, for: .normal)
            button.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            button.frame = CGRect(x: 60 * i , y: 0, width: 60 , height: 35)
            button.titleLabel?.textAlignment = .left
            if  i == 0 {
            btnClick(btn: button)
            self.sliderView?.center.x = button.center.x
            }
            scrollView.addSubview(button)
        }
    
    }

    
    func btnClick(btn : UIButton)  {
        
        //滑动视图偏移
        UIView.animate(withDuration: 0.5) { 
            self.sliderView?.center.x = btn.center.x
        }
        
        
        //添加scrollView
        if(chageClosure != nil){
            chageClosure!(btn.tag - 1000)
        }
        
        //改变scrollView的偏移量
        if(changeOffClosure != nil){
           changeOffClosure!(btn.tag - 1000)
        }
        // 执行动画
        var  preBtn  =  UIButton()
        if (btn.tag != self.tempBtnValue && self.tempBtnValue != 0){
            
            for tempBtn in self.subviews {
                if tempBtn.tag == self.tempBtnValue {
                    preBtn = tempBtn as! UIButton
                    preBtn.setTitleColor(UIColor.lightGray, for: .normal)
                    let  aniScale =    CABasicAnimation(keyPath: "transform.scale")
                    self.transforFont(fromValue: 1.2, toValue: 1.0, antLayer: preBtn, animaName: aniScale)
                    self.tempBtnValue = btn.tag
                }
            }
            
            let tempTag =   btn.tag - 1000
            UIView.animate(withDuration: 0.5, animations: { 
                if(tempTag >= 3 && tempTag < self.subviews.count - 4){
                    self.contentOffset.x = CGFloat(tempTag - 2) * btn.frame.size.width - 30
                }else if(tempTag == 1){
                    self.contentOffset.x = 0
                }
            })
            
            
            
          
            let  aniScaleNow =    CABasicAnimation(keyPath: "transform.scale")
            self.transforFont(fromValue: 1.0, toValue: 1.2, antLayer: btn, animaName: aniScaleNow)
            btn.setTitleColor(UIColor.applicationMainColor(), for: .normal)
            
            
        }else if(self.tempBtnValue == 0){
        
            let  aniScaleNow =    CABasicAnimation(keyPath: "transform.scale")
            self.transforFont(fromValue: 1, toValue: 1.2, antLayer: btn, animaName: aniScaleNow)
            btn.setTitleColor(UIColor.applicationMainColor(), for: .normal)
            self.tempBtnValue = btn.tag

        }else{}
        
      
    }
    
    
    
    
    //抽取自定义动画
    
        func transforFont(fromValue : Float , toValue : Float , antLayer : UIButton , animaName : CABasicAnimation)  {
            animaName.duration = 0.5
            animaName.repeatCount = 1
            animaName.isRemovedOnCompletion = false
            animaName.fillMode =  kCAFillModeForwards   //执行动画后不恢复初始状态
            animaName.fromValue = NSNumber(value: fromValue)// 开始时的倍率
            animaName.toValue = NSNumber(value: toValue) // 结束时的倍率
            antLayer.layer.add(animaName, forKey: "scale-layer")
            
        }

}

  //MARK: - BtnscrollView的代理方法
extension  BtnScrollView {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
    }



}



    
