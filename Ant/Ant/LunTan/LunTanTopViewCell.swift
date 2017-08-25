//
//  LunTanTopViewCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/10.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
typealias showVCType = (UIViewController) -> ()

class LunTanTopViewCell: UITableViewCell {
    
    var  tempArr : NSMutableArray? = []
    
    let  lunTanCellID = "LunTanTopViewCell"
 
    @IBOutlet weak var searchTextField: UITextField!
    
    //创建显示控制器
    var   showVCClouse  : showVCType?
    
     var   headerView : UIView?
    
     override func awakeFromNib() {
        super.awakeFromNib()
         self.headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 30))
         let lineView = UIView.init(frame: CGRect.init(x: 0, y: 37, width: screenWidth, height: 1))
         lineView.backgroundColor = UIColor.init(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
        self.headerView?.addSubview(lineView)
         let headLeftTitle = UILabel.init(frame: CGRect.init(x: 20, y: 15, width:150, height: 15))
         headLeftTitle.text = "生活服务"
         headLeftTitle.font = UIFont.systemFont(ofSize: 14)
         self.headerView?.addSubview(headLeftTitle)
        
        let headRightTitle = UILabel.init(frame: CGRect.init(x: screenWidth - 90, y: 15, width:90, height: 10))
        headRightTitle.text = "为你提供生活所需"
        headRightTitle.textColor = UIColor.lightGray
        headRightTitle.font = UIFont.systemFont(ofSize: 10)
        self.headerView?.addSubview(headRightTitle)
        
        
        self.addSubview(headerView!)
        headerView?.isHidden = true
        
        }
        
    

    func addSubBtns() -> () {
        for i in 0..<tempArr!.count {
            
            let  col =  CGFloat(i % 4) + 1
            let  row  =  CGFloat(i / 4)
            let margin = CGFloat(10)
            let  width = (screenWidth - CGFloat(5 * margin)) / 4
            let  height = width
            let   x = CGFloat((col - 1) * width) + CGFloat(col * margin)
            let   y =  (row * height) + ((row - 1) * (margin)) + 60
            
            let btn = MallButton.init(frame: CGRect.init(x: x, y: y, width: width, height: height))
            btn.tag = i
            btn.addTarget(self, action: #selector(LunTanTopViewCell.btnClick(btn:)), for: .touchUpInside)
            //取出模型
            let model = self.tempArr?[i] as? lunTanModel
            btn.setImage( UIImage.init(named: (model?.image)!), for: .normal)
            btn.setTitle(model?.name, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            self.addSubview(btn)
            
        }
    }
    
    func btnClick(btn: UIButton){
        let  tag = btn.tag
        var  presentVC = UIViewController()
        switch tag {
        case 0:
            let houseRentVC = HouseRentVC()
            presentVC = houseRentVC
        case 1:
            let houseRentVC = HouseNeedRentVC()
            houseRentVC.title = "房屋求租"
            presentVC = houseRentVC
        case 2:
            let jobVC = JobOrEnigeerVC()
            jobVC.title = "求职招聘"
            presentVC = jobVC
        case 3:
            let CarSale = CarSaleVC()
            CarSale.title = "汽车买卖"
            presentVC = CarSale
        case 4:
            presentVC = UIStoryboard.init(name: "SecondHand", bundle: nil).instantiateInitialViewController()!
        case 5:
            let cityWide = CityWideVC()
            cityWide.title = "同城交友"
            presentVC = cityWide
        default: break
        }
        
        
       
        if  showVCClouse != nil {
            showVCClouse!(presentVC)
        }
        
      
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
