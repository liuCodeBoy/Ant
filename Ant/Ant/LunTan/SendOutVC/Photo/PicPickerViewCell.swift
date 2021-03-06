
//
//  PicPickerViewCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/12.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class PicPickerViewCell: UICollectionViewCell {

      //MARK: - 控件的属性
    @IBOutlet weak var addPhotoBtn: UIButton!
    @IBOutlet weak var removePhotoBtn: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    // MARK:- 定义属性
    var image : UIImage? {
        didSet {
            if image != nil {
                imageView.image = image
                addPhotoBtn.isUserInteractionEnabled = false
                removePhotoBtn.isHidden = false
            } else {
                imageView.image = nil
                addPhotoBtn.isUserInteractionEnabled = true
                removePhotoBtn.isHidden = true
            }
        }
    }
  
    // 事件监听
    @IBAction func addPhotoClick(_ sender: Any) {
         print("addPhotoClic")
        
        NotificationCenter.default.post(name: PicPickerAddPhotoNote , object: nil)

    }
   
    @IBAction func removePhotoClick(_ sender: Any) {
        
        NotificationCenter.default.post(name: PicPickerRemovePhotoNote, object: sender)
    }
    

}
