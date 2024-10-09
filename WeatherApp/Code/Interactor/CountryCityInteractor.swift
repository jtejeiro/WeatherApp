//
//  CountryCityInteractor.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 4/10/24.
//

import Foundation


protocol CountryCityInteractor {
    func loadCountryCity() throws -> [CountryCityModel]
  
}
struct CountryCityProvider: CountryCityInteractor {
    func loadCountryCity() throws -> [CountryCityModel]{
        
        let bundleURL: URL = Bundle.main.url(forResource: "country-by-cities", withExtension: "json")!
        let docURL: URL = URL.documentsDirectory.appending(path: "country-by-cities.json")
        
        var url = docURL
        if !FileManager.default.fileExists(atPath: url.path()) {
            url = bundleURL
        }
        
        do{
            let data = try Data(contentsOf: url)
            let model = try JSONDecoder().decode([CountryCityModel].self, from: data)
            return model
        }catch{
            print(error)
            throw error
        }
    }
    
    
}
