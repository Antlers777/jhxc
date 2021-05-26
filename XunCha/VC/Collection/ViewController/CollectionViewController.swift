//
//  CollectionViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/12.
//

import UIKit


class CollectionViewController: UIViewController {

    var collectTableView: UITableView!
    var searchController = UISearchController()
    // 过滤后的数据集
    var searchArray: [Mark] = [Mark]() {
        didSet {
            collectTableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        collectTableView.dataSource = self
        collectTableView.delegate = self
    }
}




