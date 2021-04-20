//
//  ToolBar.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/14.
//

import Foundation
import UIKit
import SnapKit

class ToolBarView: UIView {
    var polylineBtn = UIButton(frame: .zero)
    var polygonBtn = UIButton(frame: .zero)
    
    var undoBtn = UIButton(frame: .zero)
    var redoBtn = UIButton(frame: .zero)
    var clearBtn = UIButton(frame: .zero)
    
    var segmentedC = UISegmentedControl(items: ["点","线","手绘线","多边形","手绘多边形"])
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(polylineBtn)
//        self.addSubview(polygonBtn)
//        self.addSubview(backOffBtn)
//        self.addSubview(clearBtn)
        self.addSubview(segmentedC)
        
        backgroundColor = .white
        segmentedC.snp.makeConstraints({make in
            make.width.equalToSuperview().dividedBy(1)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        })
        
//        segmentedC.addTarget(self, action: #selector(geometryValueChanged), for: .valueChanged)
        
        
        
//        polylineBtn.snp.makeConstraints({make in
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().offset(10)
//        })
//        polylineBtn.backgroundColor = .blue
//
//        polygonBtn.snp.makeConstraints({make in
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//            make.centerY.equalToSuperview()
//            make.left.equalToSuperview().offset(50)
//        })
//        polygonBtn.backgroundColor = .blue
//
//        backOffBtn.snp.makeConstraints({make in
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-50)
//        })
//        backOffBtn.backgroundColor = .blue
//
//        clearBtn.snp.makeConstraints({make in
//            make.width.equalTo(30)
//            make.height.equalTo(30)
//            make.centerY.equalToSuperview()
//            make.right.equalToSuperview().offset(-10)
//        })
//        clearBtn.backgroundColor = .blue
       
    }
    
//    func geometryValueChanged(_ segmentedControl: UISegmentedControl) {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0://point
//            self.sketchEditor.start(with: nil, creationMode: .point)
//            
//        case 1://polyline
//            self.sketchEditor.start(with: nil, creationMode: .polyline)
//            
//        case 2://freehand polyline
//            self.sketchEditor.start(with: nil, creationMode: .freehandPolyline)
//            
//        case 3://polygon
//            self.sketchEditor.start(with: nil, creationMode: .polygon)
//            
//        case 4://freehand polygon
//            self.sketchEditor.start(with: nil, creationMode: .freehandPolygon)
//            
//        default:
//            break
//        }
//        
//        self.mapView.sketchEditor = self.sketchEditor
//        
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
