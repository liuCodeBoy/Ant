//
//  ConnactOptions.swift
//  DetialsOfAntDemo
//
//  Created by Weslie on 2017/7/17.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class ConnactOptions: UITableViewCell {
    
    @IBOutlet weak var con_Image: UIImageView!
    @IBOutlet weak var con_Ways: UILabel!
    @IBOutlet weak var con_Detial: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let way = con_Ways.text {
                self.con_Ways.text = way
            }
        }
    }

}
