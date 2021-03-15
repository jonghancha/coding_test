//
//  WeatherViewController.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/11.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JsonModelProtocol   {
   
    
   

    @IBOutlet weak var tableViewWeather: UITableView!
    
    
    var locationList: Array<String>  = Array<String>()
    var woeidList: Array<Int> = Array<Int>()
    
    var todayList: Array<String>  = Array<String>()
    var tomorrowList: Array<String>  = Array<String>()
    
    
    
//    var todayWeather: NSArray = NSArray()
//    var tomorrowWeather: NSArray = NSArray()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewWeather.delegate = self
        self.tableViewWeather.dataSource = self
        
        
        let jsonModel = JsonModel()
        jsonModel.delegate = self
        jsonModel.downloadItems()
        jsonModel.downloadWeatherItems()
        // Do any additional setup after loading the view.
        // 그림 크기
//        tableViewWeather.rowHeight = 105// Cell 높이. <----------- 중요
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
   
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return locationList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! HeaderTableViewCell
            tableView.rowHeight = 43.6
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
            // Configure the cell...
            // 셀 구성 정해주기
//            let item: WeatherInfo = todayWeather[indexPath.row] as! WeatherInfo
           
            tableView.rowHeight = 105
            cell.labelLocation?.text = locationList[indexPath.row] as! String
           
           
    //        loadImage(imageView: cell.ivStoreImage, urlPath: item.storeImage!)
            
    //        let url = URL(string: item.storeImage!)
    //        let data = try? Data(contentsOf: url!)
    //        cell.ivStoreImage.image = UIImage(data: data!)
            
            return cell
        }
        
    }
    
    func locationDownloaded(items: NSArray) {
        var beanList = Array<LocationInfo>()
        beanList = items as! [LocationInfo]
        for item in 0...(items.count-1) {
            locationList.append(beanList[item].locationName!)
            woeidList.append(beanList[item].woeid!)
        }
        
    }
    
    func weatherDownloaded(items: NSArray) {
        
        
        
        self.tableViewWeather.reloadData()
        print(locationList)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
