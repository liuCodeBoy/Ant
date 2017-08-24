//
//  Categoty.swift
//  CascadeListDemo
//
//  Created by Weslie on 2017/7/31.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class Category: NSObject {
    
    var subcategories: [String]?
    
    var name: String?
    
    class func getCategoty(plistName : String) -> [Category] {
        var categoryArray = [Category]()
        let path = Bundle.main.path(forResource: plistName, ofType: "plist")
        let categories = NSArray(contentsOfFile: path!)
        
        for category in categories! {
            categoryArray.append(self.categoryWithDict(category as! [String : AnyObject]))
        }
        
        return categoryArray
        
    }
    
    
    class func categoryWithDict(_ dict: [String: AnyObject]) -> Category {
        
        let category = Category()
        category.setValuesForKeys(dict)
        
        return category
        
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
