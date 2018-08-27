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

    static let verticalGetBackComplementary =  0.0035
    static let horizetalGetBackComplementary = 0.0025
    static let verticalBoaderComplementary =  0.003
    static let horizetalBoaderComplementary =  0.002
    
    enum zoomlevel{
        case level17,level20
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
    var areaMarkers = [GMSMarker]()
    var buikdingMarkers = [GMSMarker]()

    /**
     plist need setting Privacy - Location When In Use Usage Description
     */
    var locationManager = CLLocationManager()
    
    
    func initLocationManager()  {
        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
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
        witchArea(drawingLocationName: .沙漠動物區, areaColor: UIColor(red: 255/255, green: 212/255, blue: 121/255, alpha: 1))
      
        
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
            break
        case .沙漠動物區:
            let p1 = CLLocationCoordinate2D(latitude: 24.995277, longitude: 121.585075)
            let p2 = CLLocationCoordinate2D(latitude: 24.995264, longitude: 121.585803)
            let p3 = CLLocationCoordinate2D(latitude: 24.994858, longitude: 121.585817)
            let p4 = CLLocationCoordinate2D(latitude: 24.994876, longitude: 121.585108)
            
          
            addPolygonToMapView(coordinates: [p1,p2,p3,p4])
        case .溫帶動物區:
            break
        case .澳洲動物區:
            break
        case .熱帶雨林區:
            break
        case .臺灣動物區:
            break
        case .非洲動物區:
            break
        case .鳥園區:
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
                marker.iconView = self.editeIconView(containerSize: CGSize(width: 100, height: 100), labelText: $0.Name, imageType: .areaType, complementary: 50)
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
                marker.iconView = self.editeIconView(containerSize: CGSize(width: 100, height: 100), labelText: $0.Name, imageType: .buildType, complementary: 50)
                marker.map = self.mapView
                self.buikdingMarkers.append(marker)
            })
            self.hasMarkerCreated.building = true
        }
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
            GoogleMapManager.shared.addGMSMarker(zoomLevel: .level17)
        case 19.0...20.0:
            break
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
        case .level17:
            showAreaAndBuildingMarkers()
        case .level20:
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
        
    }
   private func showAreaAndBuildingMarkers() {
    
    guard self.hasMarkerCreated.area && self.hasMarkerCreated.building else {
         print("\(yyxErorr.guardError)\(String.showFileName(filePath:#file)):\(#line)")
        return
    }
    _ = self.areaMarkers.map({
      $0.map = self.mapView
    })
    _ = self.buikdingMarkers.map({
        $0.map = self.mapView
    })
        
    }

    func editeIconView(containerSize:CGSize,labelText:String,imageType:locationName, complementary:CGFloat)->UIView{
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: containerSize.width, height:containerSize.height ))
        //
        let iconImageView = UIImageView()
        
        //
        let label = UILabel()
        
        func editeLabel(textSize:CGFloat) {
            label.backgroundColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
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
        editeLabel(textSize: 30)
        return containerView
    }
}
