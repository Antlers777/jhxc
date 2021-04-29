//
//  MenuTableViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import UIKit

class MenuTableViewController: UIViewController {

    var menuTB = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
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
        
        self.navigationController?.navigationBar.barTintColor = .groupTableViewBackground
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "1.png"), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}

extension MenuTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = EditCell(style: .default, reuseIdentifier: "id")
            return cell
        case 1:
            let cell = MarkCell(style: .default, reuseIdentifier: "id")
            return cell
        default:
            let cell = UITableViewCell(style: .default, reuseIdentifier: "id")
            return cell
        }
    }
    
    //MARK: - 使cell的分割线与屏幕两端对齐
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "功能菜单"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
