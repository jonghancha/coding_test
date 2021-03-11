//
//  WeatherInfo.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/11.
//

import Foundation

class WeatherInfo: NSObject{
    
    // Properties
    var id: Int?
    var weatherStateName: String?
    var weatherStateAbbr: String?
    var theTemp: Int?
    var humidity: Float?
    
    
    // Empty constructor
    override init() {
        
    }
    
    init(id: Int, weatherStateName: String, weatherStateAbbr: String, theTemp: Int, humidity: Float){
        self.id = id
        self.weatherStateName = weatherStateName
        self.weatherStateAbbr = weatherStateAbbr
        self.theTemp = theTemp
        self.humidity = humidity
    }
    
    
    
    
}
