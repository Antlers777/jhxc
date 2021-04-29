//
//  MenuButton.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/28.
//

import Foundation
import UIKit

class MenuButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "more")?.reSizeImage(reSize: CGSize(width: 25, height: 25)), for: .normal)
        backgroundColor = .white
        layer.cornerRadius = 8
       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
