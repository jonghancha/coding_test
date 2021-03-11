//
//  WeatherTableViewCell.swift
//  LocalWeather_json
//
//  Created by TJ on 2021/03/11.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var imageViewToday: UIImageView!
    @IBOutlet weak var labelStateToday: UILabel!
    @IBOutlet weak var labelTempToday: UILabel!
    @IBOutlet weak var labelHumidityToday: UILabel!
    
    
    @IBOutlet weak var imageViewTomorrow: UIImageView!
    @IBOutlet weak var labelStateTomorrow: UILabel!
    @IBOutlet weak var labelTempTomorrow: UILabel!
    @IBOutlet weak var labelHumidityTomorrow: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
