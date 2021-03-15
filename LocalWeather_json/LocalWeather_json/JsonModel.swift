//
//  JsonModel.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/11.
//

import Foundation

protocol JsonModelProtocol: class {
    func locationDownloaded(items: NSArray)
    func weatherDownloaded(items: NSArray)
}

class JsonModel: NSObject{
    var delegate: JsonModelProtocol! // ! 못불러올 수도 있으니까
    var urlPath = "https://www.metaweather.com/api/location/search/?query=se"
    
    func downloadItems(){
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                    self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func downloadWeatherItems(woeid: Int){
        urlPath = "https://www.metaweather.com/api/location/\(woeid)/"
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                    self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    
    
    
    
    /*
     json parsing 작업
     */
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // json model 탈피
            print(jsonResult)
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray() // 딕셔너리에서 값만 써주기 위해
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let title = jsonElement["title"] as? String,// let에 정상적으로 들어왔을 때.
               let woeid = jsonElement["woeid"] as? Int{

                let query = LocationInfo(locationName: title, woeid: woeid)
                
                locations.add(query)
            }
//            locations.add(query)
        } // for End.
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.locationDownloaded(items: locations)
        })
    }
    
    
    func parseWeatherJSON(_ data: Data){
        var jsonResult = NSArray()
        
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray // json model 탈피
            print(jsonResult)
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray() // 딕셔너리에서 값만 써주기 위해
        
      
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            
            if let id = jsonElement["id"] as? Int,// let에 정상적으로 들어왔을 때.
               let weatherStateName = jsonElement["weather_state_name"] as? String,
               let weatherStateAbbr = jsonElement["weather_state_abbr"] as? String,
               let theTemp = jsonElement["the_temp"] as? Int,
               let humidity = jsonElement["humidity"] as? Float{
                
                
                
                let query = WeatherInfo(id: id, weatherStateName: weatherStateName, weatherStateAbbr: weatherStateAbbr, theTemp: theTemp, humidity: humidity)
                
                locations.add(query)
                
            }
//            locations.add(query)
        } // for End.
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.weatherDownloaded(items: locations)
        })
    }
    
    
    
    
    
    
    
    
}// ----
