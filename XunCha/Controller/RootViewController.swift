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


var goon = false
var calloutGraphic = AGSGraphic()
class RootViewController: UIViewController {
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
            //mapView.map?.basemap = AGSBasemap(baseLayer: jhyxLayer)
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
        RootViewController.markSegmentC.setTitleTextAttributes([NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22), NSAttributedString.Key.foregroundColor : UIColor.systemBlue], for: .normal)
        
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
import ImagePicker
extension RootViewController: AGSGeoViewTouchDelegate {
    
    @objc func openCamera() {
        let configuration = Configuration()
        configuration.noImagesTitle = "抱歉！这里没有图片！"
        configuration.doneButtonTitle = "完成"
        configuration.cancelButtonTitle = "结束"
        
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 3
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    // 长按  "📍", "⛰️", "🚦", "🌊", "🏠", "🚾", "✏️"
    func geoView(_ geoView: AGSGeoView, didLongPressAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        if MarkCell.markSwitch.isOn { //开启标记
            switch mark {
            case .normal:
                let alert = SCLAlertView()
                let textFieledName = alert.addTextField("输入名称......")
                let textFieledInfo = alert.addTextField("输入内容......")

                alert.addButton("确定", action: {
                    guard textFieledName.text != "" ,textFieledInfo.text != ""  else {
                        return
                    }
                    let normalSymbol = AGSTextSymbol(text: "★", color: .orange, size: 35, horizontalAlignment: .center, verticalAlignment: .middle)
                    let normalGraphic = AGSGraphic(geometry: mapPoint, symbol: normalSymbol, attributes: nil)
                    graphicsOverlay.graphics.add(normalGraphic)
                    let mark = Mark()
                    mark.name = textFieledName.text!
                    mark.info = textFieledInfo.text!
                    mark.type = 0
                    mark.x = mapPoint.x
                    mark.y = mapPoint.y
                    mark.sr = mapPoint.spatialReference!.wkid
                    mark.data = (UIImage(named: "picture")?.pngData())!
                    mark.save()
                })

                alert.showEdit("", subTitle: "添加", closeButtonTitle: "取消", colorStyle: 0x2D7CF5, colorTextButton: 0xFFFFFF,  animationStyle: .bottomToTop)
            case .x:
                let alert = SCLAlertView()
                let textFieledName = alert.addTextField("输入名称......")
                let textFieledInfo = alert.addTextField("输入内容......")
                alert.addButton("确定", action: {
                    guard textFieledName.text != "" ,textFieledInfo.text != ""  else {
                        return
                    }
                    let normalSymbol = AGSTextSymbol(text: "✘", color: .red, size: 35, horizontalAlignment: .center, verticalAlignment: .middle)
                    let normalGraphic = AGSGraphic(geometry: mapPoint, symbol: normalSymbol, attributes: nil)
                    graphicsOverlay.graphics.add(normalGraphic)
                    let mark = Mark()
                    mark.name = textFieledName.text!
                    mark.info = textFieledInfo.text!
                    mark.type = 1
                    mark.x = mapPoint.x
                    mark.y = mapPoint.y
                    mark.sr = mapPoint.spatialReference!.wkid
                    mark.data = (UIImage(named: "picture")?.pngData())!
                    mark.save()
                })
                alert.showEdit("", subTitle: "添加", closeButtonTitle: "取消", colorStyle: 0x2D7CF5, colorTextButton: 0xFFFFFF,  animationStyle: .bottomToTop)
            case .text:
                
                let alert = SCLAlertView()
                let textFieledName = alert.addTextField("输入名称......")
                let textFieledInfo = alert.addTextField("输入内容......")
                alert.addButton("确定", action: {
                    guard textFieledName.text != "" ,textFieledInfo.text != ""  else {
                        return
                    }
                    let textSymbol = AGSTextSymbol(text: textFieledName.text!, color: UIColor(red: 124/255, green: 252/255, blue: 0/255, alpha: 1), size: 22, horizontalAlignment: .center, verticalAlignment: .middle)
                    let graphic = AGSGraphic(geometry: mapPoint, symbol: textSymbol, attributes: nil)
                    graphicsOverlay.graphics.add(graphic)
                    let mark = Mark()
                    mark.name = textFieledName.text!
                    mark.info = textFieledInfo.text!
                    mark.type = 2
                    mark.x = mapPoint.x
                    mark.y = mapPoint.y
                    mark.sr = mapPoint.spatialReference!.wkid
                    mark.data = (UIImage(named: "picture")?.pngData())!
                    mark.save()
                })
                alert.showEdit("", subTitle: "添加", closeButtonTitle: "取消", colorStyle: 0x2D7CF5, colorTextButton: 0xFFFFFF,  animationStyle: .bottomToTop)
                
            default:
                break
            }
            
        }
    }
    
    
    //单击
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        let tolerance: Double = 12
        mapView.identify(graphicsOverlay, screenPoint: screenPoint, tolerance: tolerance, returnPopupsOnly: false, maximumResults: 10, completion: {  (result: AGSIdentifyGraphicsOverlayResult) in
            if let error = result.error {
                print(error)
            } else {
                if !result.graphics.isEmpty {
                    mapView.callout.dismiss()
                    calloutGraphic = result.graphics.first!
                    let point = (result.graphics.first?.geometry?.extent.center)! // 获取该形状的中心点，用来查询point
                    
                    let mark = Mark.rows(filter: "x=\(point.x) and y=\(point.y)").first //  and y='\(point.y)'
                    
                    if mapView.callout.isHidden {
                        guard ((mark?.name) != nil), ((mark?.info) != nil) else {
                            mark?.delete()
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = .text
                            hud.label.text = "发生错误!"
                            hud.animationType = .fade
                            hud.hide(animated: true, afterDelay: 2)
                            return
                        }
                        mapView.callout.title = "\(mark!.name)" // 显示名称
                        mapView.callout.detail = "\(mark!.info)" // 显示内容
                        mapView.callout.show(at: (result.graphics.first?.geometry?.extent.center)!, screenOffset: CGPoint.zero, rotateOffsetWithMap: true, animated: true) // 气泡显示在图形的最中心点
                    }
                } else {
                    mapView.callout.dismiss() // 气泡消失
                }
            }
        })
    }
    
    
}

extension RootViewController: AGSCalloutDelegate {
    func didTapAccessoryButton(for callout: AGSCallout) {

        
        // 跳转标注详情页
        let mark = ShowMarkViewController()
        let nav = UINavigationController(rootViewController: mark)
        mark.x = mapView.callout.mapLocation!.x
        mark.y = mapView.callout.mapLocation!.y
        mark.sr = mapView.callout.mapLocation!.spatialReference!.wkid
        mapView.callout.dismiss()
        self.present(nav, animated: true, completion: nil)
        
    }
}

extension RootViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapperDidPress")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("doneButtonDidPress")
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("cancelButtonDidPress")
    }
    
    
}

