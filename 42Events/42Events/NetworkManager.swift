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
private let host = "https://api-v2-sg-staging.42race.com/api/v1"
let provider = MoyaProvider<NetworkManager>() // Main

enum NetworkManager {
    case raceEvents
    case getDetailEvent(skipCount: String, limit: String, type: String)
}
// MARK: - TargetType Protocol Implementation
extension NetworkManager: TargetType {
    var baseURL: URL {
        switch self {
        case .getDetailEvent(let skipCount,let limit,let type):
            return URL(string: "https://api-v2-sg-staging.42race.com/api/v1/race-filters?skipCount=\(skipCount)&limit=\(limit)&sportType=\(type)")!
        default:
            return URL(string: host)!
        }
    }
    var path: String {
        switch self {
        case .raceEvents:
            return "/race-events"
        case .getDetailEvent:
            return ""
        }
    }
    var method: Moya.Method {
        switch self {
        case .raceEvents, .getDetailEvent:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .raceEvents, .getDetailEvent: // Send no parameters
            return .requestPlain
        }
    }
    var sampleData: Data {return Data()}
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}

