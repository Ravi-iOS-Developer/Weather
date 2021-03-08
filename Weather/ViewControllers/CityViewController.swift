//
//  CityViewController.swift
//  Weather
//
//  Created by Ravi Teja on 3/3/21.
//  Copyright © 2021 Ravi Teja. All rights reserved.
//

import UIKit

class CityViewController: BaseViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var lookUpButton: UIButton!
    private  let cityViewModel = CityViewModel()
    private var activityView = UIActivityIndicatorView(style: .large)

    private struct Attributes {
        static let borderWidth:CGFloat = 1.0
        static let cornerRadius:CGFloat = 10.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpUI()
        self.title = "Home"
        addTapGesture()
    }
    
    
   private func showActivityIndicatory() {
        let container: UIView = UIView()
        container.frame = CGRect(x: 0, y: 0, width: 80, height: 80) // Set X and Y whatever you want
        container.backgroundColor = .clear

        activityView.center = self.view.center

        container.addSubview(activityView)
        self.view.addSubview(container)
        activityView.startAnimating()
    }
    
   private func hideActivityIndicator()  {
        DispatchQueue.main.async {
            self.activityView.stopAnimating()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    private func setUpUI() {
        lookUpButton.layer.borderColor = UIColor.lightGray.cgColor
        lookUpButton.layer.borderWidth = Attributes.borderWidth
        lookUpButton.layer.cornerRadius = Attributes.cornerRadius
    }
    
    private func addTapGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
      }

    /// It dismiss the keypad.
      @objc func dismissKeyboard() {
        self.view.endEditing(true)
      }
    
    @IBAction func lookUpButtonTapped(_ sender: Any) {
        showActivityIndicatory()
        if let city = cityNameTextField.text {
            cityViewModel.getDataFromAPI(cityName: city, complete: {
                isSuccess in
                self.hideActivityIndicator()
                if isSuccess {
                    DispatchQueue.main.async {
                        if let weatherListViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController {
                            weatherListViewController.weatherListViewModel.weatherData = self.cityViewModel.weatherData
                            self.navigationController?.pushViewController(weatherListViewController, animated: true)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: "Please try some other city.", preferredStyle: UIAlertController.Style.alert)

                           // add an action (button)
                           alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                           // show the alert
                           self.present(alert, animated: true, completion: nil)
                    }
                }
            })
            
        }
    }
}

extension CityViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
}


class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
