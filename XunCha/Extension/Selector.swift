//
//  Selectoer.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/13.
//

import Foundation
import UIKit

extension Selector {
    
    static let editSelector = #selector(EditCell.edit)
    static let kmlSelector = #selector(KMLCell.kml)
    static let markSelector = #selector(MarkCell.mark)
    static let menuSelector = #selector(RootViewController.menu)
    static let markSegmentValueSelector = #selector(RootViewController.segmentDidchange)
    
}
