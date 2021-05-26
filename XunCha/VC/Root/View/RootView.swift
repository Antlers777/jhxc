//
//  RootView.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/14.
//

import Foundation
import UIKit
import ArcGIS
import ArcGISToolkit

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
        mapView.map?.basemap = AGSBasemap(baseLayer: jhyxLayer)
        
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
//        mapView.isAttributionTextVisible = false
//        do {
//            try AGSArcGISRuntimeEnvironment.setLicenseKey("runtimelite,1000,rud3339743773,none,5H80TK8EL9GYF5KHT005")
//        } catch  {
//            
//        }
        
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
        let compass = Compass(mapView: mapView)
        //compass.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(compass)
 
        compass.snp.makeConstraints({make in
            make.width.height.equalTo(40)
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(120)
        })
      
        //渲染层
        mapView.touchDelegate = self
        mapView.graphicsOverlays.add(graphicsOverlay)
        mapView.graphicsOverlays.add(graphicsOverlayPlace)
        
        // callout
        mapView.callout.titleColor = .black
        mapView.callout.detailColor = .gray
        mapView.callout.delegate = self
        mapView.callout.titleColor = .black
        mapView.callout.detailColor = .gray
        
        
        
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
            make.bottom.equalToSuperview().offset(-120)
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
        RootViewController.markSegmentC.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor : UIColor.systemBlue], for: .normal)
        
        //
        RootViewController.markSegmentC.addTarget(self, action: .markSegmentValueSelector, for: .valueChanged)
        
        // 添加 放大地图 缩小地图 的按钮
        
        let narrowButton = NarrowButton()
        //narrowButton.l
        self.view.addSubview(narrowButton)
        narrowButton.snp.makeConstraints({make in
            make.width.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-120)
        })
        
        let enlargeButton = EnlargeButton()
        self.view.addSubview(enlargeButton)
        enlargeButton.snp.makeConstraints({make in
            make.width.height.equalTo(30)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalTo(narrowButton.snp.top).offset(-20)
        })
        
        narrowButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.narrowMapView()})
            .disposed(by: disposeBag)
        enlargeButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.enlargeMapView()})
            .disposed(by: disposeBag)
        if #available(iOS 13.0, *) {
            mapView.showsLargeContentViewer = true
        } else {
            // Fallback on earlier versions
        }
         
        
        //比例尺显示
        let scalebar = Scalebar(mapView: mapView)
        scalebar.style = .alternatingBar
        scalebar.units = .metric
        scalebar.alignment = .left
        scalebar.textColor = .white
        view.addSubview(scalebar)
        scalebar.translatesAutoresizingMaskIntoConstraints = false
        scalebar.snp.makeConstraints({make in
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(175)
            make.bottom.equalToSuperview().offset(-90)
        })
        
        view.addSubview(RootViewController.kmlToolbar)
        RootViewController.kmlToolbar.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.height.equalTo(46)
            make.bottom.equalToSuperview().offset(-34)
        })
        // kmlToolbar
        RootViewController.kmlToolbar.isHidden = true
    }

}
