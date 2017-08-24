//
//  ViewController.swift
//  CascadeListDemo
//
//  Created by Weslie on 2017/7/31.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

let width = UIScreen.main.bounds.width
let tableViewHeight = UIScreen.main.bounds.height / 2

class ViewController: UIViewController {
    
    var category = CategoryVC()
    var categoryDetial = CategoryDetialVC()
    
    let btnWidth = (UIScreen.main.bounds.width - 2) / 3
    let button1 = UIButton(frame: CGRect(x: 0, y: 0, width:  (UIScreen.main.bounds.width - 2) / 3, height: 30))


    var cascadeViewDidShow: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadListView()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
}

extension ViewController {

    
    func addCascadeList() {
        self.loadRotationImg(sender: button1.imageView!)
        category.categoryDelegate = categoryDetial
        if cascadeViewDidShow == true {
            UIView.animate(withDuration: 0.2, animations: {
                self.category.view.frame.size.height = 0
                self.category.tableView.frame.size.height = 0
                self.categoryDetial.view.frame.size.height = 0
                self.categoryDetial.tableView.frame.size.height = 0
            }, completion: { (_) in
                self.category.view.isHidden = true
                self.categoryDetial.view.isHidden = true
                self.category.tableView.isHidden = true
                self.categoryDetial.tableView.isHidden = true

            })
            cascadeViewDidShow = !cascadeViewDidShow
        } else {
            cascadeViewDidShow = !cascadeViewDidShow
    
                self.category.view.frame.size.height = tableViewHeight
                self.category.tableView.frame.size.height = tableViewHeight
                self.categoryDetial.view.frame.size.height = tableViewHeight
                self.categoryDetial.tableView.frame.size.height = tableViewHeight

                self.category.view.isHidden = false
                self.categoryDetial.view.isHidden = false
                self.category.tableView.isHidden = false
                self.categoryDetial.tableView.isHidden = false

       }
    
        
    }
    
    fileprivate func loadListView() {
        
        
        

        let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.setTitle("区域", for: .normal)
        button1.setImage(#imageLiteral(resourceName: "triangle"), for: .normal)
        button1.contentMode = .left
        button1.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(button1.imageView?.frame.width)! * 2, bottom: 0, right: 0)
       
     //   button1.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button1.imageEdgeInsets = UIEdgeInsets(top: 0, left: -((button1.titleLabel?.frame.width)!), bottom: 0, right: -(button1.titleLabel?.frame.width)! * 2 - 10)


        
        button1.addTarget(self, action: #selector(addCascadeList), for: .touchUpInside)
        
        let button2 = UIButton(frame: CGRect(x: btnWidth + 1, y: 0, width: btnWidth, height: 40))
        button2.setTitle("户型", for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 10)

        button2.setTitleColor(UIColor.black, for: .normal)
        let button3 = UIButton(frame: CGRect(x: btnWidth * 2 + 2, y: 0, width: btnWidth, height: 40))
        button3.setTitle("按租金排序", for: .normal)
        button3.setTitleColor(UIColor.black, for: .normal)
        let lineView1: UIView = UIView(frame: CGRect(x: btnWidth, y: 8, width: 1, height: 24))
        lineView1.backgroundColor = UIColor.lightGray
        let lineView2: UIView = UIView(frame: CGRect(x: btnWidth * 2 + 1, y: 8, width: 1, height: 24))
        lineView2.backgroundColor = UIColor.lightGray
        
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(lineView1)
        view.addSubview(lineView2)
        
        self.view.addSubview(view)
        category.categoryDelegate = categoryDetial
        category.view.frame = CGRect(x: 0, y: 40, width: width * 0.4, height: tableViewHeight)
        self.view.addSubview(category.view)
        addChildViewController(category)
        categoryDetial.view.frame = CGRect(x: width * 0.4, y: 0, width: width * 0.6, height: tableViewHeight)
        self.view.addSubview(categoryDetial.view)
        addChildViewController(categoryDetial)

        self.category.view.isHidden = true
        self.categoryDetial.view.isHidden = true
        
    }
    
    func loadRotationImg(sender: UIImageView) {
        // 1.创建动画
        let rotationAnim = CABasicAnimation(keyPath: "transform.rotation.z")
        
        // 2.设置动画的属性
        if cascadeViewDidShow == false {
            rotationAnim.fromValue = 0
            rotationAnim.toValue = Double.pi
        } else {
            rotationAnim.fromValue = Double.pi
            rotationAnim.toValue = 0
        }
        
        rotationAnim.duration = 0.2
        rotationAnim.isRemovedOnCompletion = false
        rotationAnim.fillMode = kCAFillModeForwards
        
        // 3.将动画添加到layer中
        sender.layer.add(rotationAnim, forKey: nil)
    }

}














