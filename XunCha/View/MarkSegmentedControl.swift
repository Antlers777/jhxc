//
//  MarkSegmentedControl.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/28.
//

import UIKit




class MarkSegmentedControl: UISegmentedControl {

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        
        selectedSegmentIndex = 2
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
