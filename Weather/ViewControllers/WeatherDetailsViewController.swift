//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Ravi Teja on 3/3/21.
//  Copyright © 2021 Ravi Teja. All rights reserved.
//

import UIKit

class WeatherDetailsViewController: BaseViewController {
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    var selectedWeatherData: List?
    var cityName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = cityName
        self.navigationController?.navigationBar.topItem?.title = " "
        tempLabel.text = selectedWeatherData?.main.temp.description
        feelsLikeLabel.text = "Feels Like: " + (selectedWeatherData?.main.feelsLike.description ?? "")
        weatherTypeLabel.text = selectedWeatherData?.weather.first?.main.rawValue
        weatherDescriptionLabel.text = selectedWeatherData?.weather.first?.weatherDescription
    }
}
