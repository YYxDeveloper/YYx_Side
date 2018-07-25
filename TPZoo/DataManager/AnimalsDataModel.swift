//
//  AnimalsDataModel.swift
//  TPZoo
//
//  Created by HSI on 2018/7/24.
//  Copyright © 2018年 HSI. All rights reserved.
//

import Foundation
// MARK: Json Model -
struct AnimalsDataModel:Decodable {
    let result:Result
    
    
    struct Result:Decodable {
        let count:Int?
        let limit:Int?
        
        let results:[animals]
    }
    struct animals:Decodable {
        let aAdopt : String?
        let aAlsoKnown : String?
        let aBehavior : String?
        let aCID : String?
        let aClass : String?
        let aCode : String?
        let aConservation : String?
        let aCrisis : String?
        let aDiet : String?
        let aDistribution : String?
        let aFamily : String?
        let aFeature : String?
        let aGeo : String?
        let aHabitat : String?
        let aInterpretation : String?
        let aKeywords : String?
        let aLocation : String?
        let aNameCh : String?
        let aNameEn : String?
        let aNameLatin : String?
        let aOrder : String?
        let aPOIGroup : String?
        let aPhylum : String?
        let aPic01ALT : String?
        let aPic01URL : String?
        let aPic02ALT : String?
        let aPic02URL : String?
        let aPic03ALT : String?
        let aPic03URL : String?
        let aPic04ALT : String?
        let aPic04URL : String?
        let aSummary : String?
        let aThemeName : String?
        let aThemeURL : String?
        let aUpdate : String?
        let aVedioURL : String?
        let aVoice01ALT : String?
        let aVoice01URL : String?
        let aVoice02ALT : String?
        let aVoice02URL : String?
        let aVoice03ALT : String?
        let aVoice03URL : String?
        let aPdf01ALT : String?
        let aPdf01URL : String?
        let aPdf02ALT : String?
        let aPdf02URL : String?
        let id : String?
        let count : Int?
        let limit : Int?
        let offset : Int?
        let results : [Result]?
        let sort : String?
        
        
        enum CodingKeys: String, CodingKey {
            case aAdopt = "A_Adopt"
            case aAlsoKnown = "A_AlsoKnown"
            case aBehavior = "A_Behavior"
            case aCID = "A_CID"
            case aClass = "A_Class"
            case aCode = "A_Code"
            case aConservation = "A_Conservation"
            case aCrisis = "A_Crisis"
            case aDiet = "A_Diet"
            case aDistribution = "A_Distribution"
            case aFamily = "A_Family"
            case aFeature = "A_Feature"
            case aGeo = "A_Geo"
            case aHabitat = "A_Habitat"
            case aInterpretation = "A_Interpretation"
            case aKeywords = "A_Keywords"
            case aLocation = "A_Location"
            case aNameCh = "A_Name_Ch"
            case aNameEn = "A_Name_En"
            case aNameLatin = "A_Name_Latin"
            case aOrder = "A_Order"
            case aPOIGroup = "A_POIGroup"
            case aPhylum = "A_Phylum"
            case aPic01ALT = "A_Pic01_ALT"
            case aPic01URL = "A_Pic01_URL"
            case aPic02ALT = "A_Pic02_ALT"
            case aPic02URL = "A_Pic02_URL"
            case aPic03ALT = "A_Pic03_ALT"
            case aPic03URL = "A_Pic03_URL"
            case aPic04ALT = "A_Pic04_ALT"
            case aPic04URL = "A_Pic04_URL"
            case aSummary = "A_Summary"
            case aThemeName = "A_Theme_Name"
            case aThemeURL = "A_Theme_URL"
            case aUpdate = "A_Update"
            case aVedioURL = "A_Vedio_URL"
            case aVoice01ALT = "A_Voice01_ALT"
            case aVoice01URL = "A_Voice01_URL"
            case aVoice02ALT = "A_Voice02_ALT"
            case aVoice02URL = "A_Voice02_URL"
            case aVoice03ALT = "A_Voice03_ALT"
            case aVoice03URL = "A_Voice03_URL"
            case aPdf01ALT = "A_pdf01_ALT"
            case aPdf01URL = "A_pdf01_URL"
            case aPdf02ALT = "A_pdf02_ALT"
            case aPdf02URL = "A_pdf02_URL"
            case id = "_id"
            case count = "count"
            case limit = "limit"
            case offset = "offset"
            case results = "results"
            case sort = "sort"
        }
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            aAdopt = try values.decodeIfPresent(String.self, forKey: .aAdopt)
            aAlsoKnown = try values.decodeIfPresent(String.self, forKey: .aAlsoKnown)
            aBehavior = try values.decodeIfPresent(String.self, forKey: .aBehavior)
            aCID = try values.decodeIfPresent(String.self, forKey: .aCID) ?? ""
            aClass = try values.decodeIfPresent(String.self, forKey: .aClass)
            aCode = try values.decodeIfPresent(String.self, forKey: .aCode)
            aConservation = try values.decodeIfPresent(String.self, forKey: .aConservation)
            aCrisis = try values.decodeIfPresent(String.self, forKey: .aCrisis)
            aDiet = try values.decodeIfPresent(String.self, forKey: .aDiet)
            aDistribution = try values.decodeIfPresent(String.self, forKey: .aDistribution)
            aFamily = try values.decodeIfPresent(String.self, forKey: .aFamily)
            aFeature = try values.decodeIfPresent(String.self, forKey: .aFeature)
            aGeo = try values.decodeIfPresent(String.self, forKey: .aGeo)
            aHabitat = try values.decodeIfPresent(String.self, forKey: .aHabitat)
            aInterpretation = try values.decodeIfPresent(String.self, forKey: .aInterpretation)
            aKeywords = try values.decodeIfPresent(String.self, forKey: .aKeywords)
            aLocation = try values.decodeIfPresent(String.self, forKey: .aLocation)
            aNameCh = try values.decodeIfPresent(String.self, forKey: .aNameCh)
            aNameEn = try values.decodeIfPresent(String.self, forKey: .aNameEn)
            aNameLatin = try values.decodeIfPresent(String.self, forKey: .aNameLatin)
            aOrder = try values.decodeIfPresent(String.self, forKey: .aOrder)
            aPOIGroup = try values.decodeIfPresent(String.self, forKey: .aPOIGroup)
            aPhylum = try values.decodeIfPresent(String.self, forKey: .aPhylum)
            aPic01ALT = try values.decodeIfPresent(String.self, forKey: .aPic01ALT)
            aPic01URL = try values.decodeIfPresent(String.self, forKey: .aPic01URL)
            aPic02ALT = try values.decodeIfPresent(String.self, forKey: .aPic02ALT)
            aPic02URL = try values.decodeIfPresent(String.self, forKey: .aPic02URL)
            aPic03ALT = try values.decodeIfPresent(String.self, forKey: .aPic03ALT)
            aPic03URL = try values.decodeIfPresent(String.self, forKey: .aPic03URL)
            aPic04ALT = try values.decodeIfPresent(String.self, forKey: .aPic04ALT)
            aPic04URL = try values.decodeIfPresent(String.self, forKey: .aPic04URL)
            aSummary = try values.decodeIfPresent(String.self, forKey: .aSummary)
            aThemeName = try values.decodeIfPresent(String.self, forKey: .aThemeName)
            aThemeURL = try values.decodeIfPresent(String.self, forKey: .aThemeURL)
            aUpdate = try values.decodeIfPresent(String.self, forKey: .aUpdate)
            aVedioURL = try values.decodeIfPresent(String.self, forKey: .aVedioURL)
            aVoice01ALT = try values.decodeIfPresent(String.self, forKey: .aVoice01ALT)
            aVoice01URL = try values.decodeIfPresent(String.self, forKey: .aVoice01URL)
            aVoice02ALT = try values.decodeIfPresent(String.self, forKey: .aVoice02ALT)
            aVoice02URL = try values.decodeIfPresent(String.self, forKey: .aVoice02URL)
            aVoice03ALT = try values.decodeIfPresent(String.self, forKey: .aVoice03ALT)
            aVoice03URL = try values.decodeIfPresent(String.self, forKey: .aVoice03URL)
            aPdf01ALT = try values.decodeIfPresent(String.self, forKey: .aPdf01ALT)
            aPdf01URL = try values.decodeIfPresent(String.self, forKey: .aPdf01URL)
            aPdf02ALT = try values.decodeIfPresent(String.self, forKey: .aPdf02ALT)
            aPdf02URL = try values.decodeIfPresent(String.self, forKey: .aPdf02URL)
            id = try values.decodeIfPresent(String.self, forKey: .id)
            count = try values.decodeIfPresent(Int.self, forKey: .count)
            limit = try values.decodeIfPresent(Int.self, forKey: .limit)
            offset = try values.decodeIfPresent(Int.self, forKey: .offset)
            results = try values.decodeIfPresent([Result].self, forKey: .results)
            sort = try values.decodeIfPresent(String.self, forKey: .sort)
        }
        
        
    }
    
}
