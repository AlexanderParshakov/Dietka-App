//
//  DishEndpoint.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/19/20.
//

import Foundation

public enum DatabaseApi: EndPointType {
    case products
    case findProducts(searchInput: String)
    case findDiets(searchInput: String)
    case productCategories
    case productNutrients(productId: Int)
    
    var baseUrl: URL {
        guard let url = URL(string: "https://dietka-app.azurewebsites.net/api/Food/")
        else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .products:
            return "getFoodDes"
        case .findProducts(let searchInput):
            return "FindFood?searchQuery=\(searchInput)&page=1".removingPercentEncoding ?? ""
        case .findDiets(_):
            return "GetWholeDiets"
        case .productCategories:
            return "getNutDataByNDB"
        case .productNutrients(let productId):
            return "getNutDataByNDB/\(productId)"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .products:
            return .request
        case .findProducts(let searchInput):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
//            ["searchQuery": searchInput,
//                            "page": 1]
        case .findDiets(_):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: nil)
        case .productCategories:
            return .request
        case .productNutrients(let productId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["NDB_No": productId])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
