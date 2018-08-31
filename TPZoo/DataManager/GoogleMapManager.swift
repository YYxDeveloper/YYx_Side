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
    private var isFirstLoading = true
    private var hasMarkerCreated:checkLoading = (false,false)

    static let verticalGetBackComplementary =  0.003
    static let horizetalGetBackComplementary = 0.002
    static let verticalBoaderComplementary =  0.0025
    static let horizetalBoaderComplementary =  0.002
    
    enum zoomlevel{
        case level17ShowBuilding,level18ShowAnimals
    }
    enum center:Double {
        case lat = 24.99620900530806
        case lon = 121.58524207770824
    }
    enum coordinate:Double {
        case bottomLimitPoint   = 24.989200
        case topLimitPoint      = 25.002000//+越外
        case leftLimitPoint     = 121.578000
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
    private var areaMarkers = [GMSMarker]()
    private var buikdingMarkers = [GMSMarker]()
    private var dessertAnimalMarkers = [GMSMarker]()
    private var australiaAnimalMarkers = [GMSMarker]()
    private var taiwenAnimalMarkers = [GMSMarker]()
    /**
     plist need setting Privacy - Location When In Use Usage Description
     */
    var locationManager = CLLocationManager()
    
    
    func initLocationManager()  {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        self.locationManager = locationManager
    }
    func initMapView(model:model) -> GMSMapView{
       
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
    
    func drawAreaScope() {
         witchArea(drawingLocationName: .沙漠動物區, areaColor:editeIconColor(locationName: .沙漠動物區, isLabelColor: false))
        witchArea(drawingLocationName: .澳洲動物區, areaColor:editeIconColor(locationName: .澳洲動物區, isLabelColor: false))
        witchArea(drawingLocationName: .熱帶雨林區, areaColor:editeIconColor(locationName: .熱帶雨林區, isLabelColor: false))
        witchArea(drawingLocationName: .臺灣動物區, areaColor:editeIconColor(locationName: .臺灣動物區, isLabelColor: false))
         witchArea(drawingLocationName: .兒童動物區, areaColor:editeIconColor(locationName: .兒童動物區, isLabelColor: false))
         witchArea(drawingLocationName: .非洲動物區, areaColor:editeIconColor(locationName: .非洲動物區, isLabelColor: false))
         witchArea(drawingLocationName: .鳥園區, areaColor:editeIconColor(locationName: .鳥園區, isLabelColor: false))
           witchArea(drawingLocationName: .溫帶動物區, areaColor:editeIconColor(locationName: .溫帶動物區, isLabelColor: false))
      
        
    }
    func witchArea(drawingLocationName:locationName.area,areaColor:UIColor){
        func addPolygonToMapView(coordinates:[CLLocationCoordinate2D]){
            
            let areaPath = GMSMutablePath()
          
            _ = coordinates.map({areaPath.add($0)})
            let polygon = GMSPolygon(path: areaPath)
            polygon.fillColor = areaColor
            polygon.map = mapView
        }
        switch drawingLocationName {
        case .兒童動物區:
           
            let p1 = CLLocationCoordinate2D(latitude: 24.999147, longitude: 121.581692)
            let p2 = CLLocationCoordinate2D(latitude: 24.999778, longitude: 121.582849)
            let p3 = CLLocationCoordinate2D(latitude: 24.999332, longitude: 121.582653)
            let p4 = CLLocationCoordinate2D(latitude: 24.999191, longitude: 121.582651)
            let p5 = CLLocationCoordinate2D(latitude: 24.999074, longitude: 121.582681)
            let p6 = CLLocationCoordinate2D(latitude: 24.998737, longitude: 121.582947)
            let p7 = CLLocationCoordinate2D(latitude: 24.998380, longitude: 121.582228)
            let p8 = CLLocationCoordinate2D(latitude: 24.999191, longitude: 121.582651)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4,p5,p6,p7])
            

            
        case .沙漠動物區:
            let p1 = CLLocationCoordinate2D(latitude: 24.995277, longitude: 121.585075)
            let p2 = CLLocationCoordinate2D(latitude: 24.995264, longitude: 121.585803)
            let p3 = CLLocationCoordinate2D(latitude: 24.994858, longitude: 121.585817)
            let p4 = CLLocationCoordinate2D(latitude: 24.994876, longitude: 121.585108)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4])
        case .溫帶動物區:
            let p1 = CLLocationCoordinate2D(latitude: 24.993678, longitude: 121.589657)
            let p2 = CLLocationCoordinate2D(latitude: 24.992207, longitude: 121.588386)
            let p3 = CLLocationCoordinate2D(latitude: 24.991929, longitude: 121.588829)
            let p4 = CLLocationCoordinate2D(latitude: 24.992698, longitude: 121.589942)
            let p5 = CLLocationCoordinate2D(latitude: 24.993050, longitude: 121.590474)
            let p6 = CLLocationCoordinate2D(latitude: 24.993208, longitude: 121.590504)
            
          
            addPolygonToMapView(coordinates: [p1,p2,p3,p4,p5,p6])
        case .澳洲動物區:
            let p1 = CLLocationCoordinate2D(latitude: 24.995287, longitude: 121.585925)
            let p2 = CLLocationCoordinate2D(latitude: 24.995289, longitude: 121.586060)
            let p3 = CLLocationCoordinate2D(latitude: 24.994297, longitude: 121.586058)
            let p4 = CLLocationCoordinate2D(latitude: 24.994297, longitude: 121.585004)
            let p5 = CLLocationCoordinate2D(latitude: 24.994749, longitude: 121.585134)
            let p6 = CLLocationCoordinate2D(latitude: 24.994769, longitude: 121.585920)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4,p5,p6])
        case .熱帶雨林區:
            let p1 = CLLocationCoordinate2D(latitude: 24.995663, longitude: 121.582881)
            let p2 = CLLocationCoordinate2D(latitude: 24.995973, longitude: 121.583634)
            let p3 = CLLocationCoordinate2D(latitude: 24.995543, longitude: 121.583961)
            let p4 = CLLocationCoordinate2D(latitude: 24.994459, longitude: 121.583449)
            let p5 = CLLocationCoordinate2D(latitude: 24.993835, longitude: 121.583620)
            let p6 = CLLocationCoordinate2D(latitude: 24.993546, longitude: 121.583515)
    
            let p7 = CLLocationCoordinate2D(latitude: 24.993502, longitude: 121.583116)
            let p8 = CLLocationCoordinate2D(latitude: 24.993609, longitude: 121.582725)
            let p9 = CLLocationCoordinate2D(latitude: 24.994121, longitude: 121.582450)
            let p10 = CLLocationCoordinate2D(latitude: 24.994895, longitude: 121.582893)
            let p11 = CLLocationCoordinate2D(latitude: 24.995203, longitude: 121.583016)
            let p12 = CLLocationCoordinate2D(latitude: 24.995397, longitude: 121.583007)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12])
        case .臺灣動物區:
          
            let p1 = CLLocationCoordinate2D(latitude: 24.997894, longitude: 121.579667)
            let p2 = CLLocationCoordinate2D(latitude: 24.997048, longitude: 121.580492)
            let p3 = CLLocationCoordinate2D(latitude: 24.997300, longitude: 121.581378)
            let p4 = CLLocationCoordinate2D(latitude: 24.998359, longitude: 121.580704)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4])

        case .非洲動物區:
            let p1 = CLLocationCoordinate2D(latitude: 24.995202, longitude: 121.586246)
            let p2 = CLLocationCoordinate2D(latitude: 24.994141, longitude: 121.586214)
            let p3 = CLLocationCoordinate2D(latitude: 24.997300, longitude: 121.581378)
            let p4 = CLLocationCoordinate2D(latitude: 24.993269, longitude: 121.587567)
            let p5 = CLLocationCoordinate2D(latitude: 24.993295, longitude: 121.587804)
            let p6 = CLLocationCoordinate2D(latitude: 24.993864, longitude: 121.588020)
            let p7 = CLLocationCoordinate2D(latitude: 24.993869, longitude: 121.588470)
            let p8 = CLLocationCoordinate2D(latitude: 24.994242, longitude: 121.589088)
            let p9 = CLLocationCoordinate2D(latitude: 24.994537, longitude: 121.588957)
            let p10 = CLLocationCoordinate2D(latitude: 24.994942, longitude: 121.589113)
            let p11 = CLLocationCoordinate2D(latitude: 24.995158, longitude: 121.588674)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11])
            
        case .鳥園區:
            let p1 = CLLocationCoordinate2D(latitude: 24.995578, longitude: 121.588658)
            let p2 = CLLocationCoordinate2D(latitude: 24.995005, longitude: 121.590043)
            let p3 = CLLocationCoordinate2D(latitude: 24.995260, longitude: 121.590390)
            let p4 = CLLocationCoordinate2D(latitude: 24.994615, longitude: 121.591339)
            let p5 = CLLocationCoordinate2D(latitude: 24.994718, longitude: 121.591416)
            let p6 = CLLocationCoordinate2D(latitude: 24.995368, longitude: 121.591345)
            let p7 = CLLocationCoordinate2D(latitude: 24.995731, longitude: 121.590484)
            let p8 = CLLocationCoordinate2D(latitude: 24.996278, longitude: 121.589053)
            let p9 = CLLocationCoordinate2D(latitude: 24.995613, longitude: 121.588582)
