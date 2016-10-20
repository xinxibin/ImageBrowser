//
//  ViewController.swift
//  无限轮播
//
//  Created by Xinxibin on 16/10/19.
//  Copyright © 2016年 Xinxibin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bgView1:GMImageCarouselView!
    var bgView2:GMImageCarouseViewLowMemory!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setView1()
        setView2()
       
    }

    func setView2() {
        // 这里有七张图片
        bgView2 = GMImageCarouseViewLowMemory(frame: CGRect(x: 0, y: 300, width: 375, height: 250))
        self.view.addSubview(bgView2)
        
    }
    
    func setView1() {
        // 三张图片的循环 占用内存 35M 左右
        
        bgView1 = GMImageCarouselView(frame: CGRect(x: 0, y: 30, width: 375, height: 250))
        self.view.addSubview(bgView1)

    }
    
    
    
    

}

