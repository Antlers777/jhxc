//
//  ImportKMLView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/24.
//

import Foundation
import UIKit
import SnapKit
import MJRefresh

extension KMLListViewController {
    func setImportKMLUI() {
        title = "KML 列表"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(backToRoot))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "本地导入", style: .done,  target: self, action: #selector(fromDocumentAddKKML))
        
//        importButton = UIButton()
//        view.addSubview(importButton)
//        importButton.snp.makeConstraints({make in
//            make.width.equalToSuperview().multipliedBy(0.8)
//            make.height.equalTo(40)
//            make.centerX.equalToSuperview()
//            make.top.equalToSuperview().offset(120)
//        })
//        importButton.backgroundColor = .systemGreen
//        importButton.setTitle("导入KML", for: .normal)
//        importButton.layer.cornerRadius = 10
//        importButton.addTarget(self, action: #selector(openPicker), for: .touchUpInside)
        
        kmlListTableView = UITableView()
        view.addSubview(kmlListTableView)
        kmlListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        kmlListTableView.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        })
        kmlListTableView.delegate = self
        kmlListTableView.dataSource = self
        kmlListTableView.tableFooterView = UIView()
        kmlListTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute:
                                            { [self] in
                                                
                                                kmlListTableView.reloadData()
                                                
                                                kmlListTableView.mj_header?.endRefreshing()
                                                
                                            })
        })
        kmlListTableView.mj_header?.beginRefreshing()
        
    }
}
