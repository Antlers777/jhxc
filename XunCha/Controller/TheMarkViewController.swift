//
//  TheMarkViewController.swift
//  XunCha
//
//  Created by 赵晓桐 on 2021/5/8.
//

import UIKit
import SnapKit

class TheMarkViewController: UIViewController {
    
    
    var name: UILabel!
    var info: UILabel!
    let images = ["2421620366563_.pic","picture","trash"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        //生成缩略图
        for i in 0..<images.count{
            //创建ImageView
            let imageView = UIImageView()
            imageView.frame = CGRect(x:20+i*70, y:80, width:60, height:60)
            
            imageView.tag = i
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = UIImage(named: images[i])
            //设置允许交互（后面要添加点击）
            imageView.isUserInteractionEnabled = true
            self.view.addSubview(imageView)
            imageView.snp.makeConstraints({make in
                make.width.height.equalTo(60)
                make.left.equalToSuperview().offset(20+i*70)
                make.top.equalToSuperview().offset(300)
            })
            //添加单击监听
            let tapSingle=UITapGestureRecognizer(target:self,
                                                 action:#selector(imageViewTap(_:)))
            tapSingle.numberOfTapsRequired = 1
            tapSingle.numberOfTouchesRequired = 1
            imageView.addGestureRecognizer(tapSingle)
        }
        
    }
    
    //缩略图imageView点击
    @objc func imageViewTap(_ recognizer:UITapGestureRecognizer){
        //图片索引
        let index = recognizer.view!.tag
        //进入图片全屏展示
        let previewVC = ImagePreviewViewController(images: images, index: index)
        let nav = UINavigationController(rootViewController: previewVC)
        nav.modalPresentationStyle = .fullScreen
        //self.navigationController?.pushViewController(previewVC, animated: true)
        self.present(nav, animated: true, completion: nil)
    }
     
    

}
