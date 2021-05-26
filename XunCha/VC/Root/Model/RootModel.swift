//
//  RootModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/14.
//

import Foundation
import UIKit
import ArcGIS
import SnapKit
import Alamofire
import SideMenu
import ArcGISToolkit
import MBProgressHUD
import RxSwift
import RxCocoa

extension RootViewController {
    
}

extension RootViewController {
    
    @objc func menu() {
        let menu = SideMenuNavigationController(rootViewController: MenuTableViewController())
        //let menu = SideMenuNavigationController(rootViewController: LeftDrawerViewController())
        menu.menuWidth = 240
        menu.isNavigationBarHidden = true //侧栏菜单显示导航栏
        // 将其作为默认的左侧菜单
        SideMenuManager.default.leftMenuNavigationController = menu
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)

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
    
    /**
        缩小地图比例
     */
    func narrowMapView() {
        scale = mapView.mapScale
        let screenpoint = mapView.center
        let agspoint = mapView.screen(toLocation: screenpoint)
        if scale > 1000.0 && scale < 250000.0 {
            scale = scale*2
            
            mapView.setViewpointCenter(agspoint, scale: scale, completion: nil)
        }
        // 1953.125  3906.25 7812.5 15625.0 31250.0 62500.0 125000.0 250000.0
    }
    
