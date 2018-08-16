//
//  GoogleMapManager.swift
//  TPZoo
//
//  Created by HSI on 2018/8/14.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import GoogleMaps

/**
 must init in viewDidAppear
 */
class GoogleMapManager {
    
    enum coordinate:Double {
        case bottomLimitPoint   = 24.989729
        case topLimitPoint      = 25.000114
        case leftLimitPoint     = 121.579269
        case rightLimitPoint    = 121.591107
    }
   
    static let shared = GoogleMapManager()
    static let apiKey = "AIzaSyC7OH2HcJ0Iko-bGY1U9r9y56AN1SC70mU"
    let mapView = GoogleMapManager.newZooMapView()
    /**
     plist need setting Privacy - Location When In Use Usage Description
     */
    let locationManager = GoogleMapManager.newLocationManager()
    
    static private func newLocationManager() -> CLLocationManager{
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        return locationManager
    }
    static private func newZooMapView() ->GMSMapView{
        // +rotation
        let camera = GMSCameraPosition.camera(withLatitude: 24.997134, longitude: 121.585503, zoom: 14)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(14, maxZoom: 20)



        let pathLine =  GMSPolyline.init(path: GoogleMapManager.drawAreaPath())
        pathLine.strokeWidth = 10.0;
        pathLine.strokeColor = .red
        pathLine.map = mapView

        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.myLocationButton = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.animate(toBearing: 120)
        
        
        return mapView
    }
     func addGMSMarker(cordinate:CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = cordinate
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
    }
//MARK: Private func
     private static func drawAreaPath() -> GMSMutablePath{
        
        let rightTop = CLLocationCoordinate2DMake(coordinate.topLimitPoint.rawValue, coordinate.rightLimitPoint.rawValue)
        let rightBootom = CLLocationCoordinate2DMake(coordinate.bottomLimitPoint.rawValue, coordinate.rightLimitPoint.rawValue)//24.988729 上下
        let leftBootom = CLLocationCoordinate2DMake(coordinate.bottomLimitPoint.rawValue,coordinate.leftLimitPoint.rawValue)
        let leftTop = CLLocationCoordinate2DMake(coordinate.topLimitPoint.rawValue,coordinate.leftLimitPoint.rawValue)
        let areaPath = GMSMutablePath()
        areaPath.add(rightTop)
        areaPath.add(rightBootom)
        areaPath.add(leftBootom)
        areaPath.add(leftTop)
        areaPath.add(rightTop)
        
        return areaPath
    }
    
    
}
