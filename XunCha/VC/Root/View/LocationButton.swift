//
//  LocationButton.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import UIKit
import ArcGIS
class LocationButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setImage(UIImage(named: "location")?.reSizeImage(reSize: CGSize(width: 30, height: 30)), for: .normal)
        //setImage(UIImage(named: "location"), for: .selected)
        backgroundColor = .white
        layer.cornerRadius = 10
        self.addTarget(self, action: #selector(location), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func location() {
        // 开始定位
        mapView.locationDisplay.start { (error: Error?) in
            if let error = error {
                print(error)
            }
        }
        mapView.locationDisplay.autoPanMode = .compassNavigation
        mapView.locationDisplay.navigationPointHeightFactor = 0.5
    }
    
    
}






