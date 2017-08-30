//
//  SelfDetialViewController.swift
//  Ant
//
//  Created by Weslie on 2017/8/28.
//  Copyright © 2017年 Weslie. All rights reserved.
//

import UIKit

class SelfDetialViewController: UIViewController {
    
    var changeClosure: ((_ output: String?) -> Void)?
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var inputText: UITextField!
    
    @IBAction func backBtn(_ sender: UIButton) {

        self.navigationController?.popViewController(animated: true)
        self.changeClosure!(inputText.text)
        self.inputText.sizeToFit()
    }
    
    
    @IBOutlet weak var back: UIButton!
    
    var info: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        addCustomStyle()
        inputText.text = self.info

    }
    
    func addCustomStyle() {
        self.backgroundView.layer.cornerRadius = 5
        self.backgroundView.layer.masksToBounds = true
        self.back.layer.cornerRadius = 5
        self.back.layer.masksToBounds = true
    }


}
