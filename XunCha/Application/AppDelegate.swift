//
//  AppDelegate.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/12.
//

import UIKit
import SideMenu
import Alamofire
import SwiftyJSON
@main

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var isNotFirst = UserDefaults.standard.bool(forKey: "isFirst")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        if !isNotFirst {
            UserDefaults.standard.set(true, forKey: "isFirst")
            UserDefaults.standard.synchronize()
            print("第一次")
            // 跳转 填写手机号的界面
            let first = FirstViewController()
            window?.rootViewController = first
            
        } else {
            print("不是第一次")
            // 判断 是否可以进入
            if (UIDevice.current.identifierForVendor?.uuidString == nil) {
                // shantui
                shantui()
            } else {
                AF.request("http://192.168.31.126:8080/jhxc/queryios", method: .get, parameters: ["iosNumber": UIDevice.current.identifierForVendor!.uuidString]).responseJSON{ response in
                    let json = JSON(response.data)
                    switch response.result {
                    case .success:
                        
                        if json["data"] == "200" {
                            // 查询到结果 具有许可 可以使用
//                            let rootVC = RootViewController()
//                            let nav = UINavigationController(rootViewController: rootVC)
//                            self.window?.rootViewController = nav
                        } else {
                            self.shantui()
                        }
                        break
                    case .failure(let err):
                        self.shantui()
                    }
                }
            }
            
        }
        UserDefaults.standard.set(false, forKey: "edit")
        UserDefaults.standard.set(false, forKey: "location")
        
        return true
    }
    
    func shantui() {
        let b = UIButton()
        b.snp.makeConstraints({ make in
            make.width.equalToSuperview()
        })
    }
}

