//
//  LunTanListWithLocationCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/1.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SDWebImage
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
   
    var viewModel: LunTanDetialModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            if  viewModel.listCellType == 1 {
                infoView.isHidden = true
                self.cons.isHidden = true
                self.job.isHidden = true
                self.edu.isHidden = true
                self.priceBtn.isHidden = false
            }else{
                infoView.isHidden = false
                self.cons.isHidden = false
                self.job.isHidden = false
                self.edu.isHidden = false
                self.priceBtn.isHidden = true
            }
            if let title = viewModel.title {
                self.title.text = title
               
            }
            
            
            
            if let picture = viewModel.picture?.first{
                if  let imageURL = URL.init(string: picture) {
                self.img.sd_setImage(with:  imageURL as URL, placeholderImage: #imageLiteral(resourceName: "moren"))
                }
            }else {
                self.img.image = #imageLiteral(resourceName: "moren")
            }
            if let time = viewModel.time {
                self.creatTimeLbl.text = "\(time)"
            }
            if let sex = viewModel.sex{
                self.sex.text = sex
            }
            if let height = viewModel.height{
                 self.height.text = "\(height)cm"
            }
            if let age = viewModel.age{
                 self.age.text = "\(age)岁"
            }
            
            if let lable1 = viewModel.job_nature {
                self.label1.text = lable1
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        changeBorderLineStyle(target: edu, borderColor: skyblue)
        changeBorderLineStyle(target: job, borderColor: .red)
        changeBorderLineStyle(target: cons, borderColor: .lightGray)
    }

    
}
