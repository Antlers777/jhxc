//
//  EnlargeButton.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/11.
//

import UIKit

class EnlargeButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 4
        clipsToBounds = true
        setTitle("+", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = UIColor.white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class NarrowButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        clipsToBounds = true
        setTitle("-", for: .normal)
        setTitleColor(.systemBlue, for: .normal)
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
