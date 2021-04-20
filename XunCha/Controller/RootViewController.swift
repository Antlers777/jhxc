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

class RootViewController: UIViewController {
    
//    var valueBtn = UIButton()
//    var toolBar = UIView()
//    var segmentedControl = UISegmentedControl(items: ["点","线","手绘线","图形","手绘图形"])
    
//    var undoBtn = UIButton()
//    var redoBtn = UIButton()
//    var clearBtn = UIButton()
    
//    private var sketchEditor: AGSSketchEditor!
    
    static var measureToolbar: MeasureToolbar!
    lazy var selectorInterface: SelectorInterface = SelectorInterface()
    lazy var locationButton: LocationButton = LocationButton() // 定位按钮
    
    var basemap: AGSBasemap?  // 地图view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        setMap()
        setUI()
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

extension RootViewController {
    func setMap() {
        mapView = AGSMapView(frame: .zero)
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints{(make) in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview()
        }
        mapView.map = AGSMap()
        basemap = AGSBasemap(baseLayer: jhyxLayer)
        mapView.map?.basemap = basemap!
        
        if(CLLocationManager.authorizationStatus() != .denied) {
            print("应用拥有定位权限")
        }else {
            let aleat = UIAlertController(title: "打开定位开关", message:"定位服务未开启,请进入系统设置>隐私>定位服务中打开开关,并允许App使用定位服务", preferredStyle: .alert)
            let tempAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            }
            let callAction = UIAlertAction(title: "立即设置", style: .default) { (action) in
                let url = NSURL.init(string: UIApplication.openSettingsURLString)
                if(UIApplication.shared.canOpenURL(url! as URL)) {
                    UIApplication.shared.openURL(url! as URL)
                }
            }
            aleat.addAction(tempAction)
            aleat.addAction(callAction)
            self.present(aleat, animated: true, completion: nil)
        }
   
        
        //取消水印
        mapView.isAttributionTextVisible = false
        do {
            try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud3339743773,none,5H80TK8EL9GYF5KHT005")
        } catch  {
            
        }
        
        mapView.backgroundGrid?.color = .white
        mapView.backgroundGrid?.gridLineWidth = 0
        
        RootViewController.measureToolbar = MeasureToolbar(mapView: mapView)
        RootViewController.measureToolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(RootViewController.measureToolbar)
        RootViewController.measureToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        RootViewController.measureToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        RootViewController.measureToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        RootViewController.measureToolbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    func setUI() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "菜单", style: .done, target: self, action: .menuSelector)
        RootViewController.measureToolbar.isHidden = true
        mapView.sketchEditor?.stop()
    }
        
}

extension RootViewController {
    
    @objc func menu() {
        let menu = SideMenuNavigationController(rootViewController: MenuTableViewController())
        
        menu.menuWidth = 150
        menu.isNavigationBarHidden = false //侧栏菜单显示导航栏
        // 将其作为默认的左侧菜单
        SideMenuManager.default.leftMenuNavigationController = menu
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)

    }
}


