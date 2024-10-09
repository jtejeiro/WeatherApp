//
//  WeatherSearchLogic.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 2/10/24.
//

import Foundation

@Observable
final class WeatherSearchLogic {
    static let sharer = WeatherSearchLogic()
    let interactor : WeatherInteractor
    private(set) var weatherModel:WeatherModel
    private(set) var weatherOtherDayList:[WeatherOtherDayModel]
    
    
    init(_ interactor: WeatherInteractor = WeatherProvider()) {
        self.interactor = interactor
        self.weatherModel = WeatherModel(currentCondition: [], nearestArea: [], request: [], weather: [])
        self.weatherOtherDayList = []
    }
    
    func fechWeatherSearch(_ text:String) async throws -> WeatherModel {
        do {
            let model = try await interactor.loadWeatherStatus(queryparam: text, params: ["format":NetworkConstants.shared.formatApi,"lang":NetworkConstants.shared.langApi])
            self.weatherModel = model
            self.saveWeatherOtherDayModel(model: model)
            return model
        } catch {
            debugPrint(error)
            throw error
        }
    }
    
    private func saveWeatherOtherDayModel(model:WeatherModel) {
        let weatherList = model.weather
        
        if !weatherOtherDayList.isEmpty {
            weatherOtherDayList.removeAll()
        }
        
        weatherOtherDayList = weatherList.map{ model in
            WeatherOtherDayModel(id: UUID(), date: model.date, maxtempC: model.maxtempC, maxtempF: model.maxtempF, mintempC: model.mintempC, mintempF: model.mintempF)
        }
    }
}

enum TempType:CaseIterable {
    case centigrados
    case fahrenheit
    
    var suffix: String {
        switch self {
        case .centigrados:
            return "Cº"
        case .fahrenheit:
            return "Fº"
        }
    }
}


