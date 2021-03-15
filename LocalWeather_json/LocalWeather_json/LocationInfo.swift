//
//  LocationInfo.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/15.
//

import Foundation

class LocationInfo: NSObject{
    
    
    
    // Properties
    var locationName: String?
    var woeid: Int?
    
    
    
    // Empty constructor
    override init() {
        
    }
    
    
    init(locationName: String, woeid: Int) {
        self.locationName = locationName
        self.woeid = woeid
    }
    
    
    
    
}
