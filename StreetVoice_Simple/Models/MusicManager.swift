//
//  MusicManager.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/26.
//

import Foundation



struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?q=taipei&units=metric&appid=6c25bdde7076153f554f8f552e45e3f7"
    
    
    
    func performRequest(completionHandler: @escaping (WeatherModel?) -> Void) {
        if let url = URL(string: weatherURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    completionHandler(nil)
                } else if let safeData = data {
                    let weather = self.parseJSON(weatherData: safeData)
                    completionHandler(weather)
                }
            }
            task.resume()
        }
    }
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(Results.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, temperature: temp)
            return weather
        }catch{
            print(error)
            return nil
        }
    }
}


