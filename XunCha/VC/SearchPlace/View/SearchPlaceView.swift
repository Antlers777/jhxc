//
//  SearchPlaceView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/18.
//

import Foundation
import UIKit

extension SearchPlaceViewController {
    func setSearchPlaceUI() {
        view.backgroundColor = .white
        title = "地点搜索"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: .done, target: self, action: .searchPlaceBackToCollectSelector)
        
        searchPlaceTableView = UITableView()
        searchPlaceTableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        view.addSubview(searchPlaceTableView)
        searchPlaceTableView.snp.makeConstraints({make in
            make.edges.equalToSuperview()
        })
        searchPlaceTableView.tableFooterView = UIView()
        
        searchPlaceController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .minimal
            controller.searchBar.sizeToFit()
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title="取消"
            searchPlaceTableView.tableHeaderView = controller.searchBar
            return controller
        })()
        searchPlaceController.searchBar.placeholder = "搜索地点"
        
    }
}
