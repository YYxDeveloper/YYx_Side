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
    static let VerticalGetBackComplementary =  0.0035
    static let HorizetalGetBackComplementary = 0.0025
    static let VerticalBoaderComplementary =  0.003
    static let HorizetalBoaderComplementary =  0.002

    static var isFirstLoading = true

   private static let bearingAngle = 0.0
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
   static let mapView = GoogleMapManager.shared.newZooMapView()
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
     private func newZooMapView() ->GMSMapView{
        func chooseMdel(model:model) ->GMSMapView{
            switch model {
            case .release:
                let centerCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(24.996209, 121.585242), zoom: 17, bearing: GoogleMapManager.bearingAngle, viewingAngle: 0)
                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: centerCamera)
                mapView.setMinZoom(17, maxZoom: 20)
                mapView.mapStyle = GoogleMapManager.getMapStyle()
                let polygon = GMSPolygon()
                polygon.path = GoogleMapManager.drawBlackAreaPath()
                polygon.holes = [GoogleMapManager.drawAreaPath()]
                polygon.fillColor = .black
                //        polygon.strokeColor = .blue
                polygon.strokeWidth = 2
                polygon.map = mapView
                
                mapView.isMyLocationEnabled = true
                mapView.settings.myLocationButton = true
                mapView.settings.myLocationButton = true
                mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                return mapView
            case .debug:
                let centerCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(24.996209, 121.585242), zoom: 15, bearing: GoogleMapManager.bearingAngle, viewingAngle: 0)
                let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: centerCamera)
                mapView.setMinZoom(15, maxZoom: 20)
                mapView.mapStyle = GoogleMapManager.getMapStyle()
                let polygon = GMSPolygon()
                polygon.path = GoogleMapManager.drawBlackAreaPath()
                polygon.holes = [GoogleMapManager.drawAreaPath()]
                polygon.fillColor = .black
                //        polygon.strokeColor = .blue
                polygon.strokeWidth = 2
                polygon.map = mapView
                
                mapView.isMyLocationEnabled = true
                mapView.settings.myLocationButton = true
                mapView.settings.myLocationButton = true
                mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                return mapView
            }
            
        }
        
        
        return  chooseMdel(model: .release)
    }
     func addGMSMarker(cordinate:CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = cordinate
        marker.title = "Sydney"
        marker.snippet = "Australia"
//        marker.map = self.mapView
    }
    static func getMapStyle() -> GMSMapStyle {
        do {
            
            guard let filepath = Bundle.main.url(forResource: "GoogleMapStyle", withExtension: "txt") else {
                print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                return GMSMapStyle()
            }
//            guard let url = URL(string: filepath) else {return GMSMapStyle()}
            return  try GMSMapStyle(contentsOfFileURL: filepath)
        } catch  {
            print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
            return GMSMapStyle()
        }
        
        
    }
    static func checkFirstLoading(with mapView:GMSMapView,position: GMSCameraPosition) -> Bool {
        if GoogleMapManager.isFirstLoading {
            GoogleMapManager.editeMapBoardLine(with: mapView, position: position)
        }else if position.target.latitude == GoogleMapManager.center.lat.rawValue && position.target.longitude == GoogleMapManager.center.lon.rawValue {
            GoogleMapManager.isFirstLoading  = false
        }
        return !GoogleMapManager.isFirstLoading
    }
    static func updateCamerapostion(limitSide:GoogleMapManager.coordinate, respondPosition:GMSCameraPosition,mapView:GMSMapView){
        var goBackCamera = GMSCameraPosition()
        switch limitSide {
        case .topLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(limitSide.rawValue -  GoogleMapManager.VerticalGetBackComplementary, respondPosition.target.longitude), zoom: respondPosition.zoom, bearing: GoogleMapManager.bearingAngle, viewingAngle:0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .bottomLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(limitSide.rawValue +  GoogleMapManager.VerticalGetBackComplementary, respondPosition.target.longitude), zoom: respondPosition.zoom, bearing: GoogleMapManager.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .leftLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(respondPosition.target.latitude,limitSide.rawValue +  GoogleMapManager.HorizetalGetBackComplementary), zoom: respondPosition.zoom, bearing: GoogleMapManager.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .rightLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(respondPosition.target.latitude,limitSide.rawValue -  GoogleMapManager.HorizetalGetBackComplementary), zoom: respondPosition.zoom, bearing: GoogleMapManager.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        }
       
    }
    static func editeMapBoardLine(with mapView:GMSMapView ,position: GMSCameraPosition) {
        if (position.target.latitude > GoogleMapManager.coordinate.topLimitPoint.rawValue - GoogleMapManager.VerticalBoaderComplementary) {
            GoogleMapManager.updateCamerapostion(limitSide: .topLimitPoint, respondPosition: position, mapView: mapView)
        }
        if (position.target.latitude < GoogleMapManager.coordinate.bottomLimitPoint.rawValue + GoogleMapManager.VerticalBoaderComplementary) {
            GoogleMapManager.updateCamerapostion(limitSide: .bottomLimitPoint, respondPosition: position, mapView: mapView)
            
        }
        if (position.target.longitude < GoogleMapManager.coordinate.leftLimitPoint.rawValue + GoogleMapManager.HorizetalBoaderComplementary) {
            GoogleMapManager.updateCamerapostion(limitSide: .leftLimitPoint, respondPosition: position, mapView: mapView)
            
        }
        if (position.target.longitude > GoogleMapManager.coordinate.rightLimitPoint.rawValue - GoogleMapManager.HorizetalBoaderComplementary) {
            GoogleMapManager.updateCamerapostion(limitSide: .rightLimitPoint, respondPosition: position, mapView: mapView)
        }
        
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
    
    
}
