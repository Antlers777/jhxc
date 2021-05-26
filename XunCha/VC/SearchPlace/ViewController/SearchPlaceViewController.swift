//
//  SearchPlaceViewCellViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/14.
//

import UIKit

class SearchPlaceViewController: UIViewController {
    var searchPlaceController = UISearchController()
    var searchPlaceTableView: UITableView!
    var searchPlaceArray: [String] = [String]() {
        didSet {
            searchPlaceTableView.reloadData()
        }
    }
    var placeDemo: [String] = ["北京市","天津市","上海市","重庆市","河北省","山西省","辽宁省","吉林省","黑龙江省","江苏省","浙江省","安徽省","福建省","江西省","山东省","河南省","湖北省"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchPlaceUI()
        searchPlaceTableView.delegate = self
        searchPlaceTableView.dataSource = self
    }
}
