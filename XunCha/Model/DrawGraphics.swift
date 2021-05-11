//
//  DrawGraphices.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/6.
//

import Foundation
import ArcGIS
class DrawGraphics: NSObject {
    
    func Rendering() {
        //Mark.count()
    }
    
    func selectAllMark() {
        graphicsOverlay.clearSelection()
        let marks = Mark.rows()
        marks.forEach({item in  // AGSPoint: (495676.130671, 4314495.306494), sr: 4548
            var point: AGSPoint = AGSPoint.init(x: item.x, y: item.y, spatialReference: AGSSpatialReference.init(wkid: item.sr ))
            drawGraphics(type: item.type, name: item.name, info: item.info, point: point)
        })
        guard marks.count != graphicsOverlay.graphics.count else {
            return
        }
    }
    
    func drawGraphics(type: Int, name: String, info: String, point: AGSPoint){
        switch type {
        case 0:
            let normalSymbol = AGSTextSymbol(text: "★", color: .orange, size: 35, horizontalAlignment: .center, verticalAlignment: .middle)
            let normalGraphic = AGSGraphic(geometry: point, symbol: normalSymbol, attributes: nil)
            graphicsOverlay.graphics.add(normalGraphic)
        case 1:
            let normalSymbol = AGSTextSymbol(text: "✘", color: .red, size: 35, horizontalAlignment: .center, verticalAlignment: .middle)
            let normalGraphic = AGSGraphic(geometry: point, symbol: normalSymbol, attributes: nil)
            graphicsOverlay.graphics.add(normalGraphic)
        case 2:
            let textSymbol = AGSTextSymbol(text: name, color: UIColor(red: 124/255, green: 252/255, blue: 0/255, alpha: 1), size: 22, horizontalAlignment: .center, verticalAlignment: .middle)
            let graphic = AGSGraphic(geometry: point, symbol: textSymbol, attributes: nil)
            graphicsOverlay.graphics.add(graphic)
        default:
            break
        }
    }
}
