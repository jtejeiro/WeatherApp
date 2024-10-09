//
//  SearchCityLogic.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 5/10/24.
//

import Foundation

@Observable
final class SearchCityLogic {
    static let sharer = SearchCityLogic()
    let interactor : CountryCityInteractor
    private(set) var countryCityList: [CountryCityModel] = []
    private(set) var citiesList: [SearchCityModel] = []
    
    
    init(_ interactor: CountryCityInteractor = CountryCityProvider()) {
        self.interactor = interactor
        loadCountryCityList()
       
    }
    private func loadCountryCityList() {
        do {
            // Cargamos la lista desde el interactor
            countryCityList = try interactor.loadCountryCity()
            // Procesamos las ciudades y estados en segundo plano para no bloquear la UI
            DispatchQueue.global(qos: .userInitiated).async {
                self.processCitiesList()
            }
        } catch {
            countryCityList = []
            print("Error loading country-city list: \(error)")
        }
    }
    
    private func processCitiesList() {
        var tempCitiesList: [SearchCityModel] = []
        
        for countryCity in countryCityList {
            if let cities = countryCity.cities {
                tempCitiesList.append(contentsOf: cities.map { city in
                    SearchCityModel(id: UUID(), country: countryCity.country, city: city)
                })
            }
            
            if let states = countryCity.states {
                for state in states {
                    tempCitiesList.append(contentsOf: state.value.map { city in
                        SearchCityModel(id: UUID(), country: countryCity.country, city: city)
                    })
                }
            }
        }
        
        DispatchQueue.main.async {
            self.citiesList = tempCitiesList
            print("Cities list saved: \(self.citiesList.count) cities")
        }
    }
  
}
