//
//  RootToolView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import UIKit
import SnapKit

class RootToolView: UIView {
//    var toolView = UIView()
    var backOffBtn = UIButton()
    var sureItBtn = UIButton()
    var saveItBtn = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect(x: 0, y: -60, width: UIScreen.main.bounds.width, height: 60)
        backgroundColor = .white
        
        self.addSubview(backOffBtn)
        self.addSubview(sureItBtn)
        self.addSubview(saveItBtn)
        
        backOffBtn.snp.makeConstraints({make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(40)
            make.centerY.equalToSuperview()
        })
        backOffBtn.layer.cornerRadius = 10
        backOffBtn.backgroundColor = .systemBlue
        backOffBtn.setTitle("撤退", for: .normal)
        
        sureItBtn.snp.makeConstraints({make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        })
        sureItBtn.layer.cornerRadius = 10
        sureItBtn.backgroundColor = .systemBlue
        sureItBtn.setTitle("确认", for: .normal)
        
        saveItBtn.snp.makeConstraints({make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.right.equalToSuperview().offset(-40)
            make.centerY.equalToSuperview()
        })
        saveItBtn.layer.cornerRadius = 10
        saveItBtn.backgroundColor = .systemBlue
        saveItBtn.setTitle("保存", for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
