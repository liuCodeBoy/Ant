//
//  OthersJoinVC.swift
//  Ant
//
//  Created by Weslie on 2017/8/23.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class OthersJoinVC: UIViewController {

    @IBOutlet weak var joinTableView: UITableView!
    
    @IBAction func backBtn(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        joinTableView.delegate = self
        joinTableView.dataSource = self
        

        // Do any additional setup after loading the view.
    }
}

extension OthersJoinVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "joinCell")
        return cell!
    }
}
