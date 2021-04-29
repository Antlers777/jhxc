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
var goon = false

class RootViewController: UIViewController {
    var mark = MarkMenu.normal
    static var measureToolbar: MeasureToolbar!
    static let markSegmentC = UISegmentedControl(items: ["⭐️","❌","✏️"])
    let compass = Compass(mapView: mapView)
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
        //basemap = AGSBasemap(baseLayer: jhyxLayer)
        if goon {
            mapView.map?.basemap = AGSBasemap(baseLayer: jhyxLayer)
        }
        
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
        
        //取消放大镜
        mapView.interactionOptions.isMagnifierEnabled = false
        
        // 测量工具
        RootViewController.measureToolbar = MeasureToolbar(mapView: mapView)
        RootViewController.measureToolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(RootViewController.measureToolbar)
        RootViewController.measureToolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        RootViewController.measureToolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        RootViewController.measureToolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        RootViewController.measureToolbar.heightAnchor.constraint(equalToConstant: 44).isActive = true
        RootViewController.measureToolbar.isHidden = true
        mapView.sketchEditor?.stop()
        
        //指南针
        compass.autoHide = false
        self.view.addSubview(compass)
        compass.snp.makeConstraints({make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(120)
            make.left.equalToSuperview().offset(20)
        })
        
        //比例尺
//        let width = CGFloat(200)
//        let xMargin = CGFloat(300)
//        let yMargin = CGFloat(10)
//        
//        // lower left scalebar
//        let sb = Scalebar(mapView: mapView)
//        sb.units = .metric
//        sb.alignment = .left
//        sb.style = .alternatingBar
//        view.addSubview(sb)
//        
//        // add constraints so it's anchored to lower left corner
//        sb.translatesAutoresizingMaskIntoConstraints = false
//        sb.widthAnchor.constraint(equalToConstant: width).isActive = true
//        sb.bottomAnchor.constraint(equalTo: mapView.attributionTopAnchor, constant: -yMargin).isActive = true
//        sb.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: xMargin).isActive = true
        
    
        //渲染层
        mapView.touchDelegate = self
        mapView.graphicsOverlays.add(graphicsOverlay)
        
        // callout
        mapView.callout.titleColor = .black
        mapView.callout.detailColor = .gray
        mapView.callout.delegate = self
        
    }
    
    func setUI() {
        let menuBtn = MenuButton()
        view.addSubview(menuBtn)
        menuBtn.snp.makeConstraints({make in
            make.width.height.equalTo(40)
            make.top.equalToSuperview().offset(60)
            make.left.equalToSuperview().offset(20)
        })
        menuBtn.addTarget(self, action: .menuSelector, for: .touchUpInside)
        
        let locationBtn = LocationButton()
        view.addSubview(locationBtn)
        locationBtn.snp.makeConstraints({make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-100)
            make.left.equalToSuperview().offset(20)
        })
        
        
        view.addSubview(RootViewController.markSegmentC)
        RootViewController.markSegmentC.isHidden = true
        RootViewController.markSegmentC.snp.makeConstraints({make in
            make.width.equalTo(120)
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalTo(menuBtn.snp.centerY)
            make.height.equalTo(40)
        })
        RootViewController.markSegmentC.backgroundColor = .white
        RootViewController.markSegmentC.selectedSegmentIndex = 0
        RootViewController.markSegmentC.layer.masksToBounds = true
        RootViewController.markSegmentC.tintColor = .red
        RootViewController.markSegmentC.accessibilityNavigationStyle = .automatic
        RootViewController.markSegmentC.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.systemBlue], for: .normal)
        
        //
        RootViewController.markSegmentC.addTarget(self, action: .markSegmentValueSelector, for: .valueChanged)
        

    }
    
    
    @objc func segmentDidchange(_ segmented:UISegmentedControl) {
        switch segmented.selectedSegmentIndex {
        case 0:
            mark = MarkMenu.normal
        case 1:
            mark = MarkMenu.x
        case 2:
            mark = MarkMenu.text
        default:
            mark = MarkMenu.normal
        }
    }
    

}

extension RootViewController {
    
    @objc func menu() {
        let menu = SideMenuNavigationController(rootViewController: MenuTableViewController())
        
        menu.menuWidth = 150
        menu.isNavigationBarHidden = true //侧栏菜单显示导航栏
        // 将其作为默认的左侧菜单
        SideMenuManager.default.leftMenuNavigationController = menu
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)

    }
}

