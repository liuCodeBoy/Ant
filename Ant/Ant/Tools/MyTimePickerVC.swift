//
//  MyTimePickerVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/12.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

typealias TimeClouseType = (String?) -> ()
typealias CloseClouseType = () -> ()
class MyTimePickerVC: UIViewController{

//定义时间闭包
    var  timeClouse : TimeClouseType?

//定义关闭闭包
    var  closeClouse : CloseClouseType?
    
 //closeBtn
    var  closeBtn : UIButton?
    
    override func viewDidLoad() {
        
        let  closeBtn = UIButton(type: .custom)
        closeBtn.frame = CGRect.init(x: 20, y: 0, width: 20, height: 20)
        closeBtn.setImage(UIImage.init(named: "icon_nav_quxiao_normal"), for: .normal)
        closeBtn.addTarget(self, action:#selector(MyTimePickerVC.closeView), for: .touchUpInside)
        self.view.addSubview(closeBtn)

        
        //创建日期选择器
        let datePicker = UIDatePicker(frame: CGRect(x:0, y: 30, width:screenWidth, height:220))
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = Locale(identifier: "zh_CN")
        datePicker.datePickerMode = .date
    
        
        //注意：action里面的方法名后面需要加个冒号“：”
        datePicker.addTarget(self, action: #selector(dateChanged),for: .valueChanged)
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(datePicker)
    }

    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = DateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日"
        if timeClouse !=  nil {
          timeClouse!(formatter.string(from: datePicker.date))
        }
        
       
    }
    
    func closeView() -> () {
      if closeClouse !=  nil {
            closeClouse!()
        }
        
    }
    

}
