//
//  MenuModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/14.
//

import Foundation
import UIKit
import ArcGIS

extension MenuTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = EditCell(style: .default, reuseIdentifier: "id")
            return cell
        case 1:
            let cell = KMLCell(style: .default, reuseIdentifier: "id")
            return cell
        case 2:
            
            let cell = ImportKMLCell(style: .default, reuseIdentifier: "id")
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .gray
            return cell
        case 3:
            let cell = MarkCell(style: .default, reuseIdentifier: "id")
            return cell
        case 4:
            let cell = MarkListCell(style: .default, reuseIdentifier: "id")
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .gray
            return cell
        case 5:
            let cell = SearchPlaceCell(style: .default, reuseIdentifier: "id")
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .gray
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            break
        case 2:
            let kml = KMLListViewController()
            let nav = UINavigationController(rootViewController: kml)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
//            //要分享的文本
//            let text = "这是我要分享的一些文字。"
//
//            //设置活动视图控制器
//            let textToShare = [text]
//            let activityViewController = UIActivityViewController.init(activityItems: textToShare, applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView = self.view //这样iPad就不会崩溃
//            //呈现视图控制器
//            self.present(activityViewController ,animated: true, completion:nil)
//            break
        case 3: break
        case 4:
            let collect = CollectionViewController()
            let nav = UINavigationController(rootViewController: collect)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        case 5:
            let searchPlace = SearchPlaceViewController()
            let nav = UINavigationController(rootViewController: searchPlace)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        default:
            break
        }
    }
}

