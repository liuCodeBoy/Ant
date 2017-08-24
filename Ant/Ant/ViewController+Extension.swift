//
//  ViewController+Extension.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/18.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
let appdelgate  = UIApplication.shared.delegate  as? AppDelegate
extension UIViewController{
    
    func viewDidLoadForChangeTitleColor() {
        self.viewDidLoadForChangeTitleColor()
        self.tabBarController?.tabBar.tintColor = UIColor.applicationMainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = {[
              NSForegroundColorAttributeName: UIColor.white
            ]}()
        self.navigationController?.navigationBar.barTintColor = UIColor.applicationMainColor()
    }
    

}


class antButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        let  fontSize = self.titleLabel?.font.pointSize
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize! * (appdelgate?.fontSize)! )
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension  UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        let  fontSize = self.font.pointSize
        self.font = UIFont.systemFont(ofSize: fontSize * (appdelgate?.fontSize)! )
    }
}

extension UIButton {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        let  fontSize = self.titleLabel?.font.pointSize
        self.titleLabel?.font = UIFont.systemFont(ofSize: fontSize! * (appdelgate?.fontSize)! )
        
    }
    
      //MARK: - 显示图片
    func showBadgOnImage(imageStr : NSString) {
    
        let  labW  : CGFloat = 20
        // 创建小红点
        let bageView = UIImageView()
        let tabFrame = self.frame
        // 确定小红点的位置
        let x: CGFloat = CGFloat(tabFrame.size.width - labW / 2)
        let y: CGFloat = CGFloat(-(labW / 2.5))
        bageView.frame = CGRect(x: x, y: y, width:  labW, height:  labW)
        bageView.image = UIImage.init(named: imageStr as String)
        self.addSubview(bageView)
    }

    
    
    // MARK:- 显示小红点
    func showBadgOn(numStr : NSString) {
        let  labW  : CGFloat = 10
        // 创建小红点
        let bageView = UIView()
        bageView.layer.cornerRadius = labW
        bageView.backgroundColor = UIColor.red

        let tabFrame = self.frame
        // 确定小红点的位置
        let x: CGFloat = CGFloat(tabFrame.size.width - labW)
        let y: CGFloat = CGFloat(-labW)
        bageView.frame = CGRect(x: x, y: y, width: 2 * labW, height: 2 * labW)
        
        
        //创建数字lable
        let numLabel = UILabel.init()
        numLabel.textColor = UIColor.white
        numLabel.textAlignment = .center
        numLabel.text = numStr as String
        numLabel.frame.size = CGSize.init(width: 1.5 * labW, height: 1.5 * labW)
        numLabel.center.y = labW
        numLabel.center.x = labW
        numLabel.font = UIFont.systemFont(ofSize: 11)
        bageView.addSubview(numLabel)
        self.addSubview(bageView)
    }
}




class antTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let  fontSize = self.textLabel?.font.pointSize
        self.textLabel?.font = UIFont.systemFont(ofSize: fontSize! * (appdelgate?.fontSize)! )

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
