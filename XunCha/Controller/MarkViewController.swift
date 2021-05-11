//
//  MarkViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/4/27.
//

import UIKit
import SnapKit
import ImagePicker
import RxSwift
import RxCocoa
import ArcGIS

let disposeBag = DisposeBag.init()
class MarkViewController: UIViewController {
    
    // 用来接长按手势传递的参数
    var point: AGSPoint = AGSPoint(x: 0, y: 0, spatialReference: AGSSpatialReference(wkid: 4548))
    var type = 0
    
    var name: UILabel!
    var markName: UITextField!
    var nameTip: UILabel!
    
    var info: UILabel!
    var markInfo: UITextView!
    var infoTip: UILabel!
    
    var addPhotoBtn: UIButton!
    var justSaveBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置UI
        setMarkVCUI()
        
        let nameValid = markName.rx.text.orEmpty
            .map{ $0.count > 0}
            .share(replay: 1)
        let infoValid = markInfo.rx.text.orEmpty
            .map{ $0.count > 0}
            .share(replay: 1)
        let bothValid = Observable.combineLatest(
                nameValid,
                infoValid
            ) {$0 && $1}
            .share(replay: 1)
        nameValid
            .bind(to: markInfo.rx.isUserInteractionEnabled)
            .disposed(by: disposeBag)
        nameValid
            .bind(to: nameTip.rx.isHidden)
            .disposed(by: disposeBag)
        
        infoValid.bind(to: infoTip.rx.isHidden)
            .disposed(by: disposeBag)
        
        
        bothValid.bind(to: addPhotoBtn.rx.isEnabled)
            .disposed(by: disposeBag)
            
        bothValid.bind(to: justSaveBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        addPhotoBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.addPhoto()})
            .disposed(by: disposeBag)
           
        justSaveBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.saveMark()})
            .disposed(by: disposeBag)

        
    }
    
    private func setMarkVCUI() {
        self.view.backgroundColor = .white
        self.title = "标记设置"
        
        name = UILabel()
        nameTip = UILabel()
        markName = UITextField()
        info = UILabel()
        infoTip = UILabel()
        markInfo = UITextView()
        addPhotoBtn = UIButton()
        justSaveBtn = UIButton()
        
        view.addSubview(name)
        view.addSubview(markName)
        view.addSubview(nameTip)
        view.addSubview(info)
        view.addSubview(markInfo)
        view.addSubview(infoTip)
        view.addSubview(addPhotoBtn)
        view.addSubview(justSaveBtn)
        
        
        name.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        })
        name.text = "标记名称"
        name.textColor = .gray
        
        markName.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(name.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        })
        markName.layer.borderWidth = 1
        markName.layer.borderColor = UIColor.gray.cgColor
        
        nameTip.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(20)
            make.top.equalTo(markName.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        })
        nameTip.text = "需要输入你的名称"
        nameTip.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        nameTip.textColor = .red
        
        info.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(markName.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        })
        info.text = "标记内容"
        info.textColor = .gray
        
        markInfo.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(info.snp.bottom).offset(0)
        })
        markInfo.layer.borderWidth = 1
        markInfo.layer.borderColor = UIColor.gray.cgColor
        
        infoTip.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(20)
            make.top.equalTo(markInfo.snp.bottom).offset(0)
            make.centerX.equalToSuperview()
        })
        infoTip.text = "需要输入你的内容"
        infoTip.font = UIFont.systemFont(ofSize: 14.0, weight: .light)
        infoTip.textColor = .red
        
        addPhotoBtn.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(markInfo.snp.bottom).offset(60)
            make.centerX.equalToSuperview()
        })
        addPhotoBtn.backgroundColor = .systemBlue
        addPhotoBtn.setTitle("添加照片", for: .normal)
        //addPhotoBtn.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        
        
        justSaveBtn.snp.makeConstraints({make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(40)
            make.top.equalTo(addPhotoBtn.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        })
        justSaveBtn.backgroundColor = .systemBlue
        justSaveBtn.setTitle("直接保存", for: .normal)
        //justSaveBtn.addTarget(self, action: #selector(saveMark), for: .touchUpInside)
        
        markInfo.isEditable = true
        markInfo.isSelectable = true
        markInfo.font = .systemFont(ofSize: 14)
        markInfo.textColor = .gray
        markInfo.textAlignment = .natural
        
        // 导航栏
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: .trashMarkSelector)
        
        
        
        
    }
    
    // action
    
    @objc func addPhoto() {
        let configuration = Configuration()
        configuration.noImagesTitle = "抱歉！这里没有图片！"
        configuration.doneButtonTitle = "保存"
        configuration.cancelButtonTitle = "结束"
        
        let imagePickerController = ImagePickerController(configuration: configuration)
        imagePickerController.delegate = self
        imagePickerController.imageLimit = 1
        
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func trashMark(_ sender: Any) {
        
    }
    @objc func changeCalloutStyle(_ sender: Any) {
    }
    @objc func saveMark() { // save mark
        // 向数据库中添加该标记 成功则返回主页，否则提示失败
        let mark = Mark()
        mark.name = markName.text ?? "未知"
        mark.info = markInfo.text ?? "未知"
        mark.x = point.x
        mark.y = point.y
        mark.sr = point.spatialReference!.wkid
        mark.type = type
        mark.save()
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension MarkViewController: ImagePickerDelegate {
    func wrapperDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("wrapperDidPress")
        // 选择了照片墙
    }
    
    func doneButtonDidPress(_ imagePicker: ImagePickerController, images: [UIImage]) {
        print("完成照片拍摄 直接保存该标注")
        // 完成照片拍摄 直接保存该标注
        let mark = Mark()
        mark.name = markName.text ?? "未知"
        mark.info = markInfo.text ?? "未知"
        mark.x = point.x
        mark.y = point.y
        mark.sr = point.spatialReference!.wkid
        mark.type = type
        
        mark.save()
        switch type {
        case 0:
            let normalSymbol = AGSTextSymbol(text: "★", color: .yellow, size: 35, horizontalAlignment: .center, verticalAlignment: .middle)
            let normalGraphic = AGSGraphic(geometry: point, symbol: normalSymbol, attributes: nil)
            graphicsOverlay.graphics.add(normalGraphic)
        case 1:
            let normalSymbol = AGSTextSymbol(text: "✘", color: .red, size: 35, horizontalAlignment: .center, verticalAlignment: .middle)
            let normalGraphic = AGSGraphic(geometry: point, symbol: normalSymbol, attributes: nil)
            graphicsOverlay.graphics.add(normalGraphic)
        case 2:
            let textSymbol = AGSTextSymbol(text: markName.text!, color: UIColor(red: 124/255, green: 252/255, blue: 0/255, alpha: 1), size: 22, horizontalAlignment: .center, verticalAlignment: .middle)
            let graphic = AGSGraphic(geometry: point, symbol: textSymbol, attributes: nil)
            graphicsOverlay.graphics.add(graphic)
        default:
            break
        }
        
        // 回退到地图界面
    }
    
    func cancelButtonDidPress(_ imagePicker: ImagePickerController) {
        print("结束拍照 回到标注信息填写界面")
        
        // 结束拍照 回到标注信息填写界面
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
