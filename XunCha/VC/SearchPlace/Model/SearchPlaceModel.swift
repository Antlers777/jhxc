//
//  SearchPlaceModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/18.
//

import Foundation
import UIKit
import ArcGIS

extension SearchPlaceViewController {
    @objc func searchPlaceBackToCollect() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchPlaceViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchPlaceArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "id")
        cell.textLabel?.text = searchPlaceArray[indexPath.row]
        cell.detailTextLabel?.text = "查看"
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let point = AGSPoint(x: 509244.471, y: 4308571.996, spatialReference: AGSSpatialReference(wkid: 4548))
        // 将符号添加此处坐标
//        let url = URL(string: "https://sampleserver6.arcgisonline.com/arcgis/rest/services/Recreation/FeatureServer/0/images/e82f744ebb069bb35b234b3fea46deae")!
//
//        let campsiteSymbol = AGSPictureMarkerSymbol(url: url)
//
//        // optionally set the size (if not set, the size in pixels of the image will be used)
//        campsiteSymbol.width = 30
//        campsiteSymbol.height = 30
//        let graphic = AGSGraphic(geometry: point, symbol: campsiteSymbol, attributes: nil)
//        graphicsOverlayPlace.graphics.add(graphic)
        
        
        let imageName = "icon"
        let pinSymbol = AGSPictureMarkerSymbol(image: UIImage(named: imageName)!.reSizeImage(reSize: CGSize(width: 80, height: 80)))
        
        let graphic = AGSGraphic(geometry: point, symbol: pinSymbol, attributes: nil)
        
//        let symbol = AGSSimpleMarkerSymbol(style: .circle, color: UIColor(red: 216/255, green: 30/255, blue: 6/255, alpha: 1), size: 10)
//        let graphic2 = AGSGraphic(geometry: point, symbol: symbol, attributes: nil)
//        graphicsOverlayPlace.graphics.add(graphic2)
        graphicsOverlayPlace.graphics.removeAllObjects()
        graphicsOverlayPlace.graphics.add(graphic)
        mapView.setViewpointCenter(point, scale: 20000.0, completion: nil)
        self.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension SearchPlaceViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        searchPlaceArray = placeDemo.filter{ (place) -> Bool in
            return place.lowercased().contains((searchPlaceController.searchBar.text?.lowercased())!)
        }
    }
    
    
}

extension Selector {
    static let searchPlaceBackToCollectSelector = #selector(SearchPlaceViewController.searchPlaceBackToCollect)
}
