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

enum ReturnString:String {
    case yyxGuardReturn,yyxNoNewtwork
}
enum yyxErorr:Error{
    case errorID(id:String)
    case guardError
}
