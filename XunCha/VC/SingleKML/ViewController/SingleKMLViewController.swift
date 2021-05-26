//
//  SingleKMLViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/24.
//

import UIKit
import ArcGIS


class SingleKMLViewController: UIViewController {

    var sinleKMLTableView: UITableView!
    var fileName = String()
    var fileTime = String()
    var fileSize = String()
    
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSingleKMLUI()
        fileInfoLoad()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkSwitch()
    }
  

}
