//
//  Weather.swift
//  WeatherApp
//
//  Created by 양준식 on 2022/04/18.
//

import Foundation

struct WeatherInformation: Codable {
    let weather: [Weather]?
    let temp: Temp?
    let name: String?
    
    enum CodingKeys: String, CodingKey{
        case weather
        case temp = "main"
        case name
    }
    
}

struct Weather: Codable{
    
    let id: Int?
    let main, description, icon: String?
    
}

struct Temp: Codable{
    let temp, feelsLike, minTemp, maxTemp: Double?
    
    enum CodingKeys: String, CodingKey{
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}
