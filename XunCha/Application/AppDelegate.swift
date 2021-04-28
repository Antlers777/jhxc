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
import ArcGIS
@main


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //var isNotFirst = UserDefaults.standard.bool(forKey: "isFirst")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        if #available(iOS 13.0, *) {
//            self.window?.overrideUserInterfaceStyle = .light
//        } else {
//            // Fallback on earlier versions
//        }
//
//        if !isNotFirst {
//            UserDefaults.standard.set(true, forKey: "isFirst")
//            UserDefaults.standard.synchronize()
//            // 跳转 填写手机号的界面
//            let first = FirstViewController()
//            window?.rootViewController = first
//
//        } else {
//
//
//            // 判断 是否可以进入
//            if (UIDevice.current.identifierForVendor?.uuidString == nil) {
//                // shantui
//                shantui()
//            } else {
//                DispatchQueue.main.async {
//                    //http://61.240.19.180:8000/jinghai/jhxc/queryios
//                    AF.request("http://61.240.19.180:8000/jinghai/jhxc/querycan", method: .get, parameters: ["iosNumber": UIDevice.current.identifierForVendor!.uuidString]).responseJSON{ response in
//                        let json = JSON(response.data)
//                        switch response.result {
//                        case .success:
//
//                            if json["data"] == "true" {
//                                print("成功")
//                                goon = true
//                                mapView.map?.basemap = AGSBasemap(baseLayer: jhyxLayer)
//                            } else if json["data"] == "false"{
//                                self.shantui()
//                            } else {
//                                goon = false
//                                let first = FirstViewController()
//                                self.window?.rootViewController = first
//                            }
//                            break
//                        case .failure(let err):
//                            self.shantui()
//                        }
//                    }
//                }
//
//            }
//
//        }
        goon = true
        UserDefaults.standard.set(false, forKey: "edit")
        UserDefaults.standard.set(false, forKey: "mark")
        return true
    }
    
    func shantui() {
        let b = UIButton()
        b.snp.makeConstraints({ make in
            make.width.equalToSuperview()
        })
    }
}

