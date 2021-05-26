//
//  ImportKMLViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/24.
//

import UIKit
import ArcGIS

class KMLListViewController: UIViewController {
    
    var importButton: UIButton!
    var kmlListTableView: UITableView!
    var kmlFileArray: [String] = []
    var fileName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        setImportKMLUI()
        fileLoad()
        
    }
}
