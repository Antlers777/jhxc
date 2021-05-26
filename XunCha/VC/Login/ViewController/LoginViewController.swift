//
//  LoginViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/18.
//

import UIKit

class LoginViewController: UIViewController {
    
    var helloLabel: UILabel!
    var iphoneNumber: UITextField!
    var iphoneNumberVaild: UILabel!
    var clearButton: UIButton!
    var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLoginUI()
        action()
    }
    

}
