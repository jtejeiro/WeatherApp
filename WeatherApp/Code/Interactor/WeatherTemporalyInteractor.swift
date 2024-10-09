//
//  WeatherTemporalyInteractor.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 7/10/24.
//

import Foundation

protocol WeatherTemporalyInteractor {
    var bundleURL:URL { get }
    var docURL:URL { get }
    func loadWeatherTemporaly() throws -> [WeatherTemporalyModel]
    func saveWeatherTemporaly(_ weatherTemporaly:[WeatherTemporalyModel]) throws
}

extension WeatherTemporalyInteractor {
    
    func loadWeatherTemporaly() throws -> [WeatherTemporalyModel] {
        var url = docURL
        if !FileManager.default.fileExists(atPath: url.path()) {
            url = bundleURL
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([WeatherTemporalyModel].self, from: data)
    }
    
    func saveWeatherTemporaly(_ weatherTemporaly:[WeatherTemporalyModel]) throws {
        let data = try JSONEncoder().encode(weatherTemporaly)
        try data.write(to: docURL,options: .atomic)
    }
    
    
}

struct WeatherTemporalyProvider: WeatherTemporalyInteractor {
    var bundleURL: URL {
        Bundle.main.url(forResource: "WeatherTemporaly", withExtension: "json")!
    }
    
    var docURL: URL {
        URL.documentsDirectory.appending(path: "WeatherTemporaly.json")
    }
    
}
