//
//  AppDelegate.swift
//  AntDemo
//
//  Created by LiuXinQiang on 2017/6/8.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import AFNetworking
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var theme : UIColor = UIColor.red
    var fontSize : CGFloat = 1.0
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        let baseVC =  BaseTabBarVC()
        window?.rootViewController = baseVC
        window?.makeKeyAndVisible()

        
        let mgr = AFNetworkReachabilityManager.shared()
        mgr.setReachabilityStatusChange { (Status) -> Void in
            switch(Status){
            case AFNetworkReachabilityStatus.notReachable:
                SVProgressHUD.showError(withStatus: "网络错误")
                NetWorkTool.shareInstance.canConnect = false
                break
            case AFNetworkReachabilityStatus.reachableViaWiFi:
                SVProgressHUD.showSuccess(withStatus: "已接入wifi")
                NetWorkTool.shareInstance.canConnect = true
                break
            case AFNetworkReachabilityStatus.reachableViaWWAN:
                SVProgressHUD.showSuccess(withStatus: "已接入WWAN")
                NetWorkTool.shareInstance.canConnect = true
                break
            default:
                NetWorkTool.shareInstance.canConnect = true
                break
            }
        }
        mgr.startMonitoring()
        
        
        
        
      //读取偏好设置数据
        let deafult = UserDefaults.standard
        let font = deafult.float(forKey: "font")
        appdelgate?.fontSize  =  font != 0 ?  CGFloat(font) :  CGFloat(1.0)
        swizzlingMethod(clzz: UIViewController.self, oldSelector: #selector(UIViewController.viewWillAppear(_:)), newSelector: Selector(("viewDidLoadForChangeTitleColor")))
   
        
        
        
        
        
        ShareSDK.registerActivePlatforms(
            [
                SSDKPlatformType.typeSinaWeibo.rawValue,
                SSDKPlatformType.typeWechat.rawValue,
                SSDKPlatformType.typeQQ.rawValue
            ],
            onImport: {(platform : SSDKPlatformType) -> Void in
                switch platform
                {
                case SSDKPlatformType.typeSinaWeibo:
                    ShareSDKConnector.connectWeibo(WeiboSDK.classForCoder())
                case SSDKPlatformType.typeWechat:
                    ShareSDKConnector.connectWeChat(WXApi.classForCoder())
                case SSDKPlatformType.typeQQ:
                    ShareSDKConnector.connectQQ(QQApiInterface.classForCoder(), tencentOAuthClass: TencentOAuth.classForCoder())
                default:
                    break
                }
        },
            onConfiguration: {(platform : SSDKPlatformType , appInfo : NSMutableDictionary?) -> Void in
                switch platform
                {
                case SSDKPlatformType.typeSinaWeibo:
                    //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                    appInfo?.ssdkSetupSinaWeibo(byAppKey: "568898243",
                                                appSecret: "38a4f8204cc784f81f9f0daaf31e02e3",
                                                redirectUri: "http://www.sharesdk.cn",
                                                authType: SSDKAuthTypeBoth)
                    
                case SSDKPlatformType.typeWechat:
                    //设置微信应用信息
                    appInfo?.ssdkSetupWeChat(byAppId: "wx4868b35061f87885",
                                             appSecret: "64020361b8ec4c99936c0e3999a9f249")
                case SSDKPlatformType.typeQQ:
                    //设置QQ应用信息
                    appInfo?.ssdkSetupQQ(byAppId: "100371282",
                                         appKey: "aed9b0303e3ed1e27bae87c33761161d",
                                         authType: SSDKAuthTypeWeb)
                default:
                    break
                }
        })

        
        return true
    }
    
    
    class dynamic func getCurrentController() -> UIViewController? {
        
        guard let window = UIApplication.shared.windows.first else {
            return nil
        }
        
        var tempView: UIView?
        
        for subview in window.subviews.reversed() {
            
            
            if subview.classForCoder.description() == "UILayoutContainerView" {
                
                tempView = subview
                
                break
            }
        }
        if tempView == nil {
            
            tempView = window.subviews.last
        }
        var nextResponder = tempView?.next
        
        var next: Bool {
            return !(nextResponder is UIViewController) || nextResponder is UINavigationController || nextResponder is UITabBarController
        }
        while next{
            tempView = tempView?.subviews.first
            if tempView == nil {
                return nil
            }
            nextResponder = tempView!.next
        }
        return nextResponder as? UIViewController
    }




    func swizzlingMethod(clzz: AnyClass, oldSelector: Selector, newSelector: Selector) {
        let oldMethod = class_getInstanceMethod(clzz, oldSelector)
        let newMethod = class_getInstanceMethod(clzz, newSelector)
        method_exchangeImplementations(oldMethod, newMethod)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
   
        let mgr = AFNetworkReachabilityManager.shared()
        mgr.stopMonitoring()
        //偏好设置
        let userDefault =  UserDefaults.standard
        //存储数据
        userDefault.set(appdelgate?.fontSize, forKey: "font")
        //同步数据
        userDefault.synchronize()
       
    }


}

