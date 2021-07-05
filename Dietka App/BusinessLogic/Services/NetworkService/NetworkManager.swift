//
//  DatabaseService.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/12/20.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum NetworkResult<String>{
    case success
    case failure(String)
}

protocol NetworkServiceProtocol: AnyObject {
    func findProducts(matching input: String, completion: @escaping (_ products: [ProductElement]?, _ error: String?) -> Void)
    func findDiets(forInput input: String, completion: @escaping (_ products: [Diet]?, _ error: String?) -> Void)
    func getDishes(completion: @escaping (Result<[Dish]?, Error>) -> Void)
}

final class NetworkManager {
    static let apiKey = ""
    private let router = NetworkRouter<DatabaseApi>()
    
    func getAllProducts(completion: @escaping (_ food: ProductElement?, _ error: String?) -> Void) {
        router.request(.products) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(ProductElement.self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}


extension NetworkManager: NetworkServiceProtocol {
    
    func findProducts(matching input: String, completion: @escaping (_ products: [ProductElement]?, _ error: String?) -> Void) {
        router.request(.findProducts(searchInput: input)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode([ProductElement].self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    func findDiets(forInput input: String, completion: @escaping ([Diet]?, String?) -> Void) {
        router.request(.findDiets(searchInput: input)) { (data, response, error) in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode([Diet].self, from: responseData)
                        completion(apiResponse, nil)
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
    
    func getDishes(completion: @escaping (Result<[Dish]?, Error>) -> Void) {
        
    }
    
    
}

extension Array where Element == ProductElement {
    func toProductContents() -> [ProductContentInfo] {
        return self.map { (productElement) -> ProductContentInfo in
            let productContent = ProductContentInfo(title: productElement.foodDES?.longDesc,
                                                    calories: productElement.nutrientsDict["Energy"]?.nutrientValue,
                                                    protein: productElement.nutrientsDict["Protein"]?.nutrientValue,
                                                    fat: productElement.nutrientsDict["Total lipid (fat)"]?.nutrientValue,
                                                    carbs: productElement.nutrientsDict["Carbohydrate, by difference"]?.nutrientValue)
            
//            let productContent = ProductContentInfo(title: productElement.foodDES?.shrtDesc,
//                                                    calories: productElement.nutrients,
//                                                        protein: 0.0,
//                                                        fat: 0.0,
//                                                        carbs: 0.0)
//
            return productContent
        }
    }
}
