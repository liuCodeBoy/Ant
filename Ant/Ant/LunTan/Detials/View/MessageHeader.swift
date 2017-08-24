//
//  MessageHeader.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/18.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class MessageHeader: UITableViewCell {
    
    @IBOutlet weak var liuyan: UIButton!
    @IBAction func liuyanBtn(_ sender: UIButton) {
        
        print("liuyan")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.changeBorderLineStyle(target: liuyan, borderColor: .red)
    }


    
    
}
