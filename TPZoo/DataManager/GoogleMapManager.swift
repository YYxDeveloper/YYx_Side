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
    private let releaseZoomLevel:Float = 16.0
    private let debugZoomLevel:Float = 15.0
    private let bearingAngle:Double = 120.0
    static var isFirstLoading = true

    static let VerticalGetBackComplementary =  0.0035
    static let HorizetalGetBackComplementary = 0.0025
    static let VerticalBoaderComplementary =  0.003
    static let HorizetalBoaderComplementary =  0.002


    enum model {
        case release,debug
    }
    enum center:Double {
        case lat = 24.99620900530806
        case lon = 121.58524207770824
    }
    enum coordinate:Double {
        case bottomLimitPoint   = 24.989200
        case topLimitPoint      = 25.001500//+越外
        case leftLimitPoint     = 121.578600
        case rightLimitPoint    = 121.593457//+越外
    }
    enum blackCoordinate{
        
        //25.017, 121.543313
        enum topleft:Double {
            case lat = 25.017
            case lon = 121.543313
        }
        enum topRight:Double {
            case lat = 25.017
            case lon = 121.620093
        }
        enum bottomRight:Double {
            //24.966259, 121.597093
            
            case lat = 24.966259
            case lon = 121.620093
        }
        enum bottomleft:Double {
            case lat = 24.966259
            case lon = 121.543313
        }
    }
    static let shared = GoogleMapManager()
    static let apiKey = "AIzaSyC7OH2HcJ0Iko-bGY1U9r9y56AN1SC70mU"
    var mapView = GMSMapView()
    /**
     plist need setting Privacy - Location When In Use Usage Description
     */
    static let locationManager = GoogleMapManager.newLocationManager()
    
    static private func newLocationManager() -> CLLocationManager{
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        
        return locationManager
    }
    func initZooMapView(model:model) -> GMSMapView{
       
            switch model {
            case .release:
                let centerCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(24.996209, 121.585242), zoom: self.releaseZoomLevel, bearing: self.bearingAngle, viewingAngle: 0)
                mapView = GMSMapView.map(withFrame: CGRect.zero, camera: centerCamera)
                mapView.setMinZoom(17, maxZoom: 20)
            case .debug:
                let centerCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(24.996209, 121.585242), zoom: self.debugZoomLevel, bearing: 0, viewingAngle: 0)
                 self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: centerCamera)
                mapView.setMinZoom(self.debugZoomLevel, maxZoom: 20)
            }
        mapView.mapStyle = GoogleMapManager.shared.getMapStyle()
        let polygon = GMSPolygon()
        polygon.path = GoogleMapManager.drawBlackAreaPath()
        polygon.holes = [GoogleMapManager.drawAreaPath()]
        polygon.fillColor = .black
        polygon.strokeWidth = 2
        polygon.map = mapView
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.rotateGestures = false
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return self.mapView
    }
    private func addGMSMarker(cordinate:CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = cordinate
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
        UIView.animate(withDuration: 10, animations: {
            
            
        })
    }
    
    static func checkFirstLoading(with mapView:GMSMapView,position: GMSCameraPosition) -> Bool {
        if GoogleMapManager.isFirstLoading {
            GoogleMapManager.shared.editeMapBoardLine(with: mapView, position: position)
        }else if position.target.latitude == GoogleMapManager.center.lat.rawValue && position.target.longitude == GoogleMapManager.center.lon.rawValue {
            GoogleMapManager.isFirstLoading  = false
        }
        return GoogleMapManager.isFirstLoading
    }
//MARK: Edite Position
     func changeMarkertype(with zoomLevel:Float)-> GMSMapView{
        self.mapView.clear()
        switch zoomLevel {
        case 17.0:
            GoogleMapManager.shared.addGMSMarker(cordinate: CLLocationCoordinate2DMake(GoogleMapManager.center.lat.rawValue, GoogleMapManager.center.lon.rawValue))
            
            print("xxxxx")
        default:
            print("gggg")
        }
        
        return self.mapView
    }
    
//MARK: Private func
    private func editeMapBoardLine(with mapView:GMSMapView ,position: GMSCameraPosition) {
        if (position.target.latitude > GoogleMapManager.coordinate.topLimitPoint.rawValue - GoogleMapManager.VerticalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .topLimitPoint, respondPosition: position, mapView: mapView)
        }
        if (position.target.latitude < GoogleMapManager.coordinate.bottomLimitPoint.rawValue + GoogleMapManager.VerticalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .bottomLimitPoint, respondPosition: position, mapView: mapView)
            
        }
        if (position.target.longitude < GoogleMapManager.coordinate.leftLimitPoint.rawValue + GoogleMapManager.HorizetalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .leftLimitPoint, respondPosition: position, mapView: mapView)
            
        }
        if (position.target.longitude > GoogleMapManager.coordinate.rightLimitPoint.rawValue - GoogleMapManager.HorizetalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .rightLimitPoint, respondPosition: position, mapView: mapView)
        }
        
    }
    private func updateCamerapostion(limitSide:GoogleMapManager.coordinate, respondPosition:GMSCameraPosition,mapView:GMSMapView){
        var goBackCamera = GMSCameraPosition()
        switch limitSide {
        case .topLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(limitSide.rawValue -  GoogleMapManager.VerticalGetBackComplementary, respondPosition.target.longitude), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle:0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .bottomLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(limitSide.rawValue +  GoogleMapManager.VerticalGetBackComplementary, respondPosition.target.longitude), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .leftLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(respondPosition.target.latitude,limitSide.rawValue +  GoogleMapManager.HorizetalGetBackComplementary), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .rightLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(respondPosition.target.latitude,limitSide.rawValue -  GoogleMapManager.HorizetalGetBackComplementary), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        }
        
    }
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
    private static func drawBlackAreaPath() -> GMSMutablePath{
        let areaPath = GMSMutablePath()
        let blackTopLeft = CLLocationCoordinate2DMake(blackCoordinate.topleft.lat.rawValue, blackCoordinate.topleft.lon.rawValue)
         let blackTopRight = CLLocationCoordinate2DMake(blackCoordinate.topRight.lat.rawValue, blackCoordinate.topRight.lon.rawValue)
         let blackBottomRight = CLLocationCoordinate2DMake(blackCoordinate.bottomRight.lat.rawValue, blackCoordinate.bottomRight.lon.rawValue)
         let blackBottomLeft = CLLocationCoordinate2DMake(blackCoordinate.bottomleft.lat.rawValue, blackCoordinate.bottomleft.lon.rawValue)
        
        areaPath.add(blackTopRight)
        areaPath.add(blackBottomRight)
        areaPath.add(blackBottomLeft)
        areaPath.add(blackTopLeft)
        areaPath.add(blackTopRight)
        return areaPath
    }
    private func getMapStyle() -> GMSMapStyle {
        do {
            
            guard let filepath = Bundle.main.url(forResource: "GoogleMapStyle", withExtension: "txt") else {
                print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                return GMSMapStyle()
            }
            return  try GMSMapStyle(contentsOfFileURL: filepath)
        } catch  {
            print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
            return GMSMapStyle()
        }
        
        
    }
    
}
