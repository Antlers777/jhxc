//
//  ImportKMLModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/24.
//

import Foundation
import UIKit
import ArcGIS

extension KMLListViewController {
    @objc func backToRoot() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func openPicker() {
        let documentTypes = [
            "public.kmz"
        ]
        let document = UIDocumentPickerViewController(documentTypes: documentTypes, in: .import)
        document.delegate = self
        self.present(document, animated: true, completion: nil)
    }
    
    @objc func fromDocumentAddKKML() {
        let alertView = UIAlertView(title: "本地导入提示", message: "打开系统文件APP，将要导入的KML文件移动到静海巡查文件夹内的KML下。", delegate: nil, cancelButtonTitle: "确定")
        alertView.show()
    }
    
    func fileLoad() {
        let manager = FileManager.default
        let urlForDocument = manager.urls(for: .documentDirectory, in: .userDomainMask )
        let url = urlForDocument[0] as URL
        let contentsOfPath = try? manager.contentsOfDirectory(atPath: url.path+"/KML")
        guard (contentsOfPath != nil) else {
            return
        }
        kmlFileArray = contentsOfPath!
    }
    
    
}


extension KMLListViewController: UIDocumentPickerDelegate{
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        
    }
}

extension KMLListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kmlFileArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = kmlFileArray[indexPath.row]
        //cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let single = SingleKMLViewController()
//        single.fileName = kmlFileArray[indexPath.row]
//        single.id = indexPath.row
//        self.navigationController!.pushViewController(single, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let exprot = UITableViewRowAction(style: .normal, title: "导出", handler: { [self]action, index in
            fileName = kmlFileArray[indexPath.row]
            
            //要到处的文件
            let fileURL = try! FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask,
                     appropriateFor: nil, create: true)
                .appendingPathComponent("/KML/\(fileName)")
            
            let documentPicker = UIDocumentPickerViewController(url: fileURL, in: .exportToService)
            documentPicker.delegate = self
            self.present(documentPicker, animated: true, completion: nil)
        })
        exprot.backgroundColor = .systemOrange
        
        
        
        let airdrop = UITableViewRowAction(style: .normal, title: "分享", handler: { [self]action, index in
            fileName = kmlFileArray[indexPath.row]
            
            //要分享的文件
            let fileURL = try! FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask,
                     appropriateFor: nil, create: true)
                .appendingPathComponent("/KML/\(fileName)")
            
            //设置活动视图控制器
            let kmlToShare = [fileURL]
            let activityViewController = UIActivityViewController.init(activityItems: kmlToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view //这样就不会崩溃
            //activityViewController.excludedActivityTypes = [UIActivity.ActivityType.airDrop] // 提出
            //呈现视图控制器
            self.present(activityViewController ,animated: true, completion:nil)
        })
        airdrop.backgroundColor = .systemBlue
        
        var overly = UITableViewRowAction.init()
        fileName = kmlFileArray[indexPath.row]
        let fileURL = try! FileManager.default
            .url(for: .documentDirectory, in: .userDomainMask,
                 appropriateFor: nil, create: true)
            .appendingPathComponent("/KML/\(fileName)")
        let dataset = AGSKMLDataset(url: fileURL)
        let layer = AGSKMLLayer.init(kmlDataset: dataset)
        if let layer = layerDict[fileName] {
            overly = UITableViewRowAction(style: .normal, title: "隐藏", handler: {action, index in
                mapView.map?.operationalLayers.remove(layer)
                layerDict.removeValue(forKey: self.fileName)
            })
        } else {
            overly = UITableViewRowAction(style: .normal, title: "显示", handler: {action, index in
                mapView.map?.operationalLayers.add(layer)
                layerDict[self.fileName] = layer
            })
        }
        
        
        overly.backgroundColor = .systemGreen
        
        let delete = UITableViewRowAction(style: .normal, title: "删除", handler: {action, index in
            
        })
        delete.backgroundColor = .systemRed
        return [delete,overly,airdrop, exprot]
    }
    
    
    
}
