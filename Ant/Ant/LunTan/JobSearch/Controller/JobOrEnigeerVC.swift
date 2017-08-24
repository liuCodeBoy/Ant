//
//  JobOrEnigeerVC.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/1.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class JobOrEnigeerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化选择界面
        self.view.backgroundColor = UIColor.white
        let jobBtnView = UIButton.init(frame: CGRect.init(x: 10, y: 10, width: screenWidth - 20, height: 0.3 * (screenWidth - 20)))
        jobBtnView.setBackgroundImage(#imageLiteral(resourceName: "secondhand_icon_want_job"), for: .normal)
        jobBtnView.addTarget(self, action: #selector(JobOrEnigeerVC.jobSearchFunc), for: .touchUpInside)
        jobBtnView.layer.cornerRadius = 5
        jobBtnView.layer.masksToBounds = true
    
        self.view.addSubview(jobBtnView)
        
        //招聘
        let inviteBtnView = UIButton.init(frame: CGRect.init(x: 10, y: 0.3 * (screenWidth - 20) + 20, width: screenWidth - 20, height: 0.3 * (screenWidth - 20)))
        inviteBtnView.setBackgroundImage(#imageLiteral(resourceName: "secondhand_icon_recruit"), for: .normal)
        inviteBtnView.addTarget(self, action: #selector(JobOrEnigeerVC.inviteFunc), for: .touchUpInside)
        inviteBtnView.layer.cornerRadius = 5
        inviteBtnView.layer.masksToBounds = true
        self.view.addSubview(inviteBtnView)
        
    }

    //跳转求职界面
    func jobSearchFunc() {
        let jobVC = JobSearchVC()
        jobVC.title = "求职"
        self.navigationController?.pushViewController(jobVC, animated: true)
    
    }
    
    //跳转招聘界面
    func inviteFunc() {
        let inviteJobVC = InviteJobVC()
        inviteJobVC.title = "招聘"
        self.navigationController?.pushViewController(inviteJobVC, animated: true)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
