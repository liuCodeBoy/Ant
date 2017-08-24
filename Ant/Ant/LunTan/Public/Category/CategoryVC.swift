//
//  CategoryVC.swift
//  CascadeListDemo
//
//  Created by Weslie on 2017/7/31.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit
typealias categoryType = (_ item: String) -> Void

protocol CategoryViewControllerDelegate: NSObjectProtocol {
    func didSelectCategoryItem(_ category: Category)
}

let CategoryReuseIdentifier = "CategoyReuseIdentifier"


class CategoryVC: UIViewController {
    
    //定义传值闭包
    var selectClosure: categoryType?
    
    var   plistName : String?
    
    var categories: [Category]?
    
    var categoryDelegate: CategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.addSubview(tableView)
        tableView.bounces = false
        categories =    Category.getCategoty(plistName: plistName!)
        let height  = (categories?.count)! < 7 ? CGFloat((categories?.count)!) * 40 : CGFloat(screenHeight / 2)
        tableView.frame = CGRect(x: 0, y: 0, width: Int(screenWidth), height:Int(height))
        tableView.backgroundColor = UIColor.clear
       
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        categoryDelegate?.didSelectCategoryItem(categories!.first!)
    }
    
    lazy var tableView: UITableView = {
      
        let table = UITableView.init()
        table.delegate = self
        table.dataSource = self
        table.tableFooterView = UIView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: CategoryReuseIdentifier)
        
        return table
    }()
    

}


extension CategoryVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryReuseIdentifier, for: indexPath)
        let category = categories![indexPath.row]
        
        cell.textLabel?.text = category.name
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        //闭包赋值
        if selectClosure != nil {
            let  item = categories![indexPath.row].name
            selectClosure!(item!)
        }
          let cell = tableView.dequeueReusableCell(withIdentifier: CategoryReuseIdentifier, for: indexPath)
        cell.textLabel?.textColor = UIColor.red
        categoryDelegate?.didSelectCategoryItem(categories![indexPath.row])
    }
}
