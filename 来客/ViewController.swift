//
//  ViewController.swift
//  来客
//
//  Created by wsk on 2018/11/4.
//  Copyright © 2018年 wsk. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {

    @IBOutlet weak var p_imageView: UIImageView!
    @IBOutlet weak var gotoBaiduMap: UIButton!
    @IBAction func gotoBaiduMapAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "BaiduMap", bundle: nil).instantiateViewController(withIdentifier: "baiduMapViewController")
        vc.title = "百度地图"
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //p_imageView.kf.setImage(with: URL.init(string: "https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=2db36eed022442a7b10efba5e142ad95/4d086e061d950a7bb1ea1aaa07d162d9f3d3c985.jpg"))
    }
}

