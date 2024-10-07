//
//  CountryCityModel.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 4/10/24.
//

import Foundation

struct CountryCityModel: Codable {
    var country: String
    var cities: [String]?
}

struct SearchCityModel: Identifiable {
    var id: UUID
    var country: String
    var city: String
    
    var cityCountry:String {
       return "\(city), \(country)"
    }
}
