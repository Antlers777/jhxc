//
//  LocationButton.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import UIKit

class LocationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: ""), for: .normal)
        setImage(UIImage(named: ""), for: .selected)
        setTitleColor(.red, for: .normal)
        backgroundColor = .cyan
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