//            let p10 = CLLocationCoordinate2D(latitude: 24.994942, longitude: 121.589113)
//            let p11 = CLLocationCoordinate2D(latitude: 24.995158, longitude: 121.588674)
            addPolygonToMapView(coordinates: [p1,p2,p3,p4,p5,p6,p7,p8,p9])
        case .all:
            break
        }
        
    }
   
    func initDataSource() {
        initMarks()
        
    }
    func initMarks() {
        func createAreaMarkers(){
            let areaDatas = AnimalDataManager.shared.areaNameXCoordinate
            _ = areaDatas.map({
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake($0.lat, $0.lon)
                marker.iconView = self.editeAreaXBuildingIconView(containerSize: CGSize(width: 100, height: 100), labelText: $0.Name, imageType: .areaType, complementary: 50, areaName: $0.Name)
                marker.map = self.mapView
                self.areaMarkers.append(marker)
            })
            self.hasMarkerCreated.area = true
        }
        func createBuildingMarkers(){
            let areaDatas = AnimalDataManager.shared.buildingNameXCoordinate
            _ = areaDatas.map({
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake($0.lat, $0.lon)
                marker.iconView = self.editeAreaXBuildingIconView(containerSize: CGSize(width: 100, height: 100), labelText: $0.Name, imageType: .buildType, complementary: 50, areaName: $0.Name)
                marker.map = self.mapView
                self.buikdingMarkers.append(marker)
            })
            self.hasMarkerCreated.building = true
        }
        func createDessertAnimalsMarkers(){
            let datas = AnimalDataManager.shared.desertAnimalMarkerDatas
            _ = datas.map({
                guard let name = $0.aNameCh else{
                    print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                    return}
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake($0.lat, $0.lon)
                marker.iconView = self.editeAnimalIconView(labelText: name, areaName: locationName.area.沙漠動物區.rawValue)
                marker.map = self.mapView
                self.dessertAnimalMarkers.append(marker)
            })
        }
        func createAustraliaAnimalMarkers(){
            let datas = AnimalDataManager.shared.australiaAnimalMarkerDatas
            _ = datas.map({
                guard let name = $0.aNameCh else{
                    print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                    return}
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake($0.lat, $0.lon)
                marker.iconView = self.editeAnimalIconView(labelText: name, areaName: locationName.area.澳洲動物區.rawValue)
                marker.map = self.mapView
                self.australiaAnimalMarkers.append(marker)
            })
        }
        func createTaiwnAnimalMarkers(){
            func allowAppendName(name:String)-> Bool{
                let stopList = ["水鹿","臺灣八哥"]
                
                return !stopList.contains(name)
            }
            let datas = AnimalDataManager.shared.taiwenAnimalMarkerDatas
            _ = datas.map({
                guard let name = $0.aNameCh else{
                    print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                    return}
                
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2DMake($0.lat, $0.lon)
                 marker.iconView = self.editeAnimalIconView(labelText: name, areaName: locationName.area.臺灣動物區.rawValue)
                marker.map = self.mapView
                if allowAppendName(name: name){
                    self.taiwenAnimalMarkers.append(marker)
                }
                
            })
        }
        createTaiwnAnimalMarkers()
        createAustraliaAnimalMarkers()
        createDessertAnimalsMarkers()
        createAreaMarkers()
        createBuildingMarkers()
    }
    
     func checkFirstLoading(position: GMSCameraPosition) -> Bool {
        if GoogleMapManager.shared.isFirstLoading {
            GoogleMapManager.shared.editeMapBoardLine(with: mapView, position: position)
        }else if position.target.latitude == GoogleMapManager.center.lat.rawValue && position.target.longitude == GoogleMapManager.center.lon.rawValue {
            GoogleMapManager.shared.isFirstLoading  = false
        }
        return GoogleMapManager.shared.isFirstLoading
    }
