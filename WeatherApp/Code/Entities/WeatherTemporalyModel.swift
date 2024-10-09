//
//  WeatherTemporalyModel.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 4/10/24.
//

import Foundation

struct WeatherTemporalyModel:Codable,Identifiable {
    var id:  UUID = UUID()
    var areaName: String
    var country: String
    var latLon:String
    
    
    var locationString:String {
       return "\(areaName), \(country)"
    }
}
