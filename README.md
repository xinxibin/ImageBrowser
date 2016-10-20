
## 无限轮播+自动无限轮播

此工程中有两个实现方式，上面的是一种，下面的是另外一种。先上个图

![](http://oahmyhzk1.bkt.clouddn.com/image/gif/carousel.gif)

<!--more-->

## 实现原理

### 第一种

* 在UIScrollView上创建 n + 2 张图片 如图
![](http://oahmyhzk1.bkt.clouddn.com/image/pngCarousel1.png)

* 只用在UIScrollView代理方法中处理

```
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

```


### 第二种
* 在UIScrollView中，只创建三个UIImageView，改变scrollView的 contentOffset，来保证滑动结束之后展示的是中间的那个图片。
![](http://oahmyhzk1.bkt.clouddn.com/image/pngCarousel2.png)

* 需要单独写一个方法来更新展示的图片

```
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
```
* 回调中的处理

```
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

```

## 使用方法 

两种方法都一样 

```
    func setView2() {
        bgView2 = GMImageCarouseViewLowMemory(frame: CGRect(x: 0, y: 300, width: 375, height: 250))
        self.view.addSubview(bgView2)
    }
    
    func setView1() {
        bgView1 = GMImageCarouselView(frame: CGRect(x: 0, y: 30, width: 375, height: 250))
        self.view.addSubview(bgView1)
    }

```

## 两种实现原理优缺

* 相比第一种方法，第二种在内存上更好一点，占用内存更低，也建议使用第二种。
* 第二种也更适合多张图片处理

## 写在最后

[博客地址](https://xinxibin.com/2016/10/20/Swift-Image-browser/)

## 相关文章

[iOS 开发笔记](http://www.cnblogs.com/colinhou/p/4594459.html)
[Auto Layout Club](https://autolayout.club/2015/10/29/%E8%87%AA%E5%B7%B1%E5%8A%A8%E6%89%8B%E9%80%A0%E6%97%A0%E9%99%90%E5%BE%AA%E7%8E%AF%E5%9B%BE%E7%89%87%E8%BD%AE%E6%92%AD/)

