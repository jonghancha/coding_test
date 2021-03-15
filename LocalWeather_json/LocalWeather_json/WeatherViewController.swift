//
//  WeatherViewController.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/11.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, JsonModelProtocol   {
   
    
   

    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableViewWeather: UITableView!
    
    
    var locationList: Array<String>  = Array<String>()
    var woeidList: Array<Int> = Array<Int>()
    
    var todayList: Array<WeatherInfo>  = Array<WeatherInfo>()
    var tomorrowList: Array<WeatherInfo>  = Array<WeatherInfo>()
    
    var count = 0
    
//    var todayWeather: NSArray = NSArray()
//    var tomorrowWeather: NSArray = NSArray()
    
    private var refreshControl = UIRefreshControl()
        
    
    @objc func refresh(refresh: UIRefreshControl){
        
        refresh.endRefreshing()
        self.tableViewWeather.reloadData() // Reload
    }
        
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewWeather.delegate = self
        self.tableViewWeather.dataSource = self
        
        
        let jsonModel = JsonModel()
        jsonModel.delegate = self
        jsonModel.downloadItems()
        
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
        
        tableViewWeather.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
       
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
           
            tableView.rowHeight = 105
            cell.labelLocation?.text = locationList[indexPath.row] as! String
            cell.labelStateToday?.text = todayList[indexPath.row].weatherStateName as! String
            cell.labelTempToday?.text = String(todayList[indexPath.row].theTemp!) + "℃"
            cell.labelHumidityToday?.text = String(todayList[indexPath.row].humidity!) + "%"

            
            var url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(todayList[indexPath.row].weatherStateAbbr!).png")
            
            var data = try? Data(contentsOf: url!)
            cell.imageViewToday.image = UIImage(data: data!)
            
            cell.labelStateTomorrow?.text = todayList[indexPath.row].weatherStateName as! String
            cell.labelTempTomorrow?.text = String(tomorrowList[indexPath.row].theTemp!) + "℃"
            cell.labelHumidityTomorrow?.text = String(tomorrowList[indexPath.row].humidity!) + "%"
            
            
            url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(tomorrowList[indexPath.row].weatherStateAbbr!).png")
            data = try? Data(contentsOf: url!)
            cell.imageViewTomorrow.image = UIImage(data: data!)
            
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
        
        
        for item in 0...(locationList.count - 1) {
            let jsonModel = JsonModel()
            jsonModel.delegate = self
            jsonModel.downloadWeatherItems(woeid: woeidList[item])
        }
        
        
        
    }
    
    func weatherDownloaded(items: NSArray) {
        var beanList = Array<WeatherInfo>()
        beanList = items as! [WeatherInfo]
        todayList.append(beanList[0])
        tomorrowList.append(beanList[1])
        count += 1
        if count == 12 {
            print(12)
            
            self.tableViewWeather.reloadData()
        }
        
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
