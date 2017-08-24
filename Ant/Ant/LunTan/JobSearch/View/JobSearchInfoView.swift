//
//  JobSearchInfoView.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/1.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
fileprivate let  cellID = "cellID"

    class JobSearchInfoView: UITableView,UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
        var  tableView = UITableView()
        var  textField  : UITextField?
        
        override init(frame: CGRect, style: UITableViewStyle) {
            super.init(frame: frame, style: style)
            
            tableView = self
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsHorizontalScrollIndicator = false
            tableView.showsVerticalScrollIndicator = false
            tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            
            return 3
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            var  row  :  Int = 0
            switch  section  {
            case 0:
                row = 1
            case 1:
                row = 7
            case 2:
                row = 6
            default:
                row = 0
            }
            return row
        }
        
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            
            let headerView = UIView()
            headerView.backgroundColor = UIColor.init(red: 247 / 255, green: 247 / 255, blue: 247 / 255, alpha: 1.0)
            let titleLabel = UILabel()
            titleLabel.text  = "联系人方式"
            titleLabel.textColor = UIColor.lightGray
            titleLabel.sizeToFit()
            titleLabel.center.y = 20
            titleLabel.frame.origin.x = 20
            headerView.addSubview(titleLabel)
            
            switch section {
            case 0:
                titleLabel.text = "消息标题"
            case 1:
                titleLabel.text  = "基本信息"
            case 2:
                titleLabel.text  = "联系人方式"
            default:
                titleLabel.text = ""
                
            }
            return headerView
        }
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            
            var view = UIView.init()
            
            switch section {
            case 1:
                
                let detailView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: screenWidth, height: 180))
                detailView.backgroundColor = UIColor.white
                let detailScriptLable  = UILabel.init(frame: CGRect.init(x: 15, y: 10, width: 100, height: 20))
                detailScriptLable.text = "详尽描述"
                detailView.addSubview(detailScriptLable)
                let detailDescriptFiled =  CustomTextField.init(frame: CGRect.init(x: 10, y: 30, width: screenWidth - 20 , height: 140), placeholder: "字数在150字以内", clear: true, leftView: nil, fontSize: 12)
                detailDescriptFiled?.backgroundColor = UIColor.init(red: 240 / 255, green: 240 / 255, blue: 240 / 255, alpha: 1.0)
                        self.textField = detailDescriptFiled
                detailView.addSubview(detailDescriptFiled!)
                view = detailView
            default:
                break
            }
            return view
            
        }
        
        override func touchesShouldBegin(_ touches: Set<UITouch>, with event: UIEvent?, in view: UIView) -> Bool {
            self.endEditing(true)
            return true
        }
        
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            var  heightForFooterInSection = 0.0
            switch section {
            case 1:
                heightForFooterInSection = 180
                //        case 2:
            //            heightForFooterInSection = 100
            default:
                heightForFooterInSection = 0.0
            }
            return CGFloat(heightForFooterInSection)
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 50
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var  cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            if  cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
            }
            cell?.accessoryType = .disclosureIndicator
            if indexPath.section == 0 {
                cell?.textLabel?.text = "标题"
            }else if indexPath.section == 1 {
                
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "所在区域"
                case 1:
                    cell?.textLabel?.text  = "行业"
                case 2:
                    cell?.textLabel?.text = "工作性质"
                case 3:
                    cell?.textLabel?.text = "学历"
                case 4:
                    cell?.textLabel?.text = "签证"
                case 5:
                    cell?.textLabel?.text = "经验"
                case 6:
                    cell?.textLabel?.text = "期望工资"
                default:
                    cell?.textLabel?.text = ""
                }
            }else if indexPath.section == 2 {
                switch indexPath.row {
                case 0:
                    cell?.textLabel?.text = "联系人名称"
                case 1:
                    cell?.textLabel?.text  = "联系电话"
                case 2:
                    cell?.textLabel?.text = "微信"
                case 3:
                    cell?.textLabel?.text = "QQ"
                case 4:
                    cell?.textLabel?.text = "邮箱"
                default:
                    cell?.textLabel?.text = ""
                }
                
            }
            
            return cell!
            
            
        }
        
    }
    




