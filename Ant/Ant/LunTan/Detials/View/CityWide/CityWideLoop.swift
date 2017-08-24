//
//  CityWideLoop.swift
//  Ant
//
//  Created by Weslie on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

//class CityWideLoopView: UIView {
//    
//    var cityWideLoop: LoopView?
//    
//    fileprivate var leftArrow: UIButton?
//    fileprivate var rightArrow: UIButton?
// 
//    convenience init(frame: CGRect, images: NSArray, autoPlay: Bool, delay: TimeInterval) {
//        self.init(frame: frame)
//        
//        cityWideLoop = LoopView(frame: frame, images: images, autoPlay: autoPlay, delay: delay, isFromNet: true)
//        self.addSubview(cityWideLoop!)
//        loadCityWideCustom()
//        
//    }
//    
//    fileprivate func loadCityWideCustom() {
//
//        leftArrow = UIButton(frame: CGRect(x: 0, y: 40, width: 20, height: 40))
//        rightArrow = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 20, y: 40, width: 20, height: 40))
//        
//        rightArrow?.setImage(#imageLiteral(resourceName: "TableViewArrow.png"), for: .normal)
//        
//        self.addSubview(leftArrow!)
//        self.addSubview(rightArrow!)
//        
//        let connactDict = [["weixin": #imageLiteral(resourceName: "weixin")], ["jiaotan": #imageLiteral(resourceName: "jiaotan")], ["dianhua": #imageLiteral(resourceName: "dianhua")]]
//        
//        for i in 0..<3 {
//            let buttonWidth = UIScreen.main.bounds.width / 3
//            let buttonHeifht: CGFloat = 60
//            let connactBtn = UIButton(frame: CGRect(x: CGFloat(i) * buttonWidth, y: (cityWideLoop?.frame.height)! - buttonHeifht, width: buttonWidth, height: buttonHeifht))
//            connactBtn.backgroundColor = UIColor.orange
//            connactBtn.setTitle(connactDict[i].first?.key, for: .normal)
//            connactBtn.setImage(connactDict[i].first?.value, for: .normal)
//            
//            self.addSubview(connactBtn)
//        }
//    }
//}
