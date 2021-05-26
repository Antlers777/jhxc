//
//  CollectionView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/12.
//

import Foundation
import UIKit
import MJRefresh

extension CollectionViewController {
    func setUI() {
        self.title = "标注列表"
        
        collectTableView = UITableView()
        collectTableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "id")
        self.view.addSubview(collectTableView)
        collectTableView.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        })
        collectTableView.tableFooterView = UIView()
        collectTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            DispatchQueue.main.asyncAfter(deadline: .now()+1.5, execute:
                                            { [self] in
                                                
                                                collectTableView.reloadData()
                                                
                                                collectTableView.mj_header?.endRefreshing()
                                                
                                            })
        })
        collectTableView.mj_header?.beginRefreshing()
        
        // 导航栏设置
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: .colloectBackSelector)
        
        // 配置搜索控制器
        searchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title="取消"
            collectTableView.tableHeaderView = controller.searchBar
            return controller
        })()
        searchController.searchBar.placeholder = "搜索标注"
        
        
    }
    
}
