//
//  RootViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/12.
//

import UIKit
import ArcGIS
import SnapKit
import Alamofire
import SideMenu
import ArcGISToolkit
import MBProgressHUD
import RxSwift
import RxCocoa

var calloutGraphic = AGSGraphic()
class RootViewController: UIViewController {
    
    static let kmlToolbar = KMLToolbar()
    var kmlDocument = AGSKMLDocument()
    var kmlStyle: AGSKMLStyle?
    let colors: [(String, UIColor)] = [
        ("红色", .red),
        ("黄色", .yellow),
        ("白色", .white),
        ("紫色", .purple),
        ("橙色", .orange),
        ("紫红色", .magenta),
        ("亮灰色", .lightGray),
        ("灰色", .gray),
        ("黑灰色", .darkGray),
        ("绿色", .green),
        ("蓝绿色", .cyan),
        ("棕色", .brown),
        ("蓝色", .blue),
        ("黑色", .black)
    ]
    
    
    var scalebar: Scalebar? // 比例尺
    var mark = MarkMenu.normal
    static var measureToolbar: MeasureToolbar!
    static let markSegmentC = UISegmentedControl(items: ["★","✘","文"])
    let compass = Compass(mapView: mapView)
    var basemap: AGSBasemap?  // 地图view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        
        setMap()
        setUI()
        
        let draw = DrawGraphics()
        draw.selectAllMark()
        
        updateToolbarItems()
        mapView.sketchEditor = AGSSketchEditor()
        clearKML()
//        let fileURL = try! FileManager.default
//            .url(for: .documentDirectory, in: .userDomainMask,
//                 appropriateFor: nil, create: true)
//            .appendingPathComponent("/KML/jhkml.kmz")
//        let dataset = AGSKMLDataset(url: fileURL)
//        let layer = AGSKMLLayer.init(kmlDataset: dataset)
//        mapView.map?.operationalLayers.removeAllObjects()
//        mapView.map?.operationalLayers.add(layer)
//        let kmlBundlePath = Bundle.main.path(forResource:"kml", ofType:"bundle")!
//        let kmlBundle = Bundle.init(path: kmlBundlePath)!
//        let path = kmlBundle.path(forResource:"jhkml", ofType:"kmz", inDirectory:"file")!
//        let url = URL.init(fileURLWithPath: path)
//        let dataset = AGSKMLDataset(url: url)
//        let layer = AGSKMLLayer.init(kmlDataset: dataset)
//        mapView.map?.operationalLayers.add(layer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
         //update content inset for mapview
        if (EditCell.editSwitch.isOn) {
            mapView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: RootViewController.measureToolbar.frame.height, right: 0)
        } else {

        }
        
    }
}







