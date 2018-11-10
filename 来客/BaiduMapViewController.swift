//
//  BaiduMapViewController.swift
//  来客
//
//  Created by wsk on 2018/11/8.
//  Copyright © 2018年 wsk. All rights reserved.
//

import UIKit
import MapKit
class CustomOverlay: BMKPolyline {
    init(points: [BMKMapPoint]?, count: Int) {
        super.init()
        if points != nil {
            setPolylineWithPoints(UnsafeMutablePointer<BMKMapPoint>(mutating: points!), count: count)
        }
    }
}
class CustomOverlayView: BMKOverlayGLBasicView {
    var customOverlay: CustomOverlay!
    override func glRender() {
        if customOverlay == nil {
            return;
        }
        let fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5)
        renderRegion(withPoints: customOverlay.points, pointCount: UInt(customOverlay.pointCount), fill: fillColor, usingTriangleFan: true)
    }
}
class MyAnnotation: BMKAnnotationView {
    var p_image:UIImageView = UIImageView.init()
    override init!(annotation: BMKAnnotation!, reuseIdentifier: String!) {
        
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        self.p_image.frame = self.frame
        p_image.contentMode = .scaleAspectFit
        self.addSubview(p_image)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaiduMapViewController: BMKLocationManagerDelegate {
    func bmkLocationManager(_ manager: BMKLocationManager, didUpdate location: BMKLocation?, orError error: Error?) {
        if let curLocation = location {
            //            if p_mapView.annotations.contains(where: { (pointAnnotation) -> Bool in
            //                return true
            //            })
            //self.addCustomOverlay(center: curLocation.location?.coordinate ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0))
            pointAnnotation.coordinate = curLocation.location?.coordinate ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0)
            pointAnnotation.title = "1"
            p_mapView.addAnnotation(pointAnnotation)
            p_mapView.setCenter(curLocation.location?.coordinate ?? CLLocationCoordinate2D.init(latitude: 0, longitude: 0), animated: true)
        }
    }
}
extension BaiduMapViewController: BMKMapViewDelegate {
    
}
class BaiduMapViewController: UIViewController {

    @IBOutlet weak var p_mapView: BMKMapView!
    let locationService:BMKLocationManager = BMKLocationManager.init()
    let pointAnnotation:BMKPointAnnotation = BMKPointAnnotation.init()
    
    func baiduMapLocation() {
        p_mapView.zoomLevel = 18
        p_mapView.showsUserLocation = true
        locationService.delegate = self
        locationService.distanceFilter = kCLDistanceFilterNone
        locationService.desiredAccuracy = kCLLocationAccuracyBest
        locationService.coordinateType = .BMK09LL
        locationService.startUpdatingLocation()
    }
    func addCustomOverlay(center: CLLocationCoordinate2D) {
        //创建圆形覆盖物对象
        let cirle:BMKCircle = BMKCircle.init(center: center, radius: 200)
        p_mapView.add(cirle)
    }
    
    // MARK: - BMKMapViewDelegate
    /**
     *根据overlay生成对应的View
     *@param mapView 地图View
     *@param overlay 指定的overlay
     *@return 生成的覆盖物View
     */
    func mapView(_ mapView: BMKMapView!, viewFor overlay: BMKOverlay!) -> BMKOverlayView! {
        if let curOverlay = overlay as? CustomOverlay {
            let customOverlayView = CustomOverlayView()
            customOverlayView.customOverlay = curOverlay
            return customOverlayView
        }
        if let curOverlay = overlay as? BMKCircle {
            let circleView:BMKCircleView = BMKCircleView.init(circle: curOverlay)
            circleView.strokeColor = .red
            circleView.lineWidth = 1
            circleView.fillColor = .clear
            return circleView
        }
        return nil
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.baiduMapLocation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        p_mapView.viewWillAppear()
        p_mapView.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        p_mapView.viewWillDisappear()
        p_mapView.delegate = nil
    }
}
