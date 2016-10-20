//
//  GMImageCarouseViewLowMemory.swift
//  无限轮播
//
//  Created by Xinxibin on 16/10/19.
//  Copyright © 2016年 Xinxibin. All rights reserved.
//

import UIKit

class GMImageCarouseViewLowMemory: UIView {

    var scrollView:UIScrollView!
    var leftImageView:UIImageView!
    var centerImageView:UIImageView!
    var rightImageView:UIImageView!
    var imageData:[UIImage] = []
    var currentImageIndex:Int = 0
    var timer:Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadImageData()
        addSubViews()
        addImageViews()
        setDefaultImage()
        setTimer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadImageData()
        addSubViews()
        addImageViews()
        setDefaultImage()
        setTimer()
    }

    func loadImageData() {
        
        imageData = [
            UIImage(named: "10.jpg")!,
            UIImage(named: "11.jpg")!,
            UIImage(named: "12.jpg")!,
            UIImage(named: "13.jpg")!,
            UIImage(named: "14.jpg")!,
            UIImage(named: "15.jpg")!,
            UIImage(named: "16.jpg")!
        ]
    }
    
    func addSubViews() {
        
        scrollView = UIScrollView(frame: self.bounds)
        self.addSubview(scrollView)
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: self.bounds.size.width * 3, height: self.bounds.size.height)
        scrollView.setContentOffset(CGPoint(x:375,y:0), animated: false)
        scrollView.delegate = self
        
    }
    
    func addImageViews() {
        
        leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 375, height: 250))
        leftImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(leftImageView)
        
        centerImageView = UIImageView(frame: CGRect(x: 375, y: 0, width: 375, height: 250))
        centerImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(centerImageView)
        
        rightImageView = UIImageView(frame: CGRect(x: 375 * 2, y: 0, width: 375, height: 250))
        rightImageView.contentMode = .scaleAspectFit
        scrollView.addSubview(rightImageView)
        
    }
    
    func setDefaultImage() {
        
        leftImageView.image = imageData[imageData.count - 1]
        centerImageView.image = imageData[0]
        rightImageView.image = imageData[1]
        currentImageIndex = 0
    }
    
    func setTimer() {

        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.runImageTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func runImageTimer() {
        
        scrollView.setContentOffset(CGPoint(x:CGFloat(2) * self.bounds.size.width ,y: 0), animated: true)
        
    }
    
    func reloadImage() {
        
        var leftImageIndex = 0
        var rightImageIndex = 0
        
        let offset = scrollView.contentOffset
        
        if offset.x > 375 {
            currentImageIndex = (currentImageIndex + 1)%7
        }else if offset.x < 375 {
            currentImageIndex = (currentImageIndex + imageData.count - 1)%imageData.count
        }
        
        centerImageView.image = imageData[currentImageIndex]
        
        // 从新设置左右图片
        
        leftImageIndex = (currentImageIndex + imageData.count - 1)%imageData.count
        rightImageIndex = (currentImageIndex + 1)%imageData.count
        leftImageView.image = imageData[leftImageIndex]
        rightImageView.image = imageData[rightImageIndex]
        
    }
}


extension GMImageCarouseViewLowMemory:UIScrollViewDelegate {
    // 滑动停止
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        self.reloadImage()
        scrollView.setContentOffset(CGPoint(x:375,y:0), animated: false)
    }
    
    // 代码控制滑动
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.reloadImage()
        scrollView.setContentOffset(CGPoint(x:375,y:0), animated: false)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        setTimer()
    }
}







