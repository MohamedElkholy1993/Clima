//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by moutaz hegazy on 4/15/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weatherManager:WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}
