//
//  JsonModel.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/11.
//

import Foundation

protocol JsonModelProtocol: class {
    func itemDownloaded(items: NSArray)
}

class JsonModel: NSObject{
    var delegate: JsonModelProtocol! // ! 못불러올 수도 있으니까
    let urlPath = "https://www.metaweather.com/api/location/search/?query=se"
    
    func downloadItems(get type: String){
        let url = URL(string: urlPath)!
        let defaultSession = Foundation.URLSession(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloading")
                if type == "location"{
                    self.parseJSON(data!)
                }
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

                print(title,woeid)
                locations.add(title)
            }
//            locations.add(query)
        } // for End.
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
            print(locations)
        })
    }
    
    
    
    
    
    
    
}// ----