    /**
        放大地图比例
     */
    func enlargeMapView() {
        scale = mapView.mapScale
        let screenpoint = mapView.center
        let agspoint = mapView.screen(toLocation: screenpoint)
        if scale >= 2000.0 && scale <= 250000.0 {
            scale = scale/2
            mapView.setViewpointCenter(agspoint, scale: scale, completion: nil)
        }
        // 250000.0 125000.0  62500.0 31250.0 15625.0 7812.5 3906.25 1953.125
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
                    mark.x = String(mapPoint.x)
                    mark.y = String(mapPoint.y)
                    mark.sr = mapPoint.spatialReference!.wkid
                    mark.data = (UIImage(named: "picture")?.pngData())!
                    mark.time = Data.nowDateToString()
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
                    mark.x = String(mapPoint.x)
                    mark.y = String(mapPoint.y)
                    mark.sr = mapPoint.spatialReference!.wkid
                    mark.data = (UIImage(named: "picture")?.pngData())!
                    mark.time = Data.nowDateToString()
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
                    mark.x = String(mapPoint.x)
                    mark.y = String(mapPoint.y)
                    mark.sr = mapPoint.spatialReference!.wkid
                    mark.data = (UIImage(named: "picture")?.pngData())!
                    mark.time = Data.nowDateToString()
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
            mapView.callout.dismiss()
            if let error = result.error {
                print(error)
            } else {
                if !result.graphics.isEmpty {
                    
                    calloutGraphic = result.graphics.first!
                    let point = (result.graphics.first?.geometry?.extent.center)! // 获取该形状的中心点，用来查询point
                    
                    let mark = Mark.rows(filter: "x='\(point.x)' and y='\(point.y)' ").first //  and y='\(point.y)'
                    print(mark)
                    if mapView.callout.isHidden {
                        guard ((mark?.name) != nil), ((mark?.info) != nil) else {
                            mark?.delete()
                            graphicsOverlay.graphics.remove(result.graphics)
                            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
                            hud.mode = .text
                            hud.label.text = "发生错误!"
                            hud.animationType = .fade
                            hud.hide(animated: true, afterDelay: 2)
                            return
                        }
                        // 显示右侧详情按钮
                        mapView.callout.isAccessoryButtonHidden = false
                        mapView.callout.title = "\(mark!.name)" // 显示名称
                        mapView.callout.detail = "\(mark!.info)" // 显示内容
                        mapView.callout.show(at: point, screenOffset: CGPoint.zero, rotateOffsetWithMap: true, animated: true) // 气泡显示在图形的最中心点
                    }
                } else {
                    mapView.callout.dismiss() // 气泡消失
                }
            }
        })
        
        // 地点气泡
        mapView.identify(graphicsOverlayPlace, screenPoint: screenPoint, tolerance: tolerance, returnPopupsOnly: false, maximumResults: 10, completion: {  (result: AGSIdentifyGraphicsOverlayResult) in
            mapView.callout.dismiss()
            if let error = result.error {
                print(error)
            } else {
                if !result.graphics.isEmpty && mapView.callout.isHidden {
                    
                    calloutGraphic = result.graphics.first!
                    let point = (result.graphics.first?.geometry?.extent.center)! // 获取该形状的中心点，用来查询point
                    // 取消右侧详情按钮
                    mapView.callout.isAccessoryButtonHidden = true
                    mapView.callout.title = "团泊湖"
                    mapView.callout.detail = "x:\(point.x),y:\(point.y)"
                    mapView.callout.show(at: point, screenOffset: CGPoint(x: 0, y: -20), rotateOffsetWithMap: true, animated: true) // 气泡显示在图形的上方
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

extension RootViewController {
    @objc func clearKML() {
        RootViewController.kmlToolbar.actionItem.isEnabled = false
        mapView.map?.operationalLayers.removeAllObjects()
        kmlDocument = AGSKMLDocument()
        let kmlDataset = AGSKMLDataset(rootNode: kmlDocument)
        let kmlLayer = AGSKMLLayer(kmlDataset: kmlDataset)
        mapView.map?.operationalLayers.add(kmlLayer)
    }
    
    @objc func addKML() {
        let alertController = UIAlertController(title: "选择类型", message: nil, preferredStyle: .actionSheet)
        let pointAction = UIAlertAction(title: "点", style: .default) { (_) in
            self.addPoint()
        }
        alertController.addAction(pointAction)
        let polylineAction = UIAlertAction(title: "折线", style: .default) { (_) in
            self.addPolyline()
        }
        alertController.addAction(polylineAction)
        let polygonAction = UIAlertAction(title: "多边形", style: .default) { (_) in
            self.addPolygon()
        }
        alertController.addAction(polygonAction)
        
        // Add "cancel" item.
        let cancelAction = UIAlertAction(title: "结束", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.barButtonItem = RootViewController.kmlToolbar.addItem
        present(alertController, animated: true)
    }
    
    @objc func actionKML(_ sender: UIBarButtonItem) {
//        let kmzProvider = KMZProvider(document: kmlDocument)
//        let activityViewController = UIActivityViewController(activityItems: [kmzProvider], applicationActivities: nil)
//        activityViewController.popoverPresentationController?.barButtonItem = sender
//        present(activityViewController, animated: true)
//        activityViewController.completionWithItemsHandler = { _, completed, _, activityError in
//            if completed {
//                kmzProvider.deleteKMZ()
//            } else if let error = activityError {
//                //self.presentAlert(error: error)
//            }
//        }
        
        
        let alertVC = UIAlertController(title: "文件提示", message: "请输入KML文件名称", preferredStyle: UIAlertController.Style.alert)
        // 2 带输入框
        alertVC.addTextField {
                    (textField: UITextField!) -> Void in
                    textField.placeholder = "文件名称"
        }
        // 3 命令（样式：退出Cancel，警告Destructive-按钮标题为红色，默认Default）
        let alertActionCancel = UIAlertAction(title: "取消", style: UIAlertAction.Style.destructive, handler: nil)
        let alertActionOK = UIAlertAction(title: "确认", style: UIAlertAction.Style.default, handler: { [self]
                    action in
            guard let file = alertVC.textFields?.first?.text else {
                return
            }
            let fileURL = try! FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask,
                     appropriateFor: nil, create: true)
                .appendingPathComponent("/KML/\((alertVC.textFields?.first?.text!)!).kmz")
            kmlDocument.save(toFileURL: fileURL, completion: {(error: Error?) in
                let alertView = UIAlertView(title: "错误提示", message: "保存失败，请更换文件名称或者再次尝试。", delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
                return
            })
            clearKML()
            
            
        })
        alertVC.addAction(alertActionCancel)
        alertVC.addAction(alertActionOK)
        // 4 跳转显示
        self.present(alertVC, animated: true, completion: nil)
       
        
    }
    
    @objc func completeSketch() {
        let geometry = mapView.sketchEditor?.geometry
        let projectedGeometry = AGSGeometryEngine.projectGeometry(geometry!, to: AGSSpatialReference(wkid: 4548)!)
        let kmlGeometry = AGSKMLGeometry(geometry: projectedGeometry!, altitudeMode: .clampToGround)
        let currentPlacemark = AGSKMLPlacemark(geometry: kmlGeometry!)
        currentPlacemark.style = kmlStyle
        kmlDocument.addChildNode(currentPlacemark)
        mapView.sketchEditor?.stop()
        kmlStyle = nil
        updateToolbarItems()
        RootViewController.kmlToolbar.actionItem.isEnabled = true
    }
    
    // Prompt icon selection action sheet.
    func addPoint() {
        let alertController = UIAlertController(title: "选择图标", message: "图标用于显示点", preferredStyle: .actionSheet)
        let icons: [(String, URL)] = [
            ("默认", URL(string: "http://resources.esri.com/help/900/arcgisexplorer/sdk/doc/bitmaps/148cca9a-87a8-42bd-9da4-5fe427b6fb7b127.png")!),
            ("五角星", URL(string: "https://static.arcgis.com/images/Symbols/Shapes/BlueStarLargeB.png")!),
            ("钻石", URL(string: "https://static.arcgis.com/images/Symbols/Shapes/BlueDiamondLargeB.png")!),
            ("圆", URL(string: "https://static.arcgis.com/images/Symbols/Shapes/BlueCircleLargeB.png")!),
            ("方字块", URL(string: "https://static.arcgis.com/images/Symbols/Shapes/BlueSquareLargeB.png")!),
            ("圆别针", URL(string: "https://static.arcgis.com/images/Symbols/Shapes/BluePin1LargeB.png")!),
            ("方别针", URL(string: "https://static.arcgis.com/images/Symbols/Shapes/BluePin2LargeB.png")!)
        ]
        icons.forEach { (title, url) in
            let pointAction = UIAlertAction(title: title, style: .default) { (_) in
                self.kmlStyle = self.makeKMLStyleWithPointStyle(iconURL: url)
                self.startSketch(creationMode: .point)
            }
            alertController.addAction(pointAction)
        }
        // Add "cancel" item.
        let cancelAction = UIAlertAction(title: "结束", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.barButtonItem = RootViewController.kmlToolbar.addItem
        present(alertController, animated: true)
    }
    
    // Prompt color selection action sheet for polyline feature.
    func addPolyline() {
        let alertController = UIAlertController(title: "选择颜色", message: "颜色将用于显示折线的颜色", preferredStyle: .actionSheet)
        colors.forEach { (colorTitle, colorValue) in
            let colorAction = UIAlertAction(title: colorTitle, style: .default) { (_) in
                self.kmlStyle = self.makeKMLStyleWithLineStyle(color: colorValue)
                self.startSketch(creationMode: .polyline)
            }
            alertController.addAction(colorAction)
        }
        // Add "cancel" item.
        let cancelAction = UIAlertAction(title: "结束", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.barButtonItem = RootViewController.kmlToolbar.addItem
        present(alertController, animated: true)
    }
    
    // Prompt color selection action sheet for polygon feature.
    func addPolygon() {
        let alertController = UIAlertController(title: "选择颜色", message: "颜色将用于显示多边形的颜色", preferredStyle: .actionSheet)
        colors.forEach { (colorTitle, colorValue) in
            let colorAction = UIAlertAction(title: colorTitle, style: .default) { (_) in
                self.kmlStyle = self.makeKMLStyleWithPolygonStyle(color: colorValue)
                self.startSketch(creationMode: .polygon)
            }
            alertController.addAction(colorAction)
        }
        // Add "cancel" item.
        let cancelAction = UIAlertAction(title: "结束", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.popoverPresentationController?.barButtonItem = RootViewController.kmlToolbar.addItem
        present(alertController, animated: true)
    }
    
    // Make KML with a point style.
    func makeKMLStyleWithPointStyle(iconURL: URL) -> AGSKMLStyle {
        let icon = AGSKMLIcon(url: iconURL)
        let iconStyle = AGSKMLIconStyle(icon: icon, scale: 1.0)
        let kmlStyle = AGSKMLStyle()
        kmlStyle.iconStyle = iconStyle
        return kmlStyle
    }
    
    // Make KML with a line style.
    func makeKMLStyleWithLineStyle(color: UIColor) -> AGSKMLStyle {
        let kmlStyle = AGSKMLStyle()
        kmlStyle.lineStyle = AGSKMLLineStyle(color: color, width: 2.0)
        return kmlStyle
    }
    
    // Make KML with a polygon style.
    func makeKMLStyleWithPolygonStyle(color: UIColor) -> AGSKMLStyle {
        let polygonStyle = AGSKMLPolygonStyle(color: color)
        polygonStyle.isFilled = true
        polygonStyle.isOutlined = false
        let kmlStyle = AGSKMLStyle()
        kmlStyle.polygonStyle = polygonStyle
        return kmlStyle
    }
    
    // Update the bottom toolbar button.
    func updateToolbarItems() {
        guard let sketchEditor = mapView.sketchEditor else {
            return
        }
        let middleButtonItem: UIBarButtonItem
        if sketchEditor.isStarted {
            RootViewController.kmlToolbar.clearItem.isEnabled = false
            middleButtonItem = RootViewController.kmlToolbar.sketchDoneItem
        } else {
            RootViewController.kmlToolbar.clearItem.isEnabled = true
            middleButtonItem = RootViewController.kmlToolbar.addItem
        }
        let flexibleSpace1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let flexibleSpace2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        RootViewController.kmlToolbar.items = [RootViewController.kmlToolbar.clearItem, flexibleSpace1, middleButtonItem, flexibleSpace2, RootViewController.kmlToolbar.actionItem]
    }
    
    // Start a new sketch mode.
    func startSketch(creationMode: AGSSketchCreationMode) {
        mapView.sketchEditor?.start(with: creationMode)
        updateToolbarItems()
    }
    
    func isKMLFileExist() -> Bool {
        let fileManager = FileManager.default
        let filePath: String = NSHomeDirectory() + "/Documents/KML/jhkml.kmz"
        let exist = fileManager.fileExists(atPath: filePath)
        return exist
    }
    
    func createKML() {
        if isKMLFileExist() {
            let fileURL = try! FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask,
                     appropriateFor: nil, create: true)
                .appendingPathComponent("/KML/jhkml.kmz")
            let kmlDataset = AGSKMLDataset.init(url: fileURL)
            let kmlLayer = AGSKMLLayer(kmlDataset: kmlDataset)
            mapView.map?.operationalLayers.add(kmlLayer)
        } else {
            kmlDocument = AGSKMLDocument()
            let fileURL = try! FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask,
                     appropriateFor: nil, create: true)
                .appendingPathComponent("/KML/jhkml.kmz")
            let kmlDataset = AGSKMLDataset.init(url: fileURL)
            let kmlLayer = AGSKMLLayer(kmlDataset: kmlDataset)
            mapView.map?.operationalLayers.add(kmlLayer)
            kmlDocument.save(toFileURL: fileURL, completion: { (error: Error?) in
            })
            
        }
    }

}

// Handles saving a KMZ file.
private class KMZProvider: UIActivityItemProvider {
    private let document: AGSKMLDocument
    private var temporaryDirectoryURL: URL?
    
    init(document: AGSKMLDocument) {
        self.document = document
        if document.name.isEmpty {
            document.name = "Untitled"
        }
        super.init(placeholderItem: URL(fileURLWithPath: "\(document.name).kmz"))
    }

    override var item: Any {
        temporaryDirectoryURL = try? FileManager.default.url(
            for: .itemReplacementDirectory,
            in: .userDomainMask,
            appropriateFor: Bundle.main.bundleURL,
            create: true
        )
        let documentURL = temporaryDirectoryURL?.appendingPathComponent("\(document.name).kmz")
        let semaphore = DispatchSemaphore(value: 0)
        document.save(toFileURL: documentURL!) { _ in
            semaphore.signal()
        }
        semaphore.wait()
        return documentURL!
    }
    
    // Deletes the temporary directory.
    func deleteKMZ() {
        guard let url = temporaryDirectoryURL else { return }
        try? FileManager.default.removeItem(at: url)
    }
}

extension Selector {
    static let clearKMLSelector = #selector(RootViewController.clearKML)
    static let addKMLSelector = #selector(RootViewController.addKML)
    static let actionKMLSelector = #selector(RootViewController.actionKML)
    static let completeSketchKMLSelector = #selector(RootViewController.completeSketch)
}
