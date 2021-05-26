//
//  LoginModel.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/18.
//

import Foundation
import UIKit
import RxSwift
import Alamofire
import SwiftyJSON

extension LoginViewController {
    func action() {
        let iphoneValid = iphoneNumber.rx.text.orEmpty
            .map{ self.isPhoneNumber(phoneNumber: $0)}
            .share(replay: 1)
        
        let clearValid = iphoneNumber.rx.text.orEmpty
            .map{ $0.count > 0}
            .share(replay: 1)
        
        clearValid
            .bind(to: clearButton.rx.isEnabled)
            .disposed(by: disposeBag) // 手机号为空 清空按钮才可点击
        iphoneValid
            .bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag) // 符合手机号正则才可点击
        iphoneValid
            .bind(to: iphoneNumberVaild.rx.isHidden)
            .disposed(by: disposeBag)
        clearButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.clearIphoneNumber()})
            .disposed(by: disposeBag)
        saveButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.login()})
            .disposed(by: disposeBag)
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
    
    func clearIphoneNumber() {
        // 清空
        iphoneNumber.text = ""
    }
    
    func login() {
        // 登陆
        let parameter = [
            "iphoneNumber": iphoneNumber.text!,
            "iosNumber": keychain.get("uuid"),
            "can" : "true"
        ]
        // 向服务器发送设备信息 (设备uuid\手机号\是否可以使用)
        AF.request("http://61.240.19.180:8000/jinghai/jhxc/addios", method: .post, parameters: parameter, encoder: URLEncodedFormParameterEncoder(destination: .httpBody)).responseString{ response in
            switch response.result {
            case .success:
                if (response.value! == "success") { // 允许使用
                    let rootVC = RootViewController()
                    rootVC.modalPresentationStyle = .fullScreen
                    self.present(rootVC, animated: true, completion: nil)
                } else { // 不允许使用 闪退
                    // shantui
                    let b = UIButton()
                    b.snp.makeConstraints({ make in
                        make.width.equalToSuperview()
                    })
                }
                break
            case let .failure(error): // 网络请求错误
                print(error)
                break
            }
        }
    }
}
