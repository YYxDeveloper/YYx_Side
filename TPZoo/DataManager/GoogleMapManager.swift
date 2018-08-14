//
//  GoogleMapManager.swift
//  TPZoo
//
//  Created by HSI on 2018/8/14.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
import GoogleMaps

class GoogleMapManager {
    enum ZooBoaderCoordinate {
        enum Center:Double {
            case latitude = 24.997134
            case lontitude = 121.585503
        }
        enum North:Double {
            case latitude = 25.001432
            case lontitude = 121.584282
        }
        enum East:Double {
            case latitude = 24.996373
            case lontitude = 121.593189
        }
        enum South:Double {
            case latitude = 24.988784
            case lontitude = 121.591070
        }
        enum West:Double {
            case latitude = 24.996592
            case lontitude = 121.576357
        }
    }
    static let shared = GoogleMapManager()
    static let apiKey = "AIzaSyC7OH2HcJ0Iko-bGY1U9r9y56AN1SC70mU"
    let mapView = GoogleMapManager.newZooMapView()
    
    static func newZooMapView() ->GMSMapView{
        // +rotation
        let camera = GMSCameraPosition.camera(withLatitude: ZooBoaderCoordinate.Center.latitude.rawValue, longitude: ZooBoaderCoordinate.Center.lontitude.rawValue, zoom: 18)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.setMinZoom(16, maxZoom: 18)



        let pathLine =  GMSPolyline.init(path: GoogleMapManager.drawAreaPath())
        pathLine.strokeWidth = 10.0;
        pathLine.strokeColor = .red
        pathLine.map = mapView


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
        let northCordinate = CLLocationCoordinate2DMake(ZooBoaderCoordinate.North.latitude.rawValue,ZooBoaderCoordinate.North.lontitude.rawValue)
        let eastCordinate = CLLocationCoordinate2DMake(ZooBoaderCoordinate.East.latitude.rawValue,ZooBoaderCoordinate.East.lontitude.rawValue)
        let southCordinate = CLLocationCoordinate2DMake(ZooBoaderCoordinate.South.latitude.rawValue,ZooBoaderCoordinate.South.lontitude.rawValue)
        let westCordinate = CLLocationCoordinate2DMake(ZooBoaderCoordinate.West.latitude.rawValue,ZooBoaderCoordinate.West.lontitude.rawValue)
        
        let areaPath = GMSMutablePath()
        areaPath.add(northCordinate)
        areaPath.add(eastCordinate)
        areaPath.add(southCordinate)
        areaPath.add(westCordinate)
        areaPath.add(northCordinate)
        
        return areaPath
    }
    
    
}
