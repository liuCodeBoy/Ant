//
//  HuseNeedRentCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/20.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class LunTanListWithAvatarCell: UITableViewCell {
    
    var avatarClick: (() -> Void)?
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var createTime: UILabel!
    
    @IBOutlet weak var lable1: UILabel!
    @IBOutlet weak var lable2: UILabel!
    @IBOutlet weak var lable3: UILabel!

  
    override func awakeFromNib() {
        super.awakeFromNib()
        changeBorderLineStyle(target: lable1, borderColor: .lightGray)
        changeBorderLineStyle(target: lable2, borderColor: skyblue)
        changeBorderLineStyle(target: lable3, borderColor: .red)

        
        let tap = UITapGestureRecognizer(target: self, action: #selector(avatarDidClicked))
        avatar.addGestureRecognizer(tap)

    }
    
    func avatarDidClicked() {
        if avatarClick != nil {
          avatarClick!()
        }
    }
    
    
    var viewModel: LunTanDetialModel? {
        didSet {
            if let title = viewModel?.title {
                self.title.text = title
            }
            if let name = viewModel?.contact_name {
                self.name.text = name
            }
            if let time = viewModel?.time {
                self.createTime.text = "\(time)"
            }
            if let lable1 = viewModel?.house_type {
                self.lable1.text = lable1
            }
            if let lable2 = viewModel?.house_source {
                self.lable2.text = lable2
            }
        }
    }
    
}
