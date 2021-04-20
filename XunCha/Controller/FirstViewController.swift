//
//  FirstViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/16.
//

import UIKit
import Alamofire
import MBProgressHUD

class FirstViewController: UIViewController {

    
    var iphoneNum = UITextField()
    var iphoneButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(iphoneNum)
        self.view.addSubview(iphoneButton)
        self.view.backgroundColor = .white
        
        iphoneNum.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(200)
        })
        iphoneNum.layer.cornerRadius = 0
        iphoneNum.layer.borderWidth = 1
        iphoneNum.layer.borderColor = UIColor.gray.cgColor
        iphoneNum.placeholder = "请添加你的手机号"
        
        iphoneButton.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(iphoneNum.snp.bottom).offset(40)
        })
        iphoneButton.setTitle("保    存", for: .normal)
        iphoneButton.layer.cornerRadius = 0
        iphoneButton.layer.borderWidth = 1
        iphoneButton.layer.borderColor = UIColor.gray.cgColor
        iphoneButton.backgroundColor = .systemBlue
        
        iphoneButton.addTarget(self, action: #selector(saveIphoneNumber), for: .touchUpInside)
    }
    
    
    @objc func saveIphoneNumber() {
        if isPhoneNumber(phoneNumber: iphoneNum.text ?? "") {
            if (UIDevice.current.identifierForVendor?.uuidString == nil) {
                // shantui
                let b = UIButton()
                b.snp.makeConstraints({ make in
                    make.width.equalToSuperview()
                })
            } else {
                
                let parameter = [
                    "iphoneNumber": iphoneNum.text!,
                    "iosNumber": UIDevice.current.identifierForVendor!.uuidString
                ]
                AF.request("http://192.168.31.126:8080/jhxc/addios", method: .post, parameters: parameter, encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseString{ response in
                    switch response.result {
                    case .success:
                        if (response.value! == "success") {
                            let rootVC = RootViewController()
                            let nav = UINavigationController(rootViewController: rootVC)
                            nav.modalPresentationStyle = .fullScreen
                            self.present(nav, animated: true, completion: nil)
                        } else {
                            // shantui
                            let b = UIButton()
                            b.snp.makeConstraints({ make in
                                make.width.equalToSuperview()
                            })
                        }
                        break
                    case let .failure(error):
                        print(error)
                        break
                    }
                }
            }
        } else {
            // 
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud.mode = .text
            hud.label.text = "手机号格式不正确"
            hud.animationType = .fade
            hud.hide(animated: true, afterDelay: 2)
        }
        
    }
    
    //验证手机号
    func isPhoneNumber(phoneNumber:String) -> Bool {
        if phoneNumber.count == 0 {
            return false
        }
        let mobile = "^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$"
        let regexMobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        if regexMobile.evaluate(with: phoneNumber) == true {
            return true
        } else {
            return false
        }
    }

}
