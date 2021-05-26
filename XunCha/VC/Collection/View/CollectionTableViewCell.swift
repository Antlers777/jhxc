//
//  CollectionTableViewCell.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/12.
//

import UIKit
import SnapKit


class CollectionTableViewCell: UITableViewCell {
    
    var name: UILabel!
    var info: UILabel!
    var time: UILabel!
    var showPhoto: UIButton!
    var goButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        name = UILabel()
        info = UILabel()
        time = UILabel()
        showPhoto = UIButton()
        goButton = UIButton()
        
        self.frame = CGRect.zero
        self.addSubview(name)
        self.addSubview(info)
        self.addSubview(time)
        self.contentView.addSubview(goButton)
        self.contentView.addSubview(showPhoto)
        
        name.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
        })
        name.font = UIFont.systemFont(ofSize: 17.0, weight: .heavy)
        name.text = "学府麦谷"
        
        info.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.right.equalToSuperview().offset(-120)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(name.snp.bottom).offset(10)
        })
        info.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        info.textColor = .gray
        info.text = "研发基地,共有十五名研发人员."
        // 20 20 10 20 10 20 10
        time.snp.makeConstraints({make in
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(info.snp.bottom).offset(10)
        })
        time.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        time.textColor = .gray
        time.text = "2021-02-03"
        
        showPhoto.snp.makeConstraints({make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(20)
        })
        showPhoto.backgroundColor = .systemGreen
        showPhoto.setTitle("查看照片", for: .normal)
        showPhoto.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        showPhoto.layer.cornerRadius = 4
        
        goButton.snp.makeConstraints({make in
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-20)
        })
        goButton.backgroundColor = .systemGreen
        goButton.setTitle("查看地点", for: .normal)
        goButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        goButton.layer.cornerRadius = 4
        
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
