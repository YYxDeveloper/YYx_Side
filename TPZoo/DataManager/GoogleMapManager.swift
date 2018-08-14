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
    static let shared = GoogleMapManager()
    static let apiKey = "AIzaSyC7OH2HcJ0Iko-bGY1U9r9y56AN1SC70mU"
    
    static func newZooMapView() ->GMSMapView{
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }
    static func addGMSMarker(with mapView:GMSMapView,cordinate:CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = cordinate
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    
    
}