//MARK: Edite Marker Position
     func changeMarkertype(with zoomLevel:Float)-> GMSMapView{
        self.mapView.clear()
        switch zoomLevel {
        case 17.0...18.0:
            drawAreaScope()
            GoogleMapManager.shared.addGMSMarker(zoomLevel: .level17ShowBuilding)
        case 18.0...20.0:
            GoogleMapManager.shared.addGMSMarker(zoomLevel: .level18ShowAnimals)
            
        default:
            print("gggg")
        }
        
        return self.mapView
    }
    
//MARK: Private func
    private func editeMapBoardLine(with mapView:GMSMapView ,position: GMSCameraPosition) {
        if (position.target.latitude > GoogleMapManager.coordinate.topLimitPoint.rawValue - GoogleMapManager.verticalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .topLimitPoint, respondPosition: position, mapView: mapView)
        }
        if (position.target.latitude < GoogleMapManager.coordinate.bottomLimitPoint.rawValue + GoogleMapManager.verticalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .bottomLimitPoint, respondPosition: position, mapView: mapView)
            
        }
        if (position.target.longitude < GoogleMapManager.coordinate.leftLimitPoint.rawValue + GoogleMapManager.horizetalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .leftLimitPoint, respondPosition: position, mapView: mapView)
            
        }
        if (position.target.longitude > GoogleMapManager.coordinate.rightLimitPoint.rawValue - GoogleMapManager.horizetalBoaderComplementary) {
            GoogleMapManager.shared.updateCamerapostion(limitSide: .rightLimitPoint, respondPosition: position, mapView: mapView)
        }
        
    }
    private func updateCamerapostion(limitSide:GoogleMapManager.coordinate, respondPosition:GMSCameraPosition,mapView:GMSMapView){
        var goBackCamera = GMSCameraPosition()
        switch limitSide {
        case .topLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(limitSide.rawValue -  GoogleMapManager.verticalGetBackComplementary, respondPosition.target.longitude), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle:0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .bottomLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(limitSide.rawValue +  GoogleMapManager.verticalGetBackComplementary, respondPosition.target.longitude), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .leftLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(respondPosition.target.latitude,limitSide.rawValue +  GoogleMapManager.horizetalGetBackComplementary), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle: 0)
            mapView.camera = goBackCamera
            mapView.animate(to: goBackCamera)
        case .rightLimitPoint:
            goBackCamera  = GMSCameraPosition.init(target: CLLocationCoordinate2DMake(respondPosition.target.latitude,limitSide.rawValue -  GoogleMapManager.horizetalGetBackComplementary), zoom: respondPosition.zoom, bearing: self.bearingAngle, viewingAngle: 0)
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
    private func addGMSMarker(zoomLevel:zoomlevel){
        
        switch zoomLevel {
        case .level17ShowBuilding:
            showAreaAndBuildingMarkers()
        case .level18ShowAnimals:
            showAnimalsMarkers()
        }
//        let marker = GMSMarker()
//        marker.position = cordinate
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.iconView = self.editeIconView(containerSize: CGSize(width: 100, height: 100), labelText: "澳洲動物區", complementary: 50)
//        marker.map = self.mapView
      
        
        
       
    }
//MARK:  -
    private func showAnimalsMarkers(){
        _ = self.dessertAnimalMarkers.map({
            $0.map = self.mapView
        })
        _ = self.australiaAnimalMarkers.map({
            $0.map = self.mapView
        })
        _ = self.taiwenAnimalMarkers.map({
            $0.map = self.mapView
        })
      
    }
   private func showAreaAndBuildingMarkers() {
    func danceBaby(view:UIView){
        let upAnimation = CABasicAnimation.init(keyPath: "transform.translation.y")
        upAnimation.fromValue = 0
        upAnimation.byValue = -5
        upAnimation.toValue = 20
        upAnimation.autoreverses = true
        upAnimation.duration = Double(arc4random_uniform(4)+1)
        upAnimation.beginTime =  CACurrentMediaTime() + Double(arc4random_uniform(6))
        upAnimation.repeatCount = Float(arc4random_uniform(10))
        
        view.layer.add(upAnimation, forKey: "translation.y")
    }
    guard self.hasMarkerCreated.area && self.hasMarkerCreated.building else {
         print("\(yyxErorr.guardError)\(String.showFileName(filePath:#file)):\(#line)")
        return
    }
        _ = self.areaMarkers.map({
            $0.map = self.mapView
            guard let view = $0.iconView else{
                print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                return}
           danceBaby(view: view)
        })
        _ = self.buikdingMarkers.map({
            $0.map = self.mapView
            guard let view = $0.iconView else{
                print("\(ReturnString.yyxGuardReturn.rawValue)\(String.showFileName(filePath:#file)):\(#line)")
                return}
            danceBaby(view: view)
        })
        
    }

    func editeAreaXBuildingIconView(containerSize:CGSize,labelText:String,imageType:locationName, complementary:CGFloat,areaName:String)->UIView{
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height:containerSize.height ))
        let iconImageView = UIImageView()
        let label = UILabel()
        
        func editeLabel(textSize:CGFloat,areName:String) {
            switch areaName {
            case locationName.area.兒童動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .兒童動物區, isLabelColor: true)
            case locationName.area.沙漠動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .沙漠動物區, isLabelColor: true)
            case locationName.area.溫帶動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .溫帶動物區, isLabelColor: true)
            case locationName.area.澳洲動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .澳洲動物區, isLabelColor: true)
            case locationName.area.熱帶雨林區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .熱帶雨林區, isLabelColor: true)
            case locationName.area.臺灣動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .臺灣動物區, isLabelColor: true)
            case locationName.area.非洲動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .非洲動物區, isLabelColor: true)
            case locationName.area.鳥園區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .鳥園區, isLabelColor: true)
            case locationName.area.溫帶動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .溫帶動物區, isLabelColor: true)
            default:
                 label.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
            }
            label.textColor = .white
            label.text = labelText
            label.font.withSize(12)
            label.textAlignment = .center
            label.layer.cornerRadius = 10
            label.clipsToBounds = true
            containerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(item: label,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconImageView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0.0)
            
            let centerVertically = NSLayoutConstraint(item: label,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: iconImageView,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            let left = NSLayoutConstraint(item: label,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: containerView,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 5.0)
            let right = NSLayoutConstraint(item: label,
                                          attribute: .right,
                                          relatedBy: .equal,
                                          toItem: containerView,
                                          attribute: .right,
                                          multiplier: 1.0,
                                          constant: -5.0)
            NSLayoutConstraint(item: label,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: textSize).isActive = true
            
            NSLayoutConstraint.activate([top,left,right,centerVertically])
            
            
            
        }
        //
        func editeIconImage(complementary:CGFloat, imagetype:locationName){
            switch imageType {
            case .areaType:
                iconImageView.image = UIImage(named: "Zoom17Map")
            case .buildType:
                iconImageView.image = UIImage(named: "Zoom17Building")
            }
            containerView.addSubview(iconImageView)
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            let top = NSLayoutConstraint(item: iconImageView,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: containerView,
                                         attribute: .top,
                                         multiplier: 1.0,
                                         constant: 10.0)
            
            let centerVertically = NSLayoutConstraint(item: iconImageView,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: containerView,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            
            NSLayoutConstraint.activate([top, centerVertically])
            
            
            NSLayoutConstraint(item: iconImageView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: containerSize.width - complementary).isActive = true
            
            NSLayoutConstraint(item: iconImageView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: containerSize.height - complementary).isActive = true
        }
        
        
        editeIconImage(complementary: complementary, imagetype: imageType)
        editeLabel(textSize: 30, areName: areaName)
        return containerView
    }
    func editeAnimalIconView(labelText:String,areaName:String)->UIView{
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height:100 ))
        let iconImageView = UIImageView()
        let label = UILabel()
        
        func editeLabel(textSize:CGFloat,areName:String) {
            switch areaName {
            case locationName.area.兒童動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .兒童動物區, isLabelColor: true)
            case locationName.area.沙漠動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .沙漠動物區, isLabelColor: true)
            case locationName.area.溫帶動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .溫帶動物區, isLabelColor: true)
            case locationName.area.澳洲動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .澳洲動物區, isLabelColor: true)
            case locationName.area.熱帶雨林區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .熱帶雨林區, isLabelColor: true)
            case locationName.area.臺灣動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .臺灣動物區, isLabelColor: true)
            case locationName.area.非洲動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .非洲動物區, isLabelColor: true)
            case locationName.area.鳥園區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .鳥園區, isLabelColor: true)
            case locationName.area.溫帶動物區.rawValue:
                label.backgroundColor = editeIconColor(locationName: .溫帶動物區, isLabelColor: true)
            default:
                label.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
            label.textColor = .white
            label.text = labelText
            label.font = label.font.withSize(14)

            label.textAlignment = .center
            label.layer.cornerRadius = 10
            label.clipsToBounds = true
            containerView.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            let top = NSLayoutConstraint(item: label,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconImageView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0.0)
            
            let centerVertically = NSLayoutConstraint(item: label,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: iconImageView,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            let left = NSLayoutConstraint(item: label,
                                          attribute: .left,
                                          relatedBy: .equal,
                                          toItem: containerView,
                                          attribute: .left,
                                          multiplier: 1.0,
                                          constant: 5.0)
            let right = NSLayoutConstraint(item: label,
                                           attribute: .right,
                                           relatedBy: .equal,
                                           toItem: containerView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: -5.0)
            NSLayoutConstraint(item: label,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: textSize).isActive = true
            
            NSLayoutConstraint.activate([top,left,right,centerVertically])
            
            
            
        }
        //
        func editeIconImage(complementary:CGFloat){
          
             iconImageView.image = UIImage(named: "redDot")
            containerView.addSubview(iconImageView)
            iconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            let top = NSLayoutConstraint(item: iconImageView,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: containerView,
                                         attribute: .top,
                                         multiplier: 1.0,
                                         constant: 10.0)
            
            let centerVertically = NSLayoutConstraint(item: iconImageView,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: containerView,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0.0)
            
            NSLayoutConstraint.activate([top, centerVertically])
            
            
            NSLayoutConstraint(item: iconImageView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: 50).isActive = true
            
            NSLayoutConstraint(item: iconImageView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: nil,
                               attribute: .notAnAttribute,
                               multiplier: 1.0,
                               constant: 50).isActive = true
        }
        
        
        editeIconImage(complementary: 50)
        editeLabel(textSize: 30, areName: areaName)
        return containerView
    }
    func editeIconColor(locationName:locationName.area,isLabelColor:Bool) -> UIColor {
        switch locationName {
            case .兒童動物區:
                 return isLabelColor == true ? #colorLiteral(red: 0.2232869805, green: 0.5006997992, blue: 1, alpha: 1):#colorLiteral(red: 0.2232869805, green: 0.5006997992, blue: 1, alpha: 0.500588613)
            case .沙漠動物區:
                 return isLabelColor == true ? #colorLiteral(red: 0.2460802942, green: 0.7351186348, blue: 0.7505750317, alpha: 1):#colorLiteral(red: 0.2460802942, green: 0.7351186348, blue: 0.7505750317, alpha: 0.5241331336)
            case .溫帶動物區:
                 return isLabelColor == true ? #colorLiteral(red: 1, green: 0.159293146, blue: 0.2126889069, alpha: 1):#colorLiteral(red: 1, green: 0.159293146, blue: 0.2126889069, alpha: 0.5138859161)
            case .澳洲動物區:
                 return isLabelColor == true ? #colorLiteral(red: 1, green: 0.7263575811, blue: 0.6150251292, alpha: 0.9788099315):#colorLiteral(red: 1, green: 0.7263575811, blue: 0.6150251292, alpha: 0.5310092038)
            case .熱帶雨林區:
                 return isLabelColor == true ? #colorLiteral(red: 0.244634054, green: 0.7505750317, blue: 0.4197635666, alpha: 1):#colorLiteral(red: 0.244634054, green: 0.7505750317, blue: 0.4197635666, alpha: 0.4766427654)
            case .臺灣動物區:
                 return isLabelColor == true ? #colorLiteral(red: 0.9074783419, green: 0.5780187922, blue: 1, alpha: 1):#colorLiteral(red: 0.9074783419, green: 0.5780187922, blue: 1, alpha: 0.5030233305)
            case .非洲動物區:
                 return isLabelColor == true ? #colorLiteral(red: 0.08842880031, green: 0.4583259157, blue: 0.9073009201, alpha: 1):#colorLiteral(red: 0.08842880031, green: 0.4583259157, blue: 0.9073009201, alpha: 0.5457245291)
            case .鳥園區:
                 return isLabelColor == true ? #colorLiteral(red: 0.5808130371, green: 0.6388013355, blue: 1, alpha: 1):#colorLiteral(red: 0.5808130371, green: 0.6388013355, blue: 1, alpha: 0.4745558647)
        default:
          return  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
}
