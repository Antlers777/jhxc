//
//  CollectionModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/12.
//

import Foundation
import UIKit
import ArcGIS
extension CollectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive {
            return searchArray.count
        } else {
            return Mark.rows().count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CollectionTableViewCell(style: .default, reuseIdentifier: "id")
        if searchController.isActive {
            cell.name.text = searchArray[indexPath.row].name
            cell.info.text = searchArray[indexPath.row].info
            cell.time.text = searchArray[indexPath.row].time
            cell.showPhoto.tag = indexPath.row
            cell.goButton.tag = indexPath.row
            cell.showPhoto.addTarget(self, action: .showPhotoSelector, for: .touchUpInside)
            cell.goButton.addTarget(self, action: .goTheMarkSelector, for: .touchUpInside)
            return cell
        } else {
            cell.name.text = Mark.rows()[indexPath.row].name
            cell.info.text = Mark.rows()[indexPath.row].info
            cell.time.text = Mark.rows()[indexPath.row].time
            cell.showPhoto.tag = indexPath.row
            cell.goButton.tag = indexPath.row
            cell.showPhoto.addTarget(self, action: .showPhotoSelector, for: .touchUpInside)
            cell.goButton.addTarget(self, action: .goTheMarkSelector, for: .touchUpInside)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collectTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard !searchController.isActive else {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let name = Mark.rows()[indexPath.row].name
            let mark = Mark.rows(filter: "name='\(name)'").first
            mark?.delete()
            collectTableView.mj_header?.beginRefreshing()
            graphicsOverlay.graphics.removeAllObjects()
            let draw = DrawGraphics()
            draw.selectAllMark()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension CollectionViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchArray = Mark.rows().filter{ (mark) -> Bool in
            return mark.name.lowercased().contains((searchController.searchBar.text?.lowercased())!)
        }
    }
}

extension CollectionViewController {
    @objc func collectBack() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showPhoto(sender: UIButton) {
        // 获取
        let mark = Mark.rows()[sender.tag]
        let show = ShowMarkViewController()
        show.x = Double(mark.x)!
        show.y = Double(mark.y)!
        show.sr = mark.sr
        searchController.dismiss(animated: true, completion: nil)
        self.present(show, animated: true, completion: nil)
    }
    
    @objc func goTheMark(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        let mark = Mark.rows()[sender.tag]
        let point: AGSPoint = AGSPoint(x: Double(mark.x)!, y: Double(mark.y)!, spatialReference: AGSSpatialReference(wkid: mark.sr))
        let viewpoint = AGSViewpoint.init(center: point, scale: 1e1)
        mapView.setViewpoint(viewpoint, duration: 2.0, curve: .easeInOutQuart, completion: nil)
    }
}


extension Selector {
    static let colloectBackSelector = #selector(CollectionViewController.collectBack)
    // 查看照片
    static let showPhotoSelector = #selector(CollectionViewController.showPhoto)
    // 视角移到标注处
    static let goTheMarkSelector = #selector(CollectionViewController.goTheMark)
}
