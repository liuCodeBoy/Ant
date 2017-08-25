//
//  NetWorkTool.swift
//  E
//
//  Created by LiuXinQiang on 17/3/25.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import AFNetworking
import SVProgressHUD

// MARK:- 定义枚举类型
enum RequestType : String {
      case GET = "GET"
      case POST = "POST"
}

enum LunTanType : String {
    case house = "house"
    case seek = "seek"
    case job = "job"
    case car = "car"
    case secondHand = "market"
    case cityWide = "friends"
}

class NetWorkTool: AFHTTPSessionManager {
    
    var  canConnect : Bool = true
    
    //let 是线程安全的,创建单例
    static let shareInstance : NetWorkTool = {
        let  tools = NetWorkTool()
        tools.responseSerializer.acceptableContentTypes?.insert("text/html")
       return tools
    }()
    
    }


// MARK:-  封装请求方法
extension NetWorkTool {
    
    func request(_ method: RequestType, urlString : String, parameters:[String :AnyObject]?, finished:@escaping (_ result : AnyObject?, _ error : Error?)->()){
        
        if(canConnect == true){
            //定义成功的回调闭包
            let successCallBack = {  (task: URLSessionDataTask?, result: Any?) -> Void in
                finished(result  as AnyObject, nil )
            }
            //定义失败的回调闭包
            let failureCallBack = { (task: URLSessionDataTask?, error: Error?) -> Void in
                finished(nil, error )
            }
            //发送网络请求
            if method == RequestType.GET {
                self.get(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            } else {
                self.post(urlString, parameters: parameters, progress: nil, success: successCallBack, failure: failureCallBack)
            }
        } else {
        }
    }
 }

// MARK:- 用户登录请求
extension NetWorkTool {
    
    //用户登录
    func UserLogin( _ account:String, password:String , type : String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
      //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/login/login"
      //2.获取请求参数
        let parameters = ["account" : account , "password": password , "type" : type]
      //3.发送请求参数
       request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
        //获取字典数据
        guard let resultDict = result as? [String : AnyObject] else {
            finished(nil, error)
            return
         }
        //将数组数据回调给外界控制器
        finished(resultDict, error)
        }
    }
    
    
    //用户注册
    func UserRegister( _ account:String, password:String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/login/register"
        //2.获取请求参数
        let parameters = ["account" : account , "password": password]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
}

// MARK:- 新闻
extension NetWorkTool {

    //轮播图
    func  rotationList( finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/news/rotationList"
        //2.获取请求参数
        let parameters = ["cate_id" : 2]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }

    //天气接口
    func weather( _ city : String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/news/weather"
        //2.获取请求参数
        let parameters = ["city" : city]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    //新闻分类接口
    func newsCate( _ type : String , finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/news/newsCate"
        //2.获取请求参数
        let parameters = ["type" : type]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //获取新闻列表
    func  newsList( _ cate_id : String , p : String ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/news/newsList"
        //2.获取请求参数
        let parameters = ["cate_id" : cate_id , "p" : p ]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }
    
    //新闻详情
    func newsDet( _ id : String ,finished:@escaping (_ result : [String : AnyObject]? ,_ error:Error?) ->()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/news/newsDet"
        //2.获取请求参数
        let parameters = ["id" : 169 ]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
        }
    }

}

// MARK:- 论坛
extension NetWorkTool {
    
    // MARK:- 论坛发布信息
    func publishInfo(_ token: String,
                     cate_1: LunTanType.RawValue,
                     cate_2 : String,
                     rootpath : String,
                     savepath : LunTanType.RawValue,
                     image  : UIImage,
                     title : String,
                     finished: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> ()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/user/publish"
        self.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        //2.获取请求参数
        let parameters = ["cate_1": cate_1, "cate_2" : cate_2 , "rootpath" : rootpath , "savepath" : savepath , "title" : title ] as [String : Any]
        //3.发送请求参数
        post(urlString, parameters: parameters, constructingBodyWith: { [weak self](formData) in
            if let imageData = UIImageJPEGRepresentation(image, 0.5){
            let imageName =  self?.getNowTime()
             formData.appendPart(withFileData: imageData, name: "image", fileName: imageName! , mimeType: "image/png")
            }

        }, progress: { (Progress) in
            
        }, success: { (URLSessionDataTask, success) in         //获取字典数据
            guard let resultDict = success as? [String : AnyObject] else {
                return
            }
            finished(resultDict , nil)
            //将数组数据回调给外界控制器
        }) { (URLSessionDataTask, error) in
            finished(nil , error)
        }
    }
    
    func getNowTime() -> (String){
      let date = NSDate.init(timeIntervalSinceNow: 0)
      let a  =  date.timeIntervalSince1970
      let timesString = "\(a).png"
      return  timesString
    }

    // MARK:- 论坛信息列表查询均
    func infoList(VCType cate_1: LunTanType, p: Int,  finished: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> ()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/forum/forumList"
        //2.获取请求参数
        let parameters = ["cate_1" : cate_1.rawValue, "p": p] as [String : AnyObject]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
          
        }
    }
    
    // MARK:- 论坛详情信息
    func infoDetial(VCType cate_1: LunTanType, id: Int,  finished: @escaping (_ result: [String: AnyObject]?, _ error: Error?) -> ()) {
        //1.获取请求的URLString
        let urlString = "http://106.15.199.8/jraz/api/forum/forumInfo"
        //2.获取请求参数
        let parameters = ["cate_1" : cate_1.rawValue, "id": id] as [String : AnyObject]
        //3.发送请求参数
        request(.POST, urlString: urlString, parameters: parameters as [String : AnyObject]) { (result, error) -> () in
            //获取字典数据
            guard let resultDict = result as? [String : AnyObject] else {
                finished(nil, error)
                return
            }
            //将数组数据回调给外界控制器
            finished(resultDict, error)
            
        }
    }

    
    
    
}

