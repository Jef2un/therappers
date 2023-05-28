//
//  WeatherData.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/26.
//

import Foundation

struct Results:Decodable{
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Weather:Decodable{
    let id: Int
    
}
struct Main:Decodable{
    let temp: Double
    let feels_like: Double
    
}


