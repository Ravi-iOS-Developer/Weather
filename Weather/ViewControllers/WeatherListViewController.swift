//
//  WeatherListViewController.swift
//  Weather
//
//  Created by Ravi Teja on 3/3/21.
//  Copyright © 2021 Ravi Teja. All rights reserved.
//

import UIKit

class WeatherListViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var weatherListViewModel = WeatherListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }

     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = weatherListViewModel.cityName
        self.navigationController?.navigationBar.topItem?.title = " "
    }
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListViewModel.weatherList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell {
            if let weatherList = weatherListViewModel.weatherList, let particularTime = weatherList[indexPath.row].weather.first {
                cell.setContent(typeText: particularTime.main.rawValue, temp: weatherList[indexPath.row].main.temp, time: weatherList[indexPath.row].dtTxt)
                cell.backgroundColor = UIColor.clear
            }
            return cell
        }
        return UITableViewCell()
    }
    
    
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailsViewControllerController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherDetailsViewController") as? WeatherDetailsViewController {
            detailsViewControllerController.selectedWeatherData = weatherListViewModel.weatherList?[indexPath.row]
            detailsViewControllerController.cityName = weatherListViewModel.cityName
            self.navigationController?.pushViewController(detailsViewControllerController, animated: true)
        }
    }
}
