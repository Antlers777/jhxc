//
//  Mark.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/6.
//

import Foundation
import UIKit

class Mark: SQLModel {
    var mid: Int = -1
    var type: Int = -1
    var name: String = ""
    var info: String = ""
    var x: String = ""
    var y: String = ""
    var sr: Int = 0
    var data: Data = Data()
    var time: String = ""
}
