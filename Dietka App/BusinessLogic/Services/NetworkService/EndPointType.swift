//
//  EndPointType.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/19/20.
//

import Foundation

protocol EndPointType {
    var baseUrl: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    
}
