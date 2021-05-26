//
//  MenuCell.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import UIKit
import SnapKit

class EditCell: UITableViewCell {
    var icon = UIImageView()
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
        icon.image = UIImage(named: "edit")
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints({make in
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        
        title.text = "草图量测"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        
        
        self.contentView.addSubview(EditCell.editSwitch)
        EditCell.editSwitch.snp.makeConstraints({make in
            make.left.equalTo(title).offset(120)
            make.centerY.equalToSuperview()
        })
        self.selectionStyle = .none
        EditCell.editSwitch.addTarget(self, action: .editSelector, for: .valueChanged)
        
    }
    
    @objc func edit() {
        let selectorInterface = SelectorInterface()
        selectorInterface.edit(bool: EditCell.editSwitch.isOn)
        UserDefaults.standard.set(EditCell.editSwitch.isOn, forKey: "edit")
        if EditCell.editSwitch.isOn {
            RootViewController.measureToolbar.isHidden = false
        } else {
            RootViewController.measureToolbar.isHidden = true
        }
        if MarkCell.markSwitch.isOn {
            MarkCell.markSwitch.isOn = false
            RootViewController.markSegmentC.isHidden = true
            UserDefaults.standard.set(MarkCell.markSwitch.isOn, forKey: "mark")
        }
        if KMLCell.kmlCellSwitch.isOn {
            KMLCell.kmlCellSwitch.isOn = false
            RootViewController.kmlToolbar.isHidden = true
            UserDefaults.standard.set(KMLCell.kmlCellSwitch.isOn, forKey: "kml")
        }
        
    }

}

class KMLCell: UITableViewCell {
    var icon = UIImageView()
    var title = UILabel()
    static var kmlCellSwitch = UISwitch()
    
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
        icon.image = UIImage(named: "kml")
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints({make in
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        
        title.text = "绘制KML"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        
        
        self.contentView.addSubview(KMLCell.kmlCellSwitch)
        KMLCell.kmlCellSwitch.snp.makeConstraints({make in
            make.left.equalTo(title).offset(120)
            make.centerY.equalToSuperview()
        })
        self.selectionStyle = .none
        KMLCell.kmlCellSwitch.addTarget(self, action: .kmlSelector, for: .valueChanged)
        
    }
    
    @objc func kml() {
        let selectorInterface = SelectorInterface()
        selectorInterface.edit(bool: KMLCell.kmlCellSwitch.isOn)
        UserDefaults.standard.set(KMLCell.kmlCellSwitch.isOn, forKey: "kml")
        if KMLCell.kmlCellSwitch.isOn {
            RootViewController.kmlToolbar.isHidden = false
        } else {
            RootViewController.kmlToolbar.isHidden = true
        }
        if EditCell.editSwitch.isOn {
            EditCell.editSwitch.isOn = false
            RootViewController.measureToolbar.isHidden = true
            UserDefaults.standard.set(EditCell.editSwitch.isOn, forKey: "edit")
        }
        if MarkCell.markSwitch.isOn {
            MarkCell.markSwitch.isOn = false
            RootViewController.markSegmentC.isHidden = true
            UserDefaults.standard.set(MarkCell.markSwitch.isOn, forKey: "mark")
        }
        
        
    }

}

class MarkCell: UITableViewCell {
    var icon = UIImageView()
    var title = UILabel()
    static var markSwitch = UISwitch()
    
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
        
        icon.image = UIImage(named: "mark")
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints({make in
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        
        title.text = "信息标注"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        
        
        self.contentView.addSubview(MarkCell.markSwitch)
        MarkCell.markSwitch.snp.makeConstraints({make in
            make.left.equalTo(title).offset(120)
            make.centerY.equalToSuperview()
        })
        
        self.selectionStyle = .none
        MarkCell.markSwitch.addTarget(self, action: .markSelector, for: .valueChanged)
        
    }
    
    @objc func mark() {
        
        let selectorInterface = SelectorInterface()
        selectorInterface.mark(bool: MarkCell.markSwitch.isOn)
        UserDefaults.standard.set(MarkCell.markSwitch.isOn, forKey: "mark")
        if MarkCell.markSwitch.isOn {
            RootViewController.markSegmentC.isHidden = false
        } else {
            RootViewController.markSegmentC.isHidden = true
        }
        if EditCell.editSwitch.isOn {
            EditCell.editSwitch.isOn = false
            RootViewController.measureToolbar.isHidden = true
            UserDefaults.standard.set(EditCell.editSwitch.isOn, forKey: "edit")
        }
        if KMLCell.kmlCellSwitch.isOn {
            KMLCell.kmlCellSwitch.isOn = false
            RootViewController.kmlToolbar.isHidden = true
            UserDefaults.standard.set(KMLCell.kmlCellSwitch.isOn, forKey: "kml")
        }
    }

}

class MarkListCell: UITableViewCell {
    var icon = UIImageView()
    var title = UILabel()
    
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
        
        icon.image = UIImage(named: "list")
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints({make in
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        
        title.text = "标注列表"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        self.selectionStyle = .none
        
    }
}

class SearchPlaceCell: UITableViewCell {
    var icon = UIImageView()
    var title = UILabel()
    
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
        icon.image = UIImage(named: "place")
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints({make in
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        
        title.text = "地点搜索"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        self.selectionStyle = .none
        
    }
}

class ImportKMLCell: UITableViewCell {
    var icon = UIImageView()
    var title = UILabel()
    
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
        
        icon.image = UIImage(named: "importkml")
        self.contentView.addSubview(icon)
        icon.snp.makeConstraints({make in
            make.width.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        })
        
        title.text = "导入KML"
        self.contentView.addSubview(title)
        title.snp.makeConstraints({make in
            make.width.equalTo(100)
            make.height.equalTo(40)
            make.left.equalTo(icon.snp.right).offset(20)
            make.centerY.equalToSuperview()
        })
        title.textColor = .gray
        self.selectionStyle = .none
        
    }
}
