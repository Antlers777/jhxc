//
//  MenuCell.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import UIKit
import SnapKit


class LocationCell: UITableViewCell {
    var title = UILabel()
    static var locationSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    func setUI() {
        title.text = "定位"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        
        
        self.contentView.addSubview(LocationCell.locationSwitch)
        LocationCell.locationSwitch.snp.makeConstraints({make in
            make.left.equalTo(title).offset(60)
            make.centerY.equalToSuperview()
        })
        
        self.selectionStyle = .none
        LocationCell.locationSwitch.addTarget(self, action: .locationSelector, for: .valueChanged)
        
    }
    
    @objc func location() {
        let selectorInterface = SelectorInterface()
        selectorInterface.location(bool: LocationCell.locationSwitch.isOn)
        UserDefaults.standard.set(LocationCell.locationSwitch.isOn, forKey: "location")
    }
    
}

class EditCell: UITableViewCell {
    var title = UILabel()
    static var editSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        
    }
    
    func setUI() {
        title.text = "量测"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        
        
        self.contentView.addSubview(EditCell.editSwitch)
        EditCell.editSwitch.snp.makeConstraints({make in
            make.left.equalTo(title).offset(60)
            make.centerY.equalToSuperview()
        })
        
        self.selectionStyle = .none
        EditCell.editSwitch.addTarget(self, action: .editSelector, for: .valueChanged)
        
    }
    
    @objc func edit() {
        let selectorInterface = SelectorInterface()
        selectorInterface.edit(bool: EditCell.editSwitch.isOn)
        UserDefaults.standard.set(EditCell.editSwitch.isOn, forKey: "edit")
    }

}