import SCLAlertView
extension RootViewController: AGSGeoViewTouchDelegate {
    // 长按  "📍", "⛰️", "🚦", "🌊", "🏠", "🚾", "✏️"
    func geoView(_ geoView: AGSGeoView, didLongPressAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        if MarkCell.markSwitch.isOn { //开启标记
            switch mark {
            case .normal:
                let normalSymbol = AGSTextSymbol(text: "⭐️", color: .systemYellow, size: 25, horizontalAlignment: .center, verticalAlignment: .middle)
                let normalGraphic = AGSGraphic(geometry: mapPoint, symbol: normalSymbol, attributes: nil)
                graphicsOverlay.graphics.add(normalGraphic)
            case .x:
                let normalSymbol = AGSTextSymbol(text: "❌", color: .systemRed, size: 25, horizontalAlignment: .center, verticalAlignment: .middle)
                let normalGraphic = AGSGraphic(geometry: mapPoint, symbol: normalSymbol, attributes: nil)
                graphicsOverlay.graphics.add(normalGraphic)
            case .text:
                let alert = SCLAlertView()
                let textFieled = alert.addTextField("输入描述......")
                alert.addButton("确定", action: {
                    guard let text = textFieled.text else {
                        return
                    }
                    let textSymbol = AGSTextSymbol(text: text, color: .green, size: 20, horizontalAlignment: .center, verticalAlignment: .middle)
                    let graphic = AGSGraphic(geometry: mapPoint, symbol: textSymbol, attributes: nil)
                    graphicsOverlay.graphics.add(graphic)
                })
                alert.showEdit("", subTitle: "添加", closeButtonTitle: "取消", colorStyle: 0x1296db, colorTextButton: 0xFFFFFF,  animationStyle: .bottomToTop)
            default:
                break
            }
            
            
            
            
//
//
//            switch RootViewController.markSegmentC.selectedSegmentIndex {
//            case 0:
//                let imageName = "mark"
//                let pinSymbol = AGSPictureMarkerSymbol(image: UIImage(named: imageName)!)
//                pinSymbol.width = 30
//                pinSymbol.height = 30
//                let graphic = AGSGraphic(geometry: mapPoint, symbol: pinSymbol, attributes: nil)
//                graphicsOverlay.graphics.add(graphic)
//            default:
//                let alert = SCLAlertView()
//                let textFieled = alert.addTextField("输入描述......")
//                alert.addButton("确定", action: {
//                    guard let text = textFieled.text else {
//                        return
//                    }
//                    let textSymbol = AGSTextSymbol(text: text, color: .white, size: 20, horizontalAlignment: .center, verticalAlignment: .middle)
//                    let graphic = AGSGraphic(geometry: mapPoint, symbol: textSymbol, attributes: nil)
//                    graphicsOverlay.graphics.add(graphic)
//                })
//                alert.showEdit("", subTitle: "添加", closeButtonTitle: "取消", colorStyle: 0x1296db, colorTextButton: 0xFFFFFF,  animationStyle: .bottomToTop)
//            }
        }
    }
    
    // 长按结束
    func geoView(_ geoView: AGSGeoView, didEndLongPressAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        if MarkCell.markSwitch.isOn { //开启标记
            switch RootViewController.markSegmentC.selectedSegmentIndex {
            case 0:
                // 标记成功后遂即跳转信息界面
                let mark = MarkViewController()
                let nav = UINavigationController(rootViewController: mark)
                self.present(nav, animated: true, completion: nil)
            default:
                 break
            }
            
        }
    }
    
    // 用力按压
    func geoView(_ geoView: AGSGeoView, didForceTouchAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint, force: Double) {
        
    }
    
    //单击
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        let tolerance: Double = 12
        mapView.identify(graphicsOverlay, screenPoint: screenPoint, tolerance: tolerance, returnPopupsOnly: false, maximumResults: 10, completion: { [weak self] (result: AGSIdentifyGraphicsOverlayResult) in
            if let error = result.error {
                
            } else {
                if !result.graphics.isEmpty {
                    if mapView.callout.isHidden {
                        mapView.callout.title = "河道"
                        mapView.callout.detail = String(format: "x: %.2f,y: %.2f", mapPoint.x,mapPoint.y)
                        mapView.callout.show(at: mapPoint, screenOffset: CGPoint.zero, rotateOffsetWithMap: true, animated: true)
                    }
                } else {
                    mapView.callout.dismiss()
                }
            }
        })
    }
    
    
}

extension RootViewController: AGSCalloutDelegate {
    func didTapAccessoryButton(for callout: AGSCallout) {
        print("触发callout的附件按钮")
    }
}

