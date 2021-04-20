//
//  Map.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/12.
//

import Foundation
import ArcGIS

var jhyxLayer = AGSArcGISTiledLayer(url: URL(string: "http://61.240.19.180:6080/arcgis/rest/services/JH/JHYX20210107_2000a/MapServer")!)
var mapView = AGSMapView()
