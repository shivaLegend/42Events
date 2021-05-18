//
//  NetworkManager.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import Foundation
import Moya
import Alamofire
import SwiftyJSON

let provider = MoyaProvider<NetworkManager>() // Main

enum NetworkManager {
    case raceEvents
    
}
// MARK: - TargetType Protocol Implementation
extension NetworkManager: TargetType {
    var baseURL: URL { return URL(string: "https://api-v2-sg-staging.42race.com/api/v1")! }
    var path: String {
        switch self {
        case .raceEvents:
            return "/race-events"
        }
    }
    var method: Moya.Method {
        switch self {
        case .raceEvents:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .raceEvents: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {return Data()}
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

