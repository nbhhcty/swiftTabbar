//
//  AppDelegate.swift
//  来客
//
//  Created by wsk on 2018/11/4.
//  Copyright © 2018年 wsk. All rights reserved.
//

import UIKit

extension AppDelegate: BMKGeneralDelegate {
    func onGetNetworkState(_ iError: Int32) {
        if (0 == iError) {
            print("联网成功")
        }
        else{
            print("联网失败，错误代码：Error\(iError)")
        }
    }
    func onGetPermissionState(_ iError: Int32) {
        if (0 == iError) {
            print("授权成功")
        }
        else{
            print("授权失败，错误代码：Error\(iError)")
        }
    }
}
extension AppDelegate: BMKLocationAuthDelegate {
    
}
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var _mapManager: BMKMapManager?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 初始化定位SDK
        BMKLocationAuth.sharedInstance().checkPermision(withKey: "rLM4u9h3UUZ8baGCgKMmhM8b4mVwGjmw", authDelegate: self)
        /**
         *百度地图SDK所有接口均支持百度坐标（BD09）和国测局坐标（GCJ02），用此方法设置您使用的坐标类型.
         *默认是BD09（BMK_COORDTYPE_BD09LL）坐标.
         *如果需要使用GCJ02坐标，需要设置CoordinateType为：BMK_COORDTYPE_COMMON.
         */
        if BMKMapManager.setCoordinateTypeUsedInBaiduMapSDK(BMK_COORD_TYPE.COORDTYPE_BD09LL) {
            NSLog("经纬度类型设置成功");
        } else {
            NSLog("经纬度类型设置失败");
        }
        // 要使用百度地图，请先启动BaiduMapManager
        _mapManager = BMKMapManager()
        // 如果要关注网络及授权验证事件，请设定generalDelegate参数
        let ret = _mapManager?.start("rLM4u9h3UUZ8baGCgKMmhM8b4mVwGjmw", generalDelegate: self)
        if ret == false {
            NSLog("manager start failed!")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

