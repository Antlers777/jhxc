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
import KeychainSwift


let keychain = KeychainSwift()
var layerDict: Dictionary<String, AGSKMLLayer>!

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    //var isNotFirst = UserDefaults.standard.bool(forKey: "isFirst")
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        layerDict = [:]
        
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = LoginViewController()
        window?.makeKeyAndVisible()
        
        /**
            设置此appUI为亮模式
         */
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        
        /**
            将设备第一次安装应用时的uuid储存在钥匙串中，以便以后区分设备唯一性。
         */
        //keychain.clear()
        if let uuid = keychain.get("uuid") { // 并非第一次安装程序
            // 查询设备手机号添加界面，存在直接跳转主页使用
            AF.request("http://61.240.19.180:8000/jinghai/jhxc/querycan", method: .get, parameters: ["iosNumber": uuid]).responseJSON{ response in
                let json = JSON(response.data!)
                switch response.result {
                case .success:
                    if json["data"] == "true" {
                        // 允许使用
                        let root = RootViewController()
                        self.window?.rootViewController = root
                    } else if json["data"] == "false"{
                        // 不允许使用 闪退
                        self.shantui()
                    } else {
                        // 没有检测到设备与手机号提交到服务器 跳转手机号添加界面
                    }
                    break
                case .failure(let err): break
                    // 提示网络错误
                }
            }
        } else { // 第一次安装程序，此时uuid为空，即将获取uuid设置。
            keychain.set(UIDevice.current.identifierForVendor?.uuidString ?? "unclear", forKey: "uuid")
        }
        
        UserDefaults.standard.set(false, forKey: "edit")
        UserDefaults.standard.set(false, forKey: "kml")
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

