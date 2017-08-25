//
//  LunTanListWithLocationCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/1.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class LunTanListWithLocationCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var priceBtn: UIButton!
    @IBOutlet weak var locationBtn: UIButton!
    @IBOutlet weak var creatTimeLbl: UILabel!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var sex: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var edu: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var cons: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        changeBorderLineStyle(target: edu, borderColor: skyblue)
        changeBorderLineStyle(target: job, borderColor: .red)
        changeBorderLineStyle(target: cons, borderColor: .lightGray)
    }

    
}
