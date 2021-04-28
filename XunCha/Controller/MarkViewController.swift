//
//  MarkViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/27.
//

import UIKit
import SnapKit


class MarkViewController: UIViewController {
    var name: UILabel!
    var markName: UITextField!
    var info: UILabel!
    var markInfo: UITextView!
    var callout: UILabel!
    var calloutSegmentedControl: UISegmentedControl!
    var saveBtn: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setMarkVCUI()

        
    }
    
    private func setMarkVCUI() {
        self.view.backgroundColor = .white
        self.title = "标记设置"
        
        name = UILabel()
        markName = UITextField()
        info = UILabel()
        markInfo = UITextView()
        callout = UILabel()
        calloutSegmentedControl = UISegmentedControl(items: ["显示备注", "不显示备注"])
        saveBtn = UIButton()
        
        view.addSubview(name)
        view.addSubview(markName)
        view.addSubview(info)
        view.addSubview(markInfo)
        view.addSubview(callout)
        view.addSubview(calloutSegmentedControl)
        view.addSubview(saveBtn)
        
        markInfo.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(120)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-60)
        })
        markInfo.layer.borderWidth = 1
        markInfo.layer.borderColor = UIColor.gray.cgColor
        
        callout.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(markInfo.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        })
        callout.text = "气泡类型"
        
        calloutSegmentedControl.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(callout.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        })
        
        
        saveBtn.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(calloutSegmentedControl.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        })
        saveBtn.backgroundColor = .systemBlue
        saveBtn.setTitle("保存", for: .normal)
        
        info.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.bottom.equalTo(markInfo.snp.top).offset(-0)
            make.centerX.equalToSuperview()
        })
        info.text = "标记备注"
        
        markName.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.bottom.equalTo(info.snp.top).offset(-40)
            make.centerX.equalToSuperview()
        })
        markName.layer.borderWidth = 1
        markName.layer.borderColor = UIColor.gray.cgColor
        
        name.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.bottom.equalTo(markName.snp.top).offset(-0)
            make.centerX.equalToSuperview()
        })
        name.text = "标记名称"
        calloutSegmentedControl.layer.masksToBounds = true
        calloutSegmentedControl.layer.cornerRadius = 2
        calloutSegmentedControl.layer.borderColor = UIColor.systemBlue.cgColor
        calloutSegmentedControl.layer.borderWidth = 1
        calloutSegmentedControl.tintColor = .systemBlue
        calloutSegmentedControl.layer.backgroundColor = UIColor.white.cgColor
        calloutSegmentedControl.tintColor = UIColor.systemBlue
        calloutSegmentedControl.selectedSegmentIndex = 1
        let attributes: NSDictionary = [NSAttributedString.Key.foregroundColor:UIColor.systemBlue,NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 13)]  as [AnyHashable : Any] as NSDictionary
        calloutSegmentedControl.setTitleTextAttributes(attributes as? [NSAttributedString.Key : Any], for: .normal)
        
        markInfo.isEditable = true
        markInfo.isSelectable = true
        markInfo.font = .systemFont(ofSize: 14)
        markInfo.textColor = .gray
        markInfo.textAlignment = .natural
        
        // 导航栏
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: .trashMarkSelector)
        
        //保存按钮 的事件
        saveBtn.addTarget(self, action: .saveMarkSelector, for: .touchUpInside)
        
        
        
        
        
        
        
        
    }
    
    // action
    
    @objc func trashMark(_ sender: Any) {
        guard saveBtn.isEnabled else {
            return
        }
        // 从数据库中删除标记
        
    }
    @objc func changeCalloutStyle(_ sender: Any) {
    }
    @objc func saveMark(_ sender: Any) { // save mark
        // 向数据库中添加该标记 成功则返回主页，否则提示失败
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
