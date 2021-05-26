//
//  SingleKMLView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/24.
//

import Foundation
import UIKit

extension SingleKMLViewController {
    func setSingleKMLUI() {
        
        title = "操作KML"
        sinleKMLTableView = UITableView()
        view.addSubview(sinleKMLTableView)
        sinleKMLTableView.backgroundColor = .groupTableViewBackground
        sinleKMLTableView.delegate = self
        sinleKMLTableView.dataSource = self
        sinleKMLTableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        sinleKMLTableView.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        })
        sinleKMLTableView.tableFooterView = UIView()
    }
}
