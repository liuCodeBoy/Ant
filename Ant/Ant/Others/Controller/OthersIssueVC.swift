//
//  OthersIssueVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/23.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class OthersIssueVC: UIViewController {
    
    //定义模型数组
    var pushModelArr  = [UserPushModel]()
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var issueTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        issueTableView.delegate = self
        issueTableView.dataSource = self
        loadSelfData()
    }
    
    func loadSelfData() -> () {
        //加载数据
        let   token = UserInfoModel.shareInstance.account?.token!
        if token != nil {
            NetWorkTool.shareInstance.userRelated(token: token!, uid: -1, cate: "publish", p: 1, finished: { [weak self] (userInfo, error) in
                if error == nil {
                    let code  = userInfo?["code"] as? Int
                    if code == 200 {
                        let result  = userInfo?["result"]
                        let resultList = result?["list"] as? [NSDictionary]
                        for dict in  resultList!{
                            let model = UserPushModel.mj_object(withKeyValues: dict)
                            self?.pushModelArr.append(model!)
                        }
                    }
                }else{
                    print("服务器错误")
                }
            })
        }
        
    }

}


extension OthersIssueVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "issueCell")
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 0.0001
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
}
