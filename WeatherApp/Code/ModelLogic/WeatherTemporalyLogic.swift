//
//  WeatherTemporalyLogic.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 7/10/24.
//

import Foundation

@Observable
final class WeatherTemporalyLogic {
    static let sharer = WeatherTemporalyLogic()
    let interactor : WeatherTemporalyInteractor
    private(set) var weatherTempList:[WeatherTemporalyModel]
    var isTemporalyListEmpty: Bool {
        weatherTempList.count == 0
    }
    
    
    init(_ interactor: WeatherTemporalyInteractor = WeatherTemporalyProvider()) {
        self.interactor = interactor
        
        do {
            weatherTempList = try interactor.loadWeatherTemporaly()
        } catch {
            weatherTempList = []
            print("Error loading weather list: \(error)")
        }
    }
    
    
    
    func saveWeatherTemporaly(model:WeatherModel) async {
        debugPrint("saveWeatherTemporaly")
        let areaName = model.nearestArea.first?.areaName.first?.value ?? ""
        let country = model.nearestArea.first?.country.first?.value ?? ""
        let latLon = model.request.first?.query ?? ""
        
        debugPrint(areaName + ", " + country)
        if !weatherTempList.isEmpty {
            if let index = weatherTempList.firstIndex(where: { $0.areaName == areaName && $0.country == country}) {
                weatherTempList.remove(at: index)
            }
            
            if weatherTempList.count > 5 {
                weatherTempList.removeFirst()
            }
        }
        
        weatherTempList.append(WeatherTemporalyModel(areaName: areaName , country: country, latLon: latLon))
        saveWeatherTemporalyJson(model: weatherTempList)
    }
    
    func removeWeatherTemporaly() async {
        self.weatherTempList.removeAll()
        self.saveWeatherTemporalyJson(model: self.weatherTempList)
    }
    
    private func saveWeatherTemporalyJson(model: [WeatherTemporalyModel]){
        do {
            try interactor.saveWeatherTemporaly(model)
        } catch {
            print("Error save weather list: \(error)")
        }
    }
    
    
    
   
}
