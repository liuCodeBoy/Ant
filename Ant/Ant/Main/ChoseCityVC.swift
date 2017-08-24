//
//  ViewController.swift
//  CitiesSelectorDemo
//
//  Created by Weslie on 2017/7/24.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

let skyblue: UIColor = UIColor.init(red: 102 / 255, green: 204 / 255, blue: 255 / 255, alpha: 1)
typealias cityClouseType = (String?) -> ()

class ChoseCityVC: UIViewController {
    
    let app = UIApplication.shared.delegate as? AppDelegate

    let scroll = UIScrollView(frame: UIScreen.main.bounds)
    
    //定义传值闭包
    var  cityClouse : cityClouseType?
    
    
    
    var cities: [[String: [Any]]] = [
        
        ["新南威尔士": ["悉尼", "卧龙岗", "纽卡斯尔", "中央海岸", UIColor.red]],
        ["维多利亚": ["墨尔本", "基隆", skyblue]],
        ["昆士兰": ["布里斯班", "黄金海岸", "凯恩斯", "阳关海岸", UIColor.green]],
        ["南澳": ["阿德莱德", UIColor.yellow]],
        ["西澳": ["珀斯", UIColor.orange]],
        ["其他重要城市": ["堪培拉","霍巴特","达尔文", UIColor.purple]]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(scroll)
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        setupCitiesVC()
        //添加导航栏
        initNav()
        
    }
    
    
    //初始化导航栏
    func initNav() {
        let bgView =  UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 64))
        bgView.backgroundColor = UIColor.init(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1.0)
        self.view.addSubview(bgView)
        
      
        
        //标题
        let titleLabel = UILabel(frame: CGRect.init(x: screenWidth/2 - 50, y: 30, width: 100, height: 25))
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.text = "选择城市"
        bgView.addSubview(titleLabel)
        
        //取消按钮
        let  closeBtn = UIButton(type: .custom)
        closeBtn.frame = CGRect.init(x: 20, y: 30, width: 20, height: 20)
        closeBtn.setImage(UIImage.init(named: "icon_nav_quxiao_normal"), for: .normal)
        closeBtn.addTarget(self, action:#selector(ChoseCityVC.closeBtn1), for: .touchUpInside)
        bgView.addSubview(closeBtn)
    }

    
    func closeBtn1() -> () {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func getTitleColor(sender: UIButton) {
    
        app?.theme = (sender.titleLabel?.textColor)!
        if self.cityClouse != nil {
            self.cityClouse!(sender.titleLabel?.text!)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func setupCitiesVC() {
        let lableHeight: CGFloat = 50
        let lableWidth: CGFloat = 150
        let buttonWidth = (UIScreen.main.bounds.width - 20 - 3 * 5) / 4
        let buttonHeight: CGFloat = 30
        let buttonSpacing: CGFloat = 10
        var buttonY: CGFloat = 60
        var buttonX: CGFloat = 10
        
        var lableY: CGFloat = 64{
            willSet {
                buttonY = lableY + lableHeight
            }
        }
        
        for i in 0..<cities.count {
            let locality = cities[i]
            let localityLable = UILabel(frame: CGRect(x: 10, y: lableY, width: lableWidth, height: lableHeight))
            localityLable.text = locality.keys.first
            localityLable.font = UIFont.systemFont(ofSize: 15)
            localityLable.textColor = UIColor.darkGray
            self.scroll.addSubview(localityLable)
            lableY = lableY + lableHeight
            for j in 0..<(locality.first?.value)!.count - 1 {
                
                let lines: Int = ((locality.first?.value.count)! - 2) / 4 + 1
                
                let city = locality.first?.value
                let cityButton = UIButton(frame: CGRect(x: buttonX + (CGFloat)(j % 4) * (buttonWidth + 5), y: (CGFloat(j / 4) * (buttonHeight + buttonSpacing) + lableY) , width: buttonWidth, height: buttonHeight))
                
                
                
                cityButton.setTitle((city![j] as! String), for: .normal)
                cityButton.setTitleColor(UIColor.darkGray, for: .normal)
//                cityButton.setAttributedTitle(NSAttributedString(string : (cityButton.titleLabel?.text)! , attributes : [NSUnderlineStyleAttributeName : NSUnderlineStyle.styleSingle.rawValue, NSForegroundColorAttributeName: UIColor.red] ), for: .normal)
                cityButton.setTitleColor((locality.first?.value.last! as! UIColor), for: .highlighted)
                cityButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                cityButton.layer.borderWidth = 0.3
                cityButton.layer.borderColor = UIColor.init(white: 0.7, alpha: 0.5).cgColor
                
                cityButton.addTarget(self, action: #selector(getTitleColor(sender:)), for: .touchUpInside)
                
                self.scroll.addSubview(cityButton)
                
                if j == ((locality.first?.value.count)! - 2) {
                    lableY += CGFloat(lines) * (buttonHeight + buttonSpacing)
                }
            }
        }
    }
    
}





