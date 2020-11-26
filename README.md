# SYCustomAlertViewController

[![CI Status](https://img.shields.io/travis/bsytt/SYCustomAlertViewController.svg?style=flat)](https://travis-ci.org/bsytt/SYCustomAlertViewController)
[![Version](https://img.shields.io/cocoapods/v/SYCustomAlertViewController.svg?style=flat)](https://cocoapods.org/pods/SYCustomAlertViewController)
[![License](https://img.shields.io/cocoapods/l/SYCustomAlertViewController.svg?style=flat)](https://cocoapods.org/pods/SYCustomAlertViewController)
[![Platform](https://img.shields.io/cocoapods/p/SYCustomAlertViewController.svg?style=flat)](https://cocoapods.org/pods/SYCustomAlertViewController)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

1.自定义AlertView，支持系统样式显示；文字，图片自定义显示；以及显示自定义视图

2.SYCustomViewTool是自定义视图样式控制类：

    class SYCustomViewTool: NSObject {
        var cornerRadius : CGFloat = 8
        //只设置左右边距，自定义视图需要做好约束根据子视图高度自适应
        var leftEdgeInset : CGFloat = 38
        var rightEdgeInset : CGFloat = -38
        //设置宽高
        var width : CGFloat?
        var height : CGFloat?
    }
3.定时消失或点击消失

    //是否支持点击屏幕隐藏
    var ishiddenTap = true
    //设置时间将在此事件后隐藏弹窗
    var hiddenTime : TimeInterval!{
      didSet{
          ishiddenTap = false
          let time = DispatchTime.now()+hiddenTime
          DispatchQueue.main.asyncAfter(deadline: time) {
              self.dismiss(animated: true) {
                  self.deleyBlock?()
              }
          }
      }
    }
## Requirements

## Installation

SYAlertController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SYCustomAlertViewController'
```

## Author

bsytt, 15893398117@163.com

## License

SYCustomAlertViewController is available under the MIT license. See the LICENSE file for more info.
