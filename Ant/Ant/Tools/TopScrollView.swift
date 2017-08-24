//
//  TopScrollView.swift
//  Ant
//
//  Created by LiuXinQiang on 2017/8/18.
//  Copyright © 2017年 LiuXinQiang. All rights reserved.
//

import UIKit
import SDWebImage

class TopScrollView: UIView, UIScrollViewDelegate
{
    //views
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.bounces = false
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.frame.size = CGSize.init(width: 100, height: 20)
        pageControl.defersCurrentPageDisplay = true
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    
    //time interval of auto scrolling
    private let kAutoScrollInterval: TimeInterval = 5.0
    private var newsTitle : String?
    private var frameWidth: CGFloat!
    private var frameHeight: CGFloat!
    private var scrollTimer: Timer? = nil
    lazy    var titleArr  = [String]()
    //image clicked action, parameter: the index of clicked image
    var imageClickedHandler: ((Int) -> Void)?
    
    var images: [URL] = [] {
        didSet {
            layoutIfNeeded()
        }
    }
    
    var isAutoScroll = true
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    convenience init(rotaionArray : [NewsRotationModel], frame: CGRect, isAutoScroll: Bool) {
        self.init()
        var urlArray: [URL] = [URL]()
        var titleArray : [String] = [String]()
        for model in (rotaionArray) {
            let url = URL(string: model.picture!)
            let title = model.title
            titleArray.append(title!)
            urlArray.append(url!)
        }
        self.images = urlArray
        self.titleArr = titleArray
        self.frame = frame
        self.isAutoScroll = isAutoScroll
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        frameWidth = self.bounds.size.width
        frameHeight = self.bounds.size.height
        scrollView.frame = self.bounds
        pageControl.center.x = self.center.x +  140
        pageControl.center.y = self.bounds.size.height - 17
        updateScrollView()
        updateImageViews()
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        self.addSubview(scrollView)
        self.addSubview(pageControl)
    }
    
    //MARK: - Action
    
    @objc private func tapOnImageView(recoginzer: UITapGestureRecognizer) {
        if let indexOfImage = recoginzer.view?.tag {
            self.imageClickedHandler?(indexOfImage)
        }
    }
    
    @objc private func doAutoScroll() {
       

        var offset = scrollView.contentOffset.x + frameWidth
        
        //scroll to the first image
        if offset > CGFloat(self.images.count) * frameWidth {
            offset = frameWidth
        }
        
        scrollView.setContentOffset(CGPoint(x: offset, y:0), animated: true)
        
        let page =  abs(Int((offset - frameWidth) / frameWidth))
        pageControl.currentPage = page
    }
    
    //MARK: - Public
    
    func startAutoScroll() {
        if scrollTimer != nil || images.count < 2 || !isAutoScroll{
            return
        }
        
        let timer = Timer.scheduledTimer(timeInterval: kAutoScrollInterval, target: self, selector: #selector(doAutoScroll), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoopMode.commonModes)
        
        self.scrollTimer = timer
    }
    
    
    func stopAutoScroll() {
        self.scrollTimer?.invalidate()
        self.scrollTimer = nil
    }
    
    // MARK: - Private
    
    private func updateScrollView() {
        pageControl.numberOfPages = images.count
        
        // 计算contentSize
        if images.count >= 2 {
            scrollView.contentSize = CGSize(width: CGFloat(images.count + 2) * frameWidth, height: 0)
            scrollView.contentOffset.x = frameWidth
        }
        else {
            scrollView.contentSize = CGSize(width: CGFloat(images.count) * frameWidth, height: 0)
            scrollView.contentOffset.x = 0
        }
    }
    
    private func updateImageViews() {
        
        //在首尾各多添加一张图片使之形成环
        let numOfImgviews = images.count >= 2 ? images.count + 2 : images.count
        
        for i in 0..<numOfImgviews {
            let scrollImageView = UIView(frame: CGRect(x: CGFloat(i) * frameWidth, y: 0, width: frameWidth, height: frameHeight))
            let imageView = UIImageView(frame: CGRect(x:0, y: 0, width: frameWidth, height: frameHeight))
            imageView.isUserInteractionEnabled = true
            imageView.contentMode = .scaleAspectFill
           
            //图片标题
            let  titleView  = UIView(frame: CGRect.init(x:0, y: 125, width: screenWidth, height: 35))
            titleView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
            let   textLable = UILabel.init(frame: CGRect.init(x: 10, y: 0, width: screenWidth, height: 35))
            textLable.font = UIFont.systemFont(ofSize: 13)
            textLable.textAlignment = .left
            textLable.textColor = UIColor.white
           

            if i <= 0 {
                imageView.sd_setImage(with: self.images.last, placeholderImage: #imageLiteral(resourceName: "moren"))
                textLable.text = self.titleArr.last
                imageView.tag = numOfImgviews - 1
            }
            else if i >= numOfImgviews - 1 {
                imageView.sd_setImage(with: self.images.first, placeholderImage: #imageLiteral(resourceName: "moren"))
                textLable.text = self.titleArr.first
                imageView.tag = 0
            }
            else {
                imageView.sd_setImage(with: self.images[i - 1], placeholderImage: #imageLiteral(resourceName: "moren"))
                textLable.text = self.titleArr[i - 1]
                imageView.tag = i - 1
            }
            
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnImageView))
            imageView.addGestureRecognizer(tapGesture)
            scrollImageView.addSubview(imageView)
        
            titleView.addSubview(textLable)
            scrollImageView.addSubview(titleView)
            self.scrollView.addSubview(scrollImageView)
        
        }
    }
    
    //MARK: - UIScrollView delegate
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var offset = scrollView.contentOffset.x
        
        if self.images.count >= 2 {
            //scroll to the last imageView
            if offset > CGFloat(self.images.count) * frameWidth {
                scrollView.contentOffset.x = frameWidth
                offset = scrollView.contentOffset.x
            }
            
            //scroll to the first imageView
            if offset < frameWidth {
                scrollView.contentOffset.x = CGFloat(self.images.count) * frameWidth
                offset = scrollView.contentOffset.x
            }
        }
        
        //计算页数
        let page =  abs(Int((offset - frameWidth) / frameWidth))
        pageControl.currentPage = page
    }
    

    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScroll()
    }
}

