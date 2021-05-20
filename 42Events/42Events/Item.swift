//
//  StartingSoon.swift
//  42Events
//
//  Created by Tai Nguyen on 19/05/2021.
//

import UIKit
import SwiftyJSON

struct DataItems {
    let startingSoon: [Item]
    let popular: [Item]
    let newRelease: [Item]
    let free: [Item]
    let past: [Item]
    init(json: JSON) {
        let data = json["data"]
        
        var tempStartingSoon: [Item] = []
        for i in data["startingSoon"].arrayValue {
            tempStartingSoon.append(Item(json: i))
        }
        startingSoon = tempStartingSoon
        
        var tempPopular: [Item] = []
        for i in data["popular"].arrayValue {
            tempPopular.append(Item(json: i))
        }
        popular = tempPopular
        
        var tempNew: [Item] = []
        for i in data["newRelease"].arrayValue {
            tempNew.append(Item(json: i))
        }
        newRelease = tempNew
        
        var tempFree: [Item] = []
        for i in data["free"].arrayValue {
            tempFree.append(Item(json: i))
        }
        free = tempFree
        
        var tempPast: [Item] = []
        for i in data["past"].arrayValue {
            tempPast.append(Item(json: i))
        }
        past = tempPast
    }
}

struct Item {
    let urlImage: String
    let title: String
    let subTitle: String
    let sportType: String
    let raceRunners: Int
    let racePrice: String
    let eventType: String
    let tags: [String]
    init(json: JSON) {
        urlImage = json["banner_card"].stringValue
        title = json["race_name"].stringValue
        subTitle = json["racePeriod"].stringValue
        sportType = json["sportType"].stringValue
        raceRunners = json["raceRunners"].intValue
        racePrice = json["racePrice"].stringValue
        eventType = json["eventType"].stringValue
        
        var tempTags: [String] = []
        tempTags.append(sportType)
        tempTags.append(String(raceRunners) + "Km")
        tempTags.append(racePrice)
        tempTags.append(eventType)

        tags = tempTags
    }
}

