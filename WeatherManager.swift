//
//  WeatherManager.swift
//  Clima
//
//  Created by moutaz hegazy on 4/13/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=e91d3baa160be4d157199cfcac699153&units=metric"
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let stringURL = "\(weatherURL)&q=\(cityName)"
        performRequest(with: stringURL)
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let stringURL = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: stringURL)
    }
    
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error!)
                    return
                }
                
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(weatherManager: self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let cityName = decodedData.name
            let temp = decodedData.main.temp
            
            let weatherModel = WeatherModel(conditionID: id, cityName: cityName, temperature: temp)
            return weatherModel
        }catch{
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
    

    
}
