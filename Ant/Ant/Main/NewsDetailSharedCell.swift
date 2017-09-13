//
//  NewsDetailSharedCell.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/7/27.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit

class NewsDetailSharedCell: UITableViewCell {
    
    var shareURL = URL(string: "https://github.com/iWeslie")
    
    var shareText: String = "分享的内容"
    var shareTitle: String = "分享的标题"
    var thumbImage: UIImage = #imageLiteral(resourceName: "icon_weixin")

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var interestBtn: UIButton!
    @IBOutlet weak var statement: UILabel!
    @IBAction func momentShare(_ sender: Any) {
        let shareParams = NSMutableDictionary()
        
        shareParams.ssdkSetupWeChatParams(byText: shareText, title: shareTitle, url: shareURL, thumbImage: thumbImage, image: nil, musicFileURL: nil, extInfo: nil, fileData: nil, emoticonData: nil, type: .auto, forPlatformSubType: .subTypeWechatTimeline)
        
        ShareSDK.share(platform: .subTypeWechatTimeline, parameters: shareParams)
    }
    
    @IBAction func weChatFriendAction(_ sender: Any) {
        let shareParams = NSMutableDictionary()
        shareParams.ssdkSetupWeChatParams(byText: shareTitle, title: shareTitle, url: shareURL, thumbImage: thumbImage, image: nil, musicFileURL: nil, extInfo: nil, fileData: nil, emoticonData: nil, type: .webPage, forPlatformSubType: .subTypeWechatSession)
        ShareSDK.share(platform: .subTypeWechatSession, parameters: shareParams)
    }
    
    @IBAction func weiBoAction(_ sender: Any) {
        let shareParams = NSMutableDictionary()
        shareParams.ssdkSetupShareParams(byText: shareText, images : nil, url : shareURL, title : shareTitle, type : SSDKContentType.auto)
        ShareSDK.share(platform: .typeSinaWeibo, parameters: shareParams)
    }
    @IBAction func moreSharedAction(_ sender: Any) {
        let shareParames = NSMutableDictionary()
        shareParames.ssdkSetupShareParams(byText: shareText, images: nil, url: shareURL, title: shareTitle, type: .auto)
        
        SSUIShareActionSheetStyle.setShareActionSheetStyle(.simple)
        ShareSDK.showShareActionSheet(view: sender as! UIView, shareParams: shareParames)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
