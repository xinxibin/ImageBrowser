//
//  GMImageCarouselView.swift
//  无限轮播
//
//  Created by Xinxibin on 16/10/19.
//  Copyright © 2016年 Xinxibin. All rights reserved.
//

/*
    实现原理 创建 n + 2张图片
    
    1.看这个 loadImageData() 方法 就知道 了 
    2.
 
 
 
 */

import UIKit

class GMImageCarouselView: UIView {

    var scrollView:UIScrollView!
    
    var dataArr:[UIImage] = []
    /// 记录当前展示的是第几个，默认2。0
    var pageIndex:CGFloat = 2.0
    
    var timer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadImageData()
        addSubviews()
        addImageViews()
        setTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadImageData()
        addSubviews()
        addImageViews()
        setTimer()
    }

    
    func loadImageData() {
        dataArr = [
            UIImage(named: "3.png")!,
            UIImage(named: "1.png")!,
            UIImage(named: "2.png")!,
            UIImage(named: "3.png")!,
            UIImage(named: "1.png")!
        ]

    }

    
    func addSubviews() {
        
        scrollView = UIScrollView(frame: self.bounds)
        scrollView.contentSize = CGSize(width:self.bounds .size.width * CGFloat(dataArr.count), height: 250)
        scrollView.backgroundColor = UIColor.red
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        self.addSubview(scrollView)
    }
    
    func addImageViews() {
        
        for (index,item) in dataArr.enumerated() {
            let imageView = UIImageView(image: item)
            imageView.frame = CGRect(x: self.bounds.size.width * CGFloat(index), y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
            scrollView.addSubview(imageView)
        }
        
        scrollView.setContentOffset(CGPoint(x: 375, y: 0), animated: false)
    }
    
    
    func setTimer() {
        
        timer =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.runTimerPage), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func runTimerPage() {
        
        if pageIndex == CGFloat(dataArr.count) {
            pageIndex = 2.0
        }
        
        scrollView.setContentOffset(CGPoint(x:self.bounds.size.width * CGFloat(pageIndex), y:0), animated: true)
      
//        print("runtimerpage:  \(pageIndex)")

    }
    
}


extension GMImageCarouselView:UIScrollViewDelegate {
    
    // 拖动视图结束执行
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 滑动结束的时候调用（动画执行完毕）
        let index = scrollView.contentOffset.x / self.bounds.size.width
        pageIndex = index + 1
        
        if index == 0.0 {
            scrollView.setContentOffset(CGPoint(x:self.bounds.size.width * CGFloat(dataArr.count - 2), y:0), animated: false)
        }else if index == 4.0 {
            scrollView.setContentOffset(CGPoint(x:self.bounds.size.width , y:0), animated: false)
        }
        
        print("index: \(index)  and  pageIndex: \(pageIndex)")
    }
    
    // 代码控制滑动执行方法
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {

        let index = scrollView.contentOffset.x / self.bounds.size.width
        
        pageIndex = index + 1

        if index == 0.0 {
            scrollView.setContentOffset(CGPoint(x:self.bounds.size.width * CGFloat(dataArr.count - 2), y:0), animated: false)
        }else if index == 4.0 {
            scrollView.setContentOffset(CGPoint(x:self.bounds.size.width , y:0), animated: false)
        }
    }
    // 开始移动scrollView
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    // 移动结束
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        self.setTimer()
        
    }
}



