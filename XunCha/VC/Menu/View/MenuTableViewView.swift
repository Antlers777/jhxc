//
//  MenuTableViewView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/14.
//

import Foundation
import UIKit
extension MenuTableViewController {
    func setButton() {
        
    }
}

extension MenuTableViewController {
    func setUI() {
        menuTB = UITableView(frame: UIScreen.main.bounds, style: .grouped)
        menuTB.delegate = self
        menuTB.dataSource = self
        menuTB.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        menuTB.tableFooterView = UIView()
        self.view.addSubview(menuTB)
        menuTB.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        })
        
        
        EditCell.editSwitch.isOn = UserDefaults.standard.bool(forKey: "edit")
        MarkCell.markSwitch.isOn = UserDefaults.standard.bool(forKey: "mark")
        KMLCell.kmlCellSwitch.isOn = UserDefaults.standard.bool(forKey: "kml")
        
        self.navigationController?.navigationBar.barTintColor = .groupTableViewBackground
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "1.png"), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
