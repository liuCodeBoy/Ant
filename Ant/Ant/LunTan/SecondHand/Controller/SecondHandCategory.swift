//
//  SecondHandCategory.swift
//  Ant
//
//  Created by Weslie on 2017/8/21.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class SecondHandCategory: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        switch segue.identifier! {
        case "home_app":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "家电"
        case "phone_acc":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "手机配件"
        case "computer_acc":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "电脑配件"
        case "clothes":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "服饰"
        case "outdoor":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "文体户外"
        case "children":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "母婴儿童"
        case "furniture":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "家具用品"
        case "car_acc":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "汽车配件"
        case "health_care":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "美容保健"
        case "food":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "食品饮料"
        case "adult":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "成人用品"
        case "other":
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = "其他二手"
        case "issue":
            _ = segue.destination as! SecondHandIssueVC
        default :
            let destination = segue.destination as! SecondHandListVC
            destination.categoryName = ""
        }
    }

}
