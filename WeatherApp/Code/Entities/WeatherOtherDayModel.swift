//
//  WeatherOtherDayModel.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 4/10/24.
//

import Foundation

struct WeatherOtherDayModel:Identifiable {
    var id: UUID
    var date: String
    var maxtempC, maxtempF, mintempC, mintempF: String
    
    var dateString: String {
        Utils.changeDateShortString(date) ?? ""
    }
    
    func getmaxtemp(type:TempType = .centigrados) -> String {
        switch type {
        case .centigrados:
            return maxtempC + " " + type.suffix
        case .fahrenheit:
            return maxtempF + " " + type.suffix
        }
    }
    
    func getmintemp(type:TempType = .centigrados) -> String {
        switch type {
        case .centigrados:
            return mintempC + " " + type.suffix
        case .fahrenheit:
            return mintempF + " " + type.suffix
        }
    }
}
