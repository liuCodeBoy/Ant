//
//  HouseRentViewCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/4.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SDWebImage
class HouseRentViewCell: UITableViewCell {
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkInTime: UILabel!
    @IBOutlet weak var house_type: UILabel!
    @IBOutlet weak var house_source: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var topLabel: UILabel!
    
    
    var viewModel: HouseRentStatus? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            
            title.text = viewModel.title
            if let time = viewModel.time {
                
                checkInTime.text = "入住时间 : \(time)"
            
            }
            if let price = viewModel.price {
               
                self.price.text = "$" + price

            }
            
            if let source = viewModel.house_type {
                house_source.setTitleWithSpace(source)

            }
            if let type = viewModel.house_type {
                house_type.setTitleWithSpace(type)

            }
            if let picture = viewModel.picture?.first{
                
                self.picture.sd_setImage(with:  NSURL.init(string: picture)! as URL, placeholderImage: #imageLiteral(resourceName: "moren"))
            }else {
                self.picture.image = #imageLiteral(resourceName: "moren")
            
             }
            
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        topLabel.isHidden = true
        changeBorderLineStyle(target: house_type, borderColor: .lightGray)
        changeBorderLineStyle(target: house_source, borderColor: skyblue)
        changeBorderLineStyle(target: topLabel, borderColor: .red)
    }
    
}
