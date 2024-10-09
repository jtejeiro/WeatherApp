//
//  WeatherListViewModel.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 2/10/24.
//

import Foundation
import CoreLocation

@Observable
final class WeatherListViewModel:BaseViewModel {
    let weatherSearchLogic:WeatherSearchLogic
    let weatherTemporalyLogic:WeatherTemporalyLogic
    let locationManagerLogic:LocationManagerLogic
    var typeTemp:TempType = .centigrados
    var typeWeather:WeatherType = .Sunny
    var isLoacationUserChange:Bool = false
    
    
    init(weatherSearchLogic: WeatherSearchLogic =  WeatherSearchLogic.sharer, weatherTemporalyLogic: WeatherTemporalyLogic = WeatherTemporalyLogic.sharer) {
        self.weatherSearchLogic = weatherSearchLogic
        self.weatherTemporalyLogic = weatherTemporalyLogic
        self.locationManagerLogic = LocationManagerLogic.sharer
    }
    
    // MARK: - Config
    func configViewModel() async {
        self.locationManagerLogic.delegate = self
        self.displayProcessState(.emptyDisplay)
        if !self.weatherTemporalyLogic.isTemporalyListEmpty {
            self.isLoacationUserChange = true
            await self.fechWeatherTemporalyLast()
        }
        
    }
    
    // MARK: - Set Data
    func fechWeatherSearchData(text:String) async throws {
        self.displayLoading(true)
        do {
            let weatherModel = try await weatherSearchLogic.fechWeatherSearch(text)
            debugPrint(weatherModel)
            self.displayLoading()
            self.displayProcessState(.display)
            await self.weatherTemporalyLogic.saveWeatherTemporaly(model: weatherModel)
            self.setWeatherModelType(model: weatherModel)
        } catch {
            debugPrint(error)
            self.displayProcessState(.emptyDisplay)
            self.displayAlertMessage()
            
            throw error
        }
    }
    
    private func setWeatherModelType(model:WeatherModel) {
        if let  weatherDesc =  model.currentCondition.first?.weatherDesc.first?.value {
            self.typeWeather = self.setWeatherType(weatherDesc.lowercased())
        }
    }
    
    func getTempString(type:TempType = .centigrados) -> String{
        guard let tempCurrent = weatherSearchLogic.weatherModel.currentCondition.first else {
            return "00 Cº"
        }
        switch type {
        case .centigrados:
            return tempCurrent.tempC + " " + type.suffix
        case .fahrenheit:
            return tempCurrent.tempF + " " + type.suffix
        }
    }
    
    func getTempMinString(type:TempType = .centigrados) -> String{
        guard let tempCurrent = weatherSearchLogic.weatherModel.weather.first else {
            return "00 Cº"
        }
        switch type {
        case .centigrados:
            return tempCurrent.mintempC + " " + type.suffix
        case .fahrenheit:
            return tempCurrent.mintempF + " " + type.suffix
        }
    }
    
    func getTempMaxString(type:TempType = .centigrados) -> String{
        guard let tempCurrent = weatherSearchLogic.weatherModel.weather.first else {
            return "00 Cº"
        }
        switch type {
        case .centigrados:
            return tempCurrent.maxtempC + " " + type.suffix
        case .fahrenheit:
            return tempCurrent.maxtempF + " " + type.suffix
        }
    }
    
    func getHoursObs() -> String{
        guard let hoursObs = weatherSearchLogic.weatherModel.currentCondition.first?.localObsDateTime else {
            return "00"
        }
        
        return Utils.changeDateString(hoursObs) ?? String(hoursObs)
    }
    
    private func setWeatherType(_ text: String) -> WeatherType {
        switch text {
        case "clear":
            return .Sunny
        case "light rain", "partly cloudy" , "drizzle" :
            return .Rain
        case "snow","heavy snow", "Patchy rain nearby","mist":
            return .Snow
        default:
            return .Sunny
        }
    }
    
    func fechWeatherTemporalyLast() async {
        if let temporalyModel = weatherTemporalyLogic.weatherTempList.last{
                do {
                    let locationString = temporalyModel.locationString
                    try await fechWeatherSearchData(text: locationString)
                } catch {
                    debugPrint(error)
                }
            }
    }
  
    func fechlocationUser() async {
            if let locationString = locationManagerLogic.getUserLocationString(), locationString != "" {
                do {
                    try await fechWeatherSearchData(text: locationString)
                } catch {
                    debugPrint(error)
                }
            }
    }
    
}

extension WeatherListViewModel:LocationManagerDelegate {
    
    func userLocationdidUpdate(userLocationString: String) {
        if !self.isLoacationUserChange {
            self.displayLoading(true)
            self.isLoacationUserChange = true
            Task {
                do {
                    try await fechWeatherSearchData(text: userLocationString)
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
    
}

enum WeatherType {
    case Sunny
    case Rain
    case Snow
}
