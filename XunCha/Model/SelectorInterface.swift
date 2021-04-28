//
//  SelectorInterface.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import ArcGIS
class SelectorInterface: NSObject {
    
    open func edit(bool: Bool) {
        
        if bool {
            // 显示 操作栏。包括 画图/画线/测绘
            RootViewController.measureToolbar.isHidden = false
            //RootViewController.measureToolbar.segControl.selectedSegmentIndex = 0
            if RootViewController.measureToolbar.segControl.selectedSegmentIndex == 0 {
                mapView.sketchEditor?.clearGeometry()
                mapView.sketchEditor?.start(with: nil, creationMode: .polyline)
            } else if (RootViewController.measureToolbar.segControl.selectedSegmentIndex == 1) {
                mapView.sketchEditor?.clearGeometry()
                mapView.sketchEditor?.start(with: nil, creationMode: .polygon)
            } else {
                mapView.sketchEditor?.clearGeometry()
                mapView.sketchEditor?.start(with: nil, creationMode: .freehandPolygon)
            }
            
            
        } else {
            RootViewController.measureToolbar.isHidden = true
            RootViewController.measureToolbar.lineSketchEditor.clearGeometry()
            RootViewController.measureToolbar.areaSketchEditor.clearGeometry()
            RootViewController.measureToolbar.areaFreeSketchEditor.clearGeometry()
            mapView.sketchEditor?.stop()
            
        }
    }
    
    open func mark(bool: Bool) {
        if bool {
            
            
            
        } else {
            
        }
    }
    
    

}
