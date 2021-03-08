//
//  CityViewModel.swift
//  Weather
//
//  Created by Ravi Teja on 3/3/21.
//  Copyright © 2021 Ravi Teja. All rights reserved.
//

import Foundation

class CityViewModel {
    var baseUrl = "https://api.openweathermap.org/data/2.5/forecast?q={city}&appid=65d00499677e59496ca2f318eb68c049"
    var weatherData: WeatherData?
    
    func getDataFromAPI(cityName:String, complete:@escaping (Bool) -> Void) {
        let url = baseUrl.replacingOccurrences(of: "{city}", with: cityName, options: NSString.CompareOptions.literal, range: nil)
        guard let gitUrl = URL(string: url) else { return }
        URLSession.shared.dataTask(with: gitUrl) { (data, response
            , error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.weatherData = try decoder.decode(WeatherData.self, from: data)
                complete(true)
            } catch let err {
                complete(false)
                print("Error", err)
            }
        }.resume()
    }
    
}
