//
//  ViewController.swift
//  WeatherForecast
//
//  Created by Priom on 2016-01-24.
//  Copyright © 2016 Priom.net. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!

    @IBAction func findWeather(_ sender: AnyObject) {

        var success = false

        let attemptUrl = URL(string: "http://www.weather-forecast.com/locations/" + cityTextField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest")

        if let url = attemptUrl {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) -> Void in
                if let urlContent = data {
                    let webContent = NSString(data: urlContent, encoding: String.Encoding.utf8.rawValue)
                    let webArr = webContent?.components(separatedBy: "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")

                    if webArr!.count > 1 {
                        let weatherArr = webArr![1].components(separatedBy: "</span>")

                        if weatherArr.count > 1 {
                            success = true
                            let weatherSummary = weatherArr[0].replacingOccurrences(of: "&deg;", with: "º")
                                DispatchQueue.main.async(execute: { () -> Void in
                                self.resultLabel.text = weatherSummary
                            })
                        }
                    }
                }
                if success == false {
                    self.resultLabel.text = "Sorry, wrong cite name!\nPlease try again."
                }
            }
            task.resume()
        }
        else {
            resultLabel.text = "Sorry, wrong cite name!\nPlease try again."
        }

        if (cityTextField.text == "") {
            resultLabel.text = "Please enter a city name!"
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

