//
//  SYQualificationPopView.swift
//  DatianFinancial
//
//  Created by bsoshy on 2020/7/7.
//  Copyright © 2020 qiaoxy. All rights reserved.
//

import UIKit

class SYCustomView: UIView {
    //背景view
    let backView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initSubviews() {
        backgroundColor = UIColor.white

        self.addSubview(titleLab)
        self.addSubview(detailLab)
        self.addSubview(stateLab)
        self.addSubview(leftImgV)
        self.addSubview(centerImgV)
        self.addSubview(rightImgV)

        titleLab.snp.makeConstraints { (make) in
            make.top.equalTo(22)
            make.left.right.equalTo(self)
            make.height.equalTo(16)
        }
        detailLab.snp.makeConstraints { (make) in
            make.top.equalTo(titleLab.snp.bottom)
            make.left.right.equalTo(self)
            make.height.equalTo(16)
        }
        stateLab.snp.makeConstraints { (make) in
            make.top.equalTo(detailLab.snp.bottom).offset(30)
            make.left.right.equalTo(self)
            make.height.equalTo(16)
        }
        centerImgV.snp.makeConstraints { (make) in
            make.top.equalTo(stateLab.snp.bottom).offset(20)
            make.centerX.equalTo(self.titleLab.snp.centerX)
            make.height.width.equalTo(9)
            make.bottom.equalTo(self).offset(-22)
        }
        
        leftImgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(centerImgV.snp.centerY)
            make.right.equalTo(centerImgV.snp.left).offset(-6)
            make.height.width.equalTo(9)
        }
        
        rightImgV.snp.makeConstraints { (make) in
            make.centerY.equalTo(centerImgV.snp.centerY)
            make.left.equalTo(centerImgV.snp.right).offset(6)
            make.height.width.equalTo(9)
        }
        
        self.animate()
    }
    
    func animate() {

        let animation:CAKeyframeAnimation = CAKeyframeAnimation()
        animation.timeOffset = 0.3
        animation.duration = 0.6
        animation.keyPath = "opacity"
        animation.values = [0,1]
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.repeatCount = MAXFLOAT
        leftImgV.layer.add(animation, forKey: nil)
        
        let centerAnimation:CAKeyframeAnimation = CAKeyframeAnimation()
        centerAnimation.timeOffset = 0.15
        centerAnimation.duration = 0.6
        centerAnimation.keyPath = "opacity"
        centerAnimation.values = [0,1]
        centerAnimation.fillMode = .forwards
        centerAnimation.isRemovedOnCompletion = false
        centerAnimation.repeatCount = MAXFLOAT
        centerImgV.layer.add(centerAnimation, forKey: nil)
        
        let rightAnimation:CAKeyframeAnimation = CAKeyframeAnimation()
        rightAnimation.timeOffset = 0.0
        rightAnimation.duration = 0.6
        rightAnimation.keyPath = "opacity"
        rightAnimation.values = [0,1]
        rightAnimation.fillMode = .forwards
        rightAnimation.isRemovedOnCompletion = false
        rightAnimation.repeatCount = MAXFLOAT
        rightImgV.layer.add(rightAnimation, forKey: nil)

    }

    lazy var titleLab: UILabel = {
        let lab = UILabel(frame: .zero)
        lab.textAlignment = .center
        lab.textColor = .gray4Color
        lab.font = .systemFont(ofSize: 15)
        lab.text = "title"
        return lab
    }()
    lazy var detailLab: UILabel = {
        let lab = UILabel(frame: .zero)
        lab.textAlignment = .center
        lab.textColor = .gray4Color
        lab.font = .systemFont(ofSize: 15)
        lab.text = "Text"
        return lab
    }()
    lazy var stateLab: UILabel = {
        let lab = UILabel(frame: .zero)
        lab.textAlignment = .center
        lab.textColor = UIColor(hexString: "00A3E6")
        lab.font = .systemFont(ofSize: 15)
        lab.text = "waiting"
        return lab
    }()
    lazy var centerImgV: UIView = {
        let img = UIImageView(frame: .zero)
        img.backgroundColor = UIColor(hexString: "45C0F2")
        img.layer.cornerRadius = 9/2
        img.alpha = 0
        return img
    }()
    lazy var leftImgV: UIView = {
        let img = UIImageView(frame: .zero)
        img.backgroundColor = UIColor(hexString: "A3E4FF")
        img.layer.cornerRadius = 9/2
        img.alpha = 0
        return img
    }()
    lazy var rightImgV: UIView = {
        let img = UIImageView(frame: .zero)
        img.backgroundColor = UIColor(hexString: "00A3E6")
        img.layer.cornerRadius = 9/2
        img.alpha = 0
        return img
    }()
}
