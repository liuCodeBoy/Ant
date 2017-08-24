//
//  CategoryDetialVC.swift
//  CascadeListDemo
//
//  Created by Weslie on 2017/7/31.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

let CategoryDetReuseIdentifier = "CategoryReuseIdentifier"
typealias itemValue = (_ item: String) -> Void

class CategoryDetialVC: UIViewController {
    var selectClosure: itemValue?
  
    var subcategories: [String]?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
    
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: UIScreen.main.bounds.height / 2)
          tableView.backgroundColor = UIColor.clear
        tableView.bounces = false
    }
    
    lazy var tableView: UITableView =  {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: CategoryDetReuseIdentifier)
        table.tableFooterView = UIView()
        return table
    }()
    
    
}


extension CategoryDetialVC: UITableViewDelegate, UITableViewDataSource, CategoryViewControllerDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subcategories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryDetReuseIdentifier, for: indexPath)
        cell.textLabel?.text = subcategories![indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        return cell
    }
    
    func didSelectCategoryItem(_ category: Category) {
        subcategories = category.subcategories
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = subcategories![indexPath.row]
        //闭包赋值
        if selectClosure != nil {
            selectClosure!(item)
        }
        
    }
    
}
