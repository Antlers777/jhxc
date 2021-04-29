//
//  MarkEntity.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/29.
//

import Foundation
import SwiftyJSON

class MarkEntity: NSObject {
    var id: Int?
    var _name: String?
    var name: String? {
        get {
            return _name
        }
        set {
            _name = newValue
        }
    }
    
    var _info: String?
    var info: String? {
        get {
            return _info
        }
        set {
            _info = newValue
        }
    }
    
    var _type: MarkMenu?
    var type: MarkMenu? {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    var _point: JSON?
    var point: JSON? {
        get {
            return _point
        }
        set {
            _point = newValue
        }
    }
    
}
