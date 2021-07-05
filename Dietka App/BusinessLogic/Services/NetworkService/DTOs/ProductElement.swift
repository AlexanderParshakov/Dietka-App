//
//  FoodDescription.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/20/20.
//

import Foundation

// MARK: - ProductElement
struct ProductElement: Codable {
    let foodDES: FoodDES?
    let nutrients: [Nutrient]?
    var nutrientsDict: [String: Nutrient] {
        return nutrients?.toDictionary { $0.nutrientName } as! [String : Nutrient]
    }

    enum CodingKeys: String, CodingKey {
        case foodDES = "foodDes"
        case nutrients
    }
}

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

// MARK: - FoodDES
struct FoodDES: Codable {
    let ndbNo, fdGrpCD, longDesc, shrtDesc: String?
    let comName, manufacName, survey, refDesc: String?
    let refuse: Int?
    let sciName: String?
    let nFactor, proFactor, fatFactor, choFactor: Int?
    let fdGrpCDNavigation: FdGrpCDNavigation?
    let datsrcln: [Datsrcln]?
    let langual: [Langual]?
    let nutData: [NutDatum]?
    let weight: [Weight]?

    enum CodingKeys: String, CodingKey {
        case ndbNo
        case fdGrpCD = "fdGrpCd"
        case longDesc, shrtDesc, comName, manufacName, survey, refDesc, refuse, sciName, nFactor, proFactor, fatFactor, choFactor
        case fdGrpCDNavigation = "fdGrpCdNavigation"
        case datsrcln, langual, nutData, weight
    }
}

// MARK: - Datsrcln
struct Datsrcln: Codable {
    let ndbNo, nutrNo, dataSrcID: String?
    let dataSrc: DataSrc?
    let nutrNoNavigation: NutrNoNavigation?

    enum CodingKeys: String, CodingKey {
        case ndbNo, nutrNo
        case dataSrcID = "dataSrcId"
        case dataSrc, nutrNoNavigation
    }
}

// MARK: - DataSrc
struct DataSrc: Codable {
    let dataSrcID, authors, title, year: String?
    let journal, volCity, issueState, startPage: String?
    let endPage: String?
    let datsrcln: [JSONNull?]?

    enum CodingKeys: String, CodingKey {
        case dataSrcID = "dataSrcId"
        case authors, title, year, journal, volCity, issueState, startPage, endPage, datsrcln
    }
}

// MARK: - NutrNoNavigation
struct NutrNoNavigation: Codable {
    let nutrNo, units, tagname, nutrDesc: String?
    let numDEC, srOrder: Int?
    let datsrcln, nutData: [JSONNull?]?

    enum CodingKeys: String, CodingKey {
        case nutrNo, units, tagname, nutrDesc
        case numDEC = "numDec"
        case srOrder, datsrcln, nutData
    }
}

// MARK: - FdGrpCDNavigation
struct FdGrpCDNavigation: Codable {
    let fdGrpCD, fdGrpDesc: String?
    let foodDES: [JSONNull?]?

    enum CodingKeys: String, CodingKey {
        case fdGrpCD = "fdGrpCd"
        case fdGrpDesc
        case foodDES = "foodDes"
    }
}

// MARK: - Langual
struct Langual: Codable {
    let ndbNo, factorCode: String?
    let factorCodeNavigation: FactorCodeNavigation?
}

// MARK: - FactorCodeNavigation
struct FactorCodeNavigation: Codable {
    let factorCode, factorCodeNavigationDescription: String?
    let langual: [JSONNull?]?

    enum CodingKeys: String, CodingKey {
        case factorCode
        case factorCodeNavigationDescription = "description"
        case langual
    }
}

// MARK: - NutDatum
struct NutDatum: Codable {
    let ndbNo, nutrNo: String?
    let nutrVal, numDataPts, stdError: Int?
    let srcCD, derivCD, refNdbNo, addNutrMark: String?
    let numStudies, min, max, df: Int?
    let lowEb, upEb: Int?
    let statCmt, addModDate, cc: String?
    let nutrNoNavigation: NutrNoNavigation?

    enum CodingKeys: String, CodingKey {
        case ndbNo, nutrNo, nutrVal, numDataPts, stdError
        case srcCD = "srcCd"
        case derivCD = "derivCd"
        case refNdbNo, addNutrMark, numStudies, min, max, df, lowEb, upEb, statCmt, addModDate, cc, nutrNoNavigation
    }
}

// MARK: - Weight
struct Weight: Codable {
    let ndbNo, seq: String?
    let amount: Int?
    let msreDesc: String?
    let gmWgt, numDataPts, stdDev: Int?
}

// MARK: - Nutrient
struct Nutrient: Codable {
    let nutrientName: String?
    let nutrientValue: Float?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
