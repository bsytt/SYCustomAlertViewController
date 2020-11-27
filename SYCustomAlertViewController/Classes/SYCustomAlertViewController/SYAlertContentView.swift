//
//  SYAlertContentView.swift
//  Nongjibang
//
//  Created by qiaoxy on 2019/7/10.
//  Copyright © 2019 qiaoxy. All rights reserved.
//

import UIKit
import SnapKit

class SYAlertContentView: UIView {

    var statusImageView: UIImageView!
    
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    var cancelButton: UIButton!
    var doneButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    init() {
        super.init(frame: .zero)
        initSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews() {
        self.backgroundColor = UIColor.white
        
        statusImageView = UIImageView()
        statusImageView.contentMode = .scaleAspectFit
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.gray2Color
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 19)
        self.addSubview(titleLabel)
        
        messageLabel = UILabel()
        messageLabel.textColor = UIColor.gray4Color
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(messageLabel)
        
        let titleStackView = UIStackView(arrangedSubviews: [statusImageView,titleLabel,messageLabel])
        titleStackView.distribution = .equalSpacing
        titleStackView.axis = .vertical
        titleStackView.spacing = 15
        self.addSubview(titleStackView)
        
        let stackContentView = UIView()
        stackContentView.backgroundColor = UIColor(hexString: "#e6e6e6")
        
        cancelButton = UIButton(type: .custom)
        cancelButton.setTitleColor(UIColor.gray6Color, for: .normal)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        cancelButton.backgroundColor = .grayCColor
        cancelButton.backgroundColor = .white
        
        doneButton = UIButton(type: .custom)
        doneButton.setTitleColor(UIColor.themeColor, for: .normal)
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneButton.setTitle("确定", for: .normal)
        doneButton.backgroundColor = UIColor.white
        
        let stackView = UIStackView(arrangedSubviews: [cancelButton,doneButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 0.5
        stackContentView.addSubview(stackView)
        self.addSubview(stackContentView)
        
        stackContentView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(45)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(stackContentView).offset(1)
            make.left.bottom.right.equalTo(stackContentView)
        }
        
        titleStackView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(15)
            make.left.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(stackContentView.snp.top).offset(-18)
        }
        
    }
    
}
