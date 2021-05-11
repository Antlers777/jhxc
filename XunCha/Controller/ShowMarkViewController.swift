//
//  ShowMarkViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/10.
//

import UIKit
import SnapKit
import ImagePicker
import MBProgressHUD

class ShowMarkViewController: UIViewController {
    var mark = Mark()
    var x = Double()
    var y = Double()
    var sr = Int()
    
    var name: UILabel!
    var info: UILabel!
    var addPhotoBtn: UIButton!
    var imageView: UIImageView!
    //let reShotBtn: UIBarButtonItem = UIBarButtonItem(title: "重新拍摄", style: .done, target: self, action: #selector(reShot))
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(backToRoot))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashMark))
        
        name = UILabel()
        info = UILabel()
        addPhotoBtn = UIButton()
        imageView = UIImageView()
        view.addSubview(name)
        view.addSubview(info)
        view.addSubview(addPhotoBtn)
        view.addSubview(imageView)
        
        name.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        })
        name.text = "One Mark"
        
        info.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(name.snp.bottom).offset(0)
        })
        info.text = "One Mark for the app"
        
        addPhotoBtn.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalTo(info.snp.bottom).offset(40)
        })
        addPhotoBtn.setTitle("添加照片", for: .normal)
        addPhotoBtn.backgroundColor = .systemBlue
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.top.equalTo(info.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        })
        imageView.isHidden = true
        
        addPhotoBtn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        
        mark = Mark.rows(filter: "x='\(x)' and y='\(y)' and sr='\(sr)'").first!
        name.text = mark.name
        info.text = mark.info
        if mark.data != (UIImage(named: "picture")?.pngData())! {
            addPhotoBtn.isHidden = true
            imageView.isHidden = false
            imageView.image = UIImage(data: mark.data)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "重新拍摄", style: .done, target: self, action: #selector(reShot))
        }
    }
    
    @objc func openCamera() {
        let configuration = Configuration()
        configuration.noImagesTitle = "抱歉！这里没有图片！"
        configuration.doneButtonTitle = "保存"
        configuration.cancelButtonTitle = "结束"
        
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func trashMark() {
        mark.delete()
        self.dismiss(animated: true, completion: nil)
        graphicsOverlay.graphics.remove(calloutGraphic)
    }
    
    
    @objc func backToRoot() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func savePhoto() {
        print("保存照片")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func reShot() {
        let configuration = Configuration()
        configuration.noImagesTitle = "抱歉！这里没有图片！"
        configuration.doneButtonTitle = "保存"
        configuration.cancelButtonTitle = "结束"
        
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ShowMarkViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapper")
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("done")
        guard !images.isEmpty else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        //let mark = Mark.rows(filter: "x='\(x)' and y='\(y)' and sr='\(sr)'").first!
        mark.data = images.first!.jpegData(compressionQuality: 0.8)!
        mark.save()
        imageView.image = images.first
        addPhotoBtn.isHidden = true
        imageView.isHidden = false
        
        self.dismiss(animated: true, completion: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "重新拍摄", style: .done, target: self, action: #selector(reShot))
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("cancel")
    }
    
    
}

