//
//  MainTabBarController.swift
//  来客
//
//  Created by wsk on 2018/11/10.
//  Copyright © 2018年 wsk. All rights reserved.
//

import UIKit
import ESTabBarController_swift

class MainTabBarController: ESTabBarController {

    @IBOutlet weak var p_tabBar: ESTabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.shadowImage = UIImage(named: "transparent")
        self.tabBar.backgroundImage = UIImage(named: "background_dark")
        self.shouldHijackHandler = { tabbarController, viewController, index in
            if index == 1 {
                return true
            }
            return false
        }
        self.didHijackHandler = { [weak self] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
                alertController.addAction(takePhotoAction)
                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
                alertController.addAction(selectFromAlbumAction)
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self?.present(alertController, animated: true, completion: nil)
            }
        }
        if let vc0 = self.viewControllers?[0] {
            vc0.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(),
                                               title: "Home",
                                               image: UIImage(named: "home"),
                                               selectedImage: UIImage(named: "home_1"))
        }
        if let vc1 = self.viewControllers?[1] {
            vc1.tabBarItem = ESTabBarItem.init(IrregularityContentView(),
                                               title: nil,
                                               image: UIImage(named: "photo_verybig"),
                                               selectedImage: UIImage(named: "photo_verybig"))
        }
        if let vc2 = self.viewControllers?[2] {
            vc2.tabBarItem = ESTabBarItem.init(IrregularityBasicContentView(),
                                               title: "Me",
                                               image: UIImage(named: "me"),
                                               selectedImage: UIImage(named: "me_1"))
        }
    }
}
