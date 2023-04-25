//
//  Constants.swift
//  TCG mobile
//
//  Created by Amar Kumar Singh on 25/04/23.
//

import Foundation

//declare as much required
let DEV_ROOT_POINT = "http://13.235.66.138:9090/api/v1/session"
let PROD_ROOT_POINT = "http://13.235.66.138:9090/api/v1/session"


enum NetworkEnvironment: String {
    case development
    case production
}

var selectedEnvironment: NetworkEnvironment {
    return .development
}

var BaseURL: String {
    switch selectedEnvironment {
    case .development:
        return DEV_ROOT_POINT
    case .production:
        return PROD_ROOT_POINT
    }
}

enum APIEndPoints {
    case login
    case refreshToken
    
    //endpoints
    var endpoint: String {
        switch self {
        case .login:
            return BaseURL + "/login"
        case .refreshToken:
            return BaseURL + "/token"
        }
    }
}

