//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Ravi Teja on 3/3/21.
//  Copyright © 2021 Ravi Teja. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    private struct Attributes {
        static let tempText = "Temp : "
        static let timeText = "Time : "
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   internal func setContent(typeText:String, temp: Double, time: String) {
        typeLabel.text = typeText
    tempLabel.text = Attributes.tempText + String(temp)
    timeLabel.text = Attributes.timeText + time
    }
}
