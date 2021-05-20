//
//  DetailEvent.swift
//  42Events
//
//  Created by Tai Nguyen on 20/05/2021.
//

import UIKit
import SwiftyJSON
enum TypeEvent {
    case Running
    case Cycling
    case Walking
}
struct DetailEvent {
    let total: Int
    let events: [Item]
    init(json: JSON) {
        
        total = json["totalData"].intValue
        
        let data = json["data"].arrayValue
        var tempEvents: [Item] = []
        for i in data {
            tempEvents.append(Item(json: i))
        }
        events = tempEvents
    }
}
