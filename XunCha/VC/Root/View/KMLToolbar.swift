//
//  KMLToolbar.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/20.
//

import UIKit

class KMLToolbar: UIToolbar {

    let clearItem = UIBarButtonItem(title: "清除", style: .done, target: self, action: .clearKMLSelector)
    let addItem = UIBarButtonItem(title: "添加",style: .done, target: self, action: .addKMLSelector)
    let actionItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: .actionKMLSelector)
    let fixedItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let sketchDoneItem = UIBarButtonItem(title: "完成",style: .done, target: self, action: .completeSketchKMLSelector)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setItems([clearItem, fixedItem, addItem, fixedItem, actionItem], animated: true)
        tintColor = .systemBlue
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
