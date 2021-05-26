//
//  SingleKMLModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/24.
//

import Foundation
import UIKit
import ArcGIS

var overlySwitch = UISwitch()
var shareButton = UIButton()

extension SingleKMLViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sinleKMLTableView.dequeueReusableCell(withIdentifier: "id")!
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "叠加 KML"
            overlySwitch.addTarget(self, action: #selector(overlyKMLLayer), for: .valueChanged)
            cell.accessoryView = overlySwitch
            overlySwitch.tag = id
            overlySwitch.tag = indexPath.row
            cell.selectionStyle = .none
        case 1:
            cell.textLabel?.text = "分享 KML"
            cell.accessoryType = .detailButton
            cell.selectionStyle = .none
        default:
            cell.textLabel?.text = fileName
            cell.selectionStyle = .none
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .groupTableViewBackground
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .groupTableViewBackground
        let footerLabel = UILabel(frame: CGRect(x: 20, y: 10, width: sinleKMLTableView.bounds.size.width, height: sinleKMLTableView.bounds.size.height))
        footerLabel.font = UIFont(name: "Verdana", size: 12.5)
        footerLabel.textColor = .gray
        switch section {
        case 0:
            footerLabel.text = "开启开关将其叠加显示在地图上，关闭则隐藏。"
        case 1:
            footerLabel.text = "提醒对方打开蓝牙，选择AirDrop，选择相应联系人。"
        default:
            footerLabel.text = "文件大小: \(fileSize)，创建时间: \(fileTime)"
        }
        
        footerLabel.sizeToFit()
        footerView.addSubview(footerLabel)
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break
        case 1:
            //要分享的文本
            let text = "选择AirDrop，发送给联系人。"
            
            //设置活动视图控制器
            let textToShare = [text]
            let activityViewController = UIActivityViewController.init(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view //这样就不会崩溃
            //activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop] // 提出
            //呈现视图控制器
            self.present(activityViewController ,animated: true, completion:nil)
        default: break
            
        }
    }
}

extension SingleKMLViewController {
    /**
        构建KMLLayer 显示于mapView
     */
    @objc func overlyKMLLayer(sender: UISwitch) {
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask,
                 appropriateFor: nil, create: true)
            .appendingPathComponent("/KML/\(fileName)")
        let dataset = AGSKMLDataset(url: fileURL)
        let layer = AGSKMLLayer.init(kmlDataset: dataset)
        
//        if overlySwitch.isOn {
//            print("开开开开开开开开开开开开开")
//            layerDict[fileName] = layer
//            layerDict.updateValue(layer, forKey: fileName)
//            mapView.map?.operationalLayers.removeAllObjects()
//            for (key, value) in layerDict.enumerated() {
//                mapView.map?.operationalLayers.add(value)
//            }
//            print(layerDict.count)
//        } else {
//            print("关关关关关关关关关关关关关关关关")
//
//            layerDict.removeValue(forKey: fileName)
//            mapView.map?.operationalLayers.removeAllObjects()
//            for (_, value) in layerDict.enumerated() {
//                mapView.map?.operationalLayers.add(value)
//            }
//        }
//        print(layerDict)
        
        
    }
    
    func fileInfoLoad() {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in:.userDomainMask)
        let docPath = urlForDocument[0]
        let file = docPath.appendingPathComponent("/KML/\(fileName)")
        let attributes = try? manager.attributesOfItem(atPath: file.path) //结果为Dictionary类型
        fileSize = covertToFileString(with: sizeForLocalFilePath(filePath: file.path))
        fileTime = getfileCreatedDate(theFile: file.path)
        
        
    }
    
    func getfileCreatedDate(theFile: String) -> String {
        
        var theCreationDate = Date()
        do{
            let aFileAttributes = try FileManager.default.attributesOfItem(atPath: theFile) as [FileAttributeKey:Any]
            theCreationDate = aFileAttributes[FileAttributeKey.creationDate] as! Date
            
        } catch let theError as Error{
            print("file not found (theError)")
        }
        var dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var datestr = dformatter.string(from: theCreationDate)
        return datestr
    }
    
    func sizeForLocalFilePath(filePath:String) -> UInt64 {
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: filePath)
            if let fileSize = fileAttributes[FileAttributeKey.size]  {
                return (fileSize as! NSNumber).uint64Value
            } else {
                print("Failed to get a size attribute from path: \(filePath)")
            }
        } catch {
            print("Failed to get file attributes for local path: \(filePath) with error: \(error)")
        }
        return 0
    }
    
    func covertToFileString(with size: UInt64) -> String {
        var convertedValue: Double = Double(size)
        var multiplyFactor = 0
        let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB",  "EB",  "ZB", "YB"]
        while convertedValue > 1024 {
            convertedValue /= 1024
            multiplyFactor += 1
        }
        return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
    }
    
    
    func checkSwitch() {
        let indexpath = IndexPath.init(row: 0, section: 0)
        var cell: UITableViewCell =  sinleKMLTableView.cellForRow(at: indexpath)!
        
//        var overlySwitch: UISwitch = cell.accessoryView! as! UISwitch
//        print(layerDict.count)
//        for (filename, layer) in layerDict {
//            if filename == fileName {
//                overlySwitch.isOn = true
//            }else {
//                overlySwitch.isOn = false
//            }
//        }
    }
}
