//
//  GlobalConstant.swift
//  TPZoo
//
//  Created by HSI on 2018/7/24.
//  Copyright © 2018年 HSI. All rights reserved.
//

let EMPTY_STRING = ""
let SPACE_STRING = " "
let ERORR_PREFIX = "yyxError_"
let ItIsEmptyString = "it is Empty String"
typealias checkLoading = (area:Bool,building:Bool)
typealias NameXCoordinate = (Name:String,lat:Double,lon:Double)
enum ReturnString:String {
    case yyxGuardReturn,yyxNoNewtwork
}
enum model {
    case release,debug
}
enum yyxErorr:Error{
    case errorID(id:String)
    case guardError
}
enum locationName{
    case areaType,buildType
    enum area:String{
        case 臺灣動物區,溫帶動物區,兒童動物區,熱帶雨林區,澳洲動物區,沙漠動物區,非洲動物區,鳥園區
    }
    
    enum building:String {
        case 昆蟲館,企鵝館,兩棲爬蟲館,無尾熊館,大貓熊館
    }
}
