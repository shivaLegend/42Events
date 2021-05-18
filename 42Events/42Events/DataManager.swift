//
//  DataManager.swift
//  42Events
//
//  Created by Tai Nguyen on 18/05/2021.
//

import SwiftyJSON
import Moya

class DataManager {
    static var shared = DataManager()
    func parseResponse(response: Response, statusCode: Int) -> JSON?{
        do {
//            try response.filterSuccessfulStatusCodes()
            try response.filter(statusCode: statusCode)
            let data = try response.mapJSON()
            let json = JSON(data)
            return json
        }
        catch {
            print("parseResponse error")
            return nil
        }
    }
    func isSuccessData(result: Result<Response, MoyaError>, vc: UIViewController) -> JSON?{
        switch result {
        case .success(let response):
            let temp = DataManager.shared.parseResponse(response: response, statusCode: response.statusCode)
            let json = JSON(temp as Any)
            print(json)
            print(" - - - - - - - - - -  END - - - - - - - - - -")
            switch response.statusCode {
            case 200, 201, 202, 203, 204, 205, 206:
                return json
            case 401:
                AlertBuilder.init(String(response.statusCode), json["message"].stringValue, AlertAction.init({
                }, "Done")).show(vc)
                return nil
            default:
                AlertBuilder.init(String(response.statusCode), json["message"].stringValue, AlertAction.init({}, "Done")).show(vc)
                return nil
            }
        case .failure(let error):
            print(error)
            return nil
        }
    }
}
