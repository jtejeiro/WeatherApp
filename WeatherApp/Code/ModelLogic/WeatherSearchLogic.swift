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
    var weatherModel:WeatherModel
    var weatherTempList:[WeatherTemporalyModel]
    var weatherOtherDayList:[WeatherOtherDayModel]
    private var numTemp:Int = 0
    
    
    init(_ interactor: WeatherInteractor = WeatherProvider()) {
        self.interactor = interactor
        self.weatherModel = WeatherModel(currentCondition: [], nearestArea: [], request: [], weather: [])
        self.weatherTempList = []
        self.weatherOtherDayList = []
    }
    
    func fechWeatherSearch(_ text:String) async throws -> WeatherModel {
        do {
            let model = try await interactor.loadWeatherStatus(queryparam: text, params: ["format":NetworkConstants.shared.formatApi,"lang":NetworkConstants.shared.langApi])
            self.weatherModel = model
            self.saveWeatherTemporalyModel(model: model)
            self.saveWeatherOtherDayModel(model: model)
            return model
        } catch {
            debugPrint(error)
            throw error
        }
    }
    
    private func saveWeatherTemporalyModel(model:WeatherModel) {
        let areaName = model.nearestArea.first?.areaName.first?.value ?? ""
        let country = model.nearestArea.first?.country.first?.value ?? ""
        let latLon = model.request.first?.query ?? ""
        
        if !weatherTempList.isEmpty {
            if let index = weatherTempList.firstIndex(where: { $0.areaName == areaName }) {
                weatherTempList.remove(at: index)
            }
        }
        
        weatherTempList.append(WeatherTemporalyModel(id: numTemp, areaName: areaName , country: country, latLon: latLon))
        numTemp += 1
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


