//
//  NetworkError.swift
//  Dietka App
//
//  Created by Parshakov Alexander on 11/19/20.
//

public enum NetworkError: String, Error {
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameters encoding failed"
    case missingURL = "URL is nil"
}
