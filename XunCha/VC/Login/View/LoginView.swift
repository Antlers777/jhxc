//
//  LoginView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/18.
//

import Foundation
import UIKit
import SnapKit


extension LoginViewController {
    func setLoginUI() {
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 255/255, alpha: 1)
        
        helloLabel = UILabel()
        view.addSubview(helloLabel)
        helloLabel.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        })
        //要显示的文字
        let str = "亲爱的用户你好\n感谢您对静海巡查App的关注\n在使用之前需要获得您的手机号\n请在下方输入并点击保存"
        //通过富文本来设置行间距
        let paraph = NSMutableParagraphStyle()
        //将行间距设置为28
        paraph.lineSpacing = 20
        //样式属性集合
        let attributes = [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15),
                          NSAttributedString.Key.paragraphStyle: paraph]
        helloLabel.attributedText = NSAttributedString(string: str, attributes: attributes)
        helloLabel.lineBreakMode = .byWordWrapping
        helloLabel.numberOfLines = 0
        helloLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        helloLabel.textColor = UIColor(red: 100/255, green: 100/255, blue: 100/255, alpha: 1)
        
        iphoneNumber = UITextField()
        view.addSubview(iphoneNumber)
        iphoneNumber.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(46)
            make.centerX.equalToSuperview()
            make.top.equalTo(helloLabel.snp.bottom).offset(60)
        })
        iphoneNumber.clearButtonMode = .always
        iphoneNumber.textAlignment = .center
        iphoneNumber.layer.cornerRadius = 10
        iphoneNumber.backgroundColor = .white
        iphoneNumber.layer.shadowColor = UIColor.gray.cgColor
        iphoneNumber.layer.shadowOffset = CGSize(width: 3, height: 3)
        iphoneNumber.layer.shadowRadius = 10
        iphoneNumber.layer.shadowOpacity = 1
        
        iphoneNumberVaild = UILabel()
        view.addSubview(iphoneNumberVaild)
        iphoneNumberVaild.text = "手机号格式不正确,请输入正确格式"
        iphoneNumberVaild.textColor = .systemRed
        iphoneNumberVaild.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(20)
            make.centerX.equalToSuperview()
            make.top.equalTo(iphoneNumber.snp.bottom).offset(10)
        })
        
        clearButton = UIButton()
        view.addSubview(clearButton)
        clearButton.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(46)
            make.left.equalTo(iphoneNumber.snp.left)
            make.top.equalTo(iphoneNumber.snp.bottom).offset(60)
        })
        clearButton.setTitle("清 空", for: .normal)
        clearButton.backgroundColor = .systemBlue
        clearButton.layer.cornerRadius = 10
        clearButton.layer.shadowColor = UIColor.gray.cgColor
        clearButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        clearButton.layer.shadowRadius = 10
        clearButton.layer.shadowOpacity = 1
        
        saveButton = UIButton()
        view.addSubview(saveButton)
        saveButton.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.48)
            make.height.equalTo(46)
            make.right.equalTo(iphoneNumber.snp.right)
            make.top.equalTo(iphoneNumber.snp.bottom).offset(60)
        })
        saveButton.setTitle("保 存", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.layer.cornerRadius = 10
        saveButton.layer.shadowColor = UIColor.gray.cgColor
        saveButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        saveButton.layer.shadowRadius = 10
        saveButton.layer.shadowOpacity = 1
    }
}
