//
//  WeatherListViewModel.swift
//  Weather
//
//  Created by Ravi Teja on 3/4/21.
//  Copyright © 2021 Ravi Teja. All rights reserved.
//

import Foundation

class WeatherListViewModel {
    var weatherData: WeatherData? {
        didSet {
            weatherList = weatherData?.list
            cityName = weatherData?.city.name
        }
    }
    var weatherList: [List]?
    var cityName: String?
}
