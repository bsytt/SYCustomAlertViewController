//
//  SYAlertViewController.swift
//  SYTexDemo
//
//  Created by bsoshy on 2020/7/22.
//  Copyright © 2020 bsy. All rights reserved.
//

import UIKit
typealias SYAlertViewControllerBlock = ()->()

class SYCustomViewTool: NSObject {
    var cornerRadius : CGFloat = 8
    //只设置左右边距，自定义视图需要做好约束根据自视图高度自适应
    var leftEdgeInset : CGFloat = 38
    var rightEdgeInset : CGFloat = -38
    //设置宽高
    var width : CGFloat?
    var height : CGFloat?
    var backColor : UIColor = .white
    
    var alpha : CGFloat = 1
    
}
class SYAlertViewController: UIViewController {
    
    private var cTitle: String?
    private var cMessage: String?
    private var mutibStr: String?
    private var cImage: UIImage?
    private var cCancel: String?
    private var cDone: String?
    var customViewTool = SYCustomViewTool()
    //标题字体
    var titleFont: UIFont?{
        didSet{
            alertView.titleLabel.font = titleFont
        }
    }
    //内容字体
    var messageFont: UIFont?{
        didSet{
            alertView.messageLabel.font = messageFont
        }
    }
    //取消按钮颜色
    var cancelColor: UIColor?{
        didSet{
            guard let color = cancelColor else {
                return
            }
            alertView.cancelButton.setTitleColor(color, for: .normal)
        }
    }
    
    //确定按钮颜色
    var doneColor: UIColor?{
        didSet{
            guard let color = doneColor else {
                return
            }
            alertView.doneButton.setTitleColor(color, for: .normal)
        }
    }
    //是否支持点击屏幕隐藏
    var ishiddenTime = true
    //设置时间将在此事件后隐藏弹窗
    var hiddenTime : TimeInterval!{
        didSet{
            ishiddenTime = false
            let time = DispatchTime.now()+hiddenTime
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.dismiss(animated: true) {
                    self.deleyBlock?()
                }
            }
        }
    }
    
    let backView = UIView()
    var alertView: SYAlertContentView!
    var customView : UIView?
    var backColor : UIColor = UIColor(white: 0, alpha: 0.5)
    var alpha : CGFloat?
    private var cancelBlock: SYAlertViewControllerBlock?
    private var doneBlock: SYAlertViewControllerBlock?
    private var deleyBlock: SYAlertViewControllerBlock?

    static func alert(title cTitle:String? = nil,message cMessage:String? = nil,mutibStr:String?=nil,statusImage cStatusImage:UIImage? = nil,customView : UIView?=nil,done:String? = "确定",cancel:String? = "取消",doneAction doneBlock:SYAlertViewControllerBlock?,cancelBlock:SYAlertViewControllerBlock?,deleyBlock:SYAlertViewControllerBlock?) -> SYAlertViewController {
        let alertVC = SYAlertViewController(title: cTitle, message: cMessage,mutibStr:mutibStr, statusImage: cStatusImage,customView: customView, cancel: cancel, done: done, doneAction: doneBlock, cancelBlock: cancelBlock, deleyBlock: deleyBlock)
        alertVC.transitioningDelegate = alertVC
        alertVC.modalPresentationStyle = .custom
        return alertVC
    }
    
    private init(title cTitle:String? = nil,message cMessage:String? = nil,mutibStr:String?=nil,statusImage cStatusImage:UIImage? = nil,customView : UIView?=nil,cancel:String? = nil,done:String? = nil,doneAction doneBlock:SYAlertViewControllerBlock?,cancelBlock:SYAlertViewControllerBlock?,deleyBlock:SYAlertViewControllerBlock?) {
        super.init(nibName: nil, bundle: nil)
        self.cTitle = cTitle
        self.cMessage = cMessage
        self.mutibStr = mutibStr
        self.cImage = cStatusImage
        self.customView = customView
        self.cDone = done
        self.cCancel = cancel
        self.doneBlock = doneBlock
        self.cancelBlock = cancelBlock
        self.deleyBlock = deleyBlock
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initSubViews()
    }
    
    func initSubViews() {
        //遮罩
        if let alpha = alpha {
            backView.alpha = alpha
        }
        backView.backgroundColor = backColor
        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        if let customView = customView {
            addCustomView(customView)
        }else {
            addAlertView()
        }
    }
    
    func addCustomView(_ customView:UIView) {
        customView.layer.cornerRadius = customViewTool.cornerRadius
        customView.alpha = customViewTool.alpha
        customView.backgroundColor = customViewTool.backColor
        view.addSubview(customView)
        customView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            if let width = self.customViewTool.width  {
                make.width.equalTo(width)
            }else {
                make.left.equalTo(view).offset(customViewTool.leftEdgeInset)
                make.right.equalTo(view).offset(customViewTool.rightEdgeInset)
            }
            if let height = customViewTool.height {
                make.height.equalTo(height)
            }
        }
        customView.layoutIfNeeded()
    }
    
    func addAlertView() {
        //弹框
        alertView = SYAlertContentView()
        if let alertTitle = cTitle {
            alertView.titleLabel.text = alertTitle
        }else{
            alertView.titleLabel.isHidden = true
        }
         if mutibStr != nil {
             if let alertMessage = cMessage {
                 let range = alertMessage.range(of: mutibStr ?? "")
                 let str = alertMessage.changeTextColor(text: alertMessage, color: .red, range: NSRange(range!, in: alertMessage))
                 alertView.messageLabel.attributedText = str
             }else{
                 alertView.messageLabel.isHidden = true
             }
         }else {
             if let alertMessage = cMessage {
                 alertView.messageLabel.text = alertMessage
             }else{
                 alertView.messageLabel.isHidden = true
             }
         }
        if let alertImage = cImage {
            alertView.statusImageView.image = alertImage
        }else{
            alertView.statusImageView.isHidden = true
        }
        if let alertCancel = cCancel {
            alertView.cancelButton.setTitle(alertCancel, for: .normal)
        }else{
            alertView.cancelButton.isHidden = true
        }
        
        if let alertDone = cDone {
            alertView.doneButton.setTitle(alertDone, for: .normal)
        }else{
            alertView.doneButton.isHidden = true
        }
        
        alertView.cancelButton.addTarget(self, action: #selector(cancleButtonClick), for: .touchUpInside)
        alertView.doneButton.addTarget(self, action: #selector(doneButtonClick), for: .touchUpInside)
        alertView.layer.cornerRadius = 8
        alertView.layer.masksToBounds = true
        view.addSubview(alertView)
        
        alertView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.left.equalTo(view).offset(38)
            make.right.equalTo(view).offset(-38)
        }
        alertView.layoutIfNeeded()
    }
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if ishiddenTime {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func cancleButtonClick() {
        self.dismiss(animated: true, completion: nil)
        self.cancelBlock?()
    }
    
    @objc func doneButtonClick() {
        self.dismiss(animated: true, completion: nil)
        self.doneBlock?()
    }
}
extension SYAlertViewController:UIViewControllerTransitioningDelegate{
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SYAlertAnimation()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SYAlertAnimation()
    }
    
}
