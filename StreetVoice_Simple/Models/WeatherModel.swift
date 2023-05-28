//
//  WeatherModel.swift
//  StreetVoice_Simple
//
//  Created by Jef2un_628 on 2023/5/26.
//

import Foundation

struct WeatherModel{
    
    let conditionId: Int
    let temperature: Double

    var tempString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
