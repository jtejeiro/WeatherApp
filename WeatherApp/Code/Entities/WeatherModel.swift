//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 2/10/24.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    var currentCondition: [CurrentCondition]
    var nearestArea: [NearestArea]
    var request: [Request]
    var weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case currentCondition = "current_condition"
        case nearestArea = "nearest_area"
        case request, weather
    }
}

// MARK: - CurrentCondition
struct CurrentCondition: Codable {
    var feelsLikeC, feelsLikeF, cloudcover, humidity: String
    var langEs: [LangE]
    var localObsDateTime, observationTime, precipInches, precipMM: String
    var pressure, pressureInches, tempC, tempF: String
    var uvIndex, visibility, visibilityMiles, weatherCode: String
    var weatherDesc, weatherIconURL: [LangE]
    var winddir16Point, winddirDegree, windspeedKmph, windspeedMiles: String

    enum CodingKeys: String, CodingKey {
        case feelsLikeC = "FeelsLikeC"
        case feelsLikeF = "FeelsLikeF"
        case cloudcover, humidity
        case langEs = "lang_es"
        case localObsDateTime
        case observationTime = "observation_time"
        case precipInches, precipMM, pressure, pressureInches
        case tempC = "temp_C"
        case tempF = "temp_F"
        case uvIndex, visibility, visibilityMiles, weatherCode, weatherDesc
        case weatherIconURL = "weatherIconUrl"
        case winddir16Point, winddirDegree, windspeedKmph, windspeedMiles
    }
    
}

// MARK: - LangE
struct LangE: Codable {
    var value: String
}

// MARK: - NearestArea
struct NearestArea: Codable {
    var areaName, country: [LangE]
    var latitude, longitude, population: String
    var region, weatherURL: [LangE]

    enum CodingKeys: String, CodingKey {
        case areaName, country, latitude, longitude, population, region
        case weatherURL = "weatherUrl"
    }
}

// MARK: - Request
struct Request: Codable {
    var query, type: String
}

// MARK: - Weather
struct Weather: Codable {
    var astronomy: [Astronomy]
    var avgtempC, avgtempF, date: String
    var hourly: [Hourly] = []
    var maxtempC, maxtempF, mintempC, mintempF: String
    var sunHour, totalSnowCM, uvIndex: String

    enum CodingKeys: String, CodingKey {
        case astronomy, avgtempC, avgtempF, date, maxtempC, maxtempF, mintempC, mintempF, sunHour
        case hourly
        case totalSnowCM = "totalSnow_cm"
        case uvIndex
    }
}

// MARK: - Astronomy
struct Astronomy: Codable {
    var moonIllumination, moonPhase, moonrise, moonset: String
    var sunrise, sunset: String

    enum CodingKeys: String, CodingKey {
        case moonIllumination = "moon_illumination"
        case moonPhase = "moon_phase"
        case moonrise, moonset, sunrise, sunset
    }
}

// MARK: - Hourly
struct Hourly: Codable {
    var dewPointC, dewPointF, feelsLikeC, feelsLikeF: String
    var heatIndexC, heatIndexF, windChillC, windChillF: String
    var windGustKmph, windGustMiles, chanceoffog, chanceoffrost: String
    var chanceofhightemp, chanceofovercast, chanceofrain, chanceofremdry: String
    var chanceofsnow, chanceofsunshine, chanceofthunder, chanceofwindy: String
    var cloudcover, diffRAD, humidity: String
    var langEs: [LangE]
    var precipInches, precipMM, pressure, pressureInches: String
    var shortRAD, tempC, tempF, time: String
    var uvIndex, visibility, visibilityMiles, weatherCode: String
    var weatherDesc, weatherIconURL: [LangE]
    var winddir16Point, winddirDegree, windspeedKmph, windspeedMiles: String

    enum CodingKeys: String, CodingKey {
        case dewPointC = "DewPointC"
        case dewPointF = "DewPointF"
        case feelsLikeC = "FeelsLikeC"
        case feelsLikeF = "FeelsLikeF"
        case heatIndexC = "HeatIndexC"
        case heatIndexF = "HeatIndexF"
        case windChillC = "WindChillC"
        case windChillF = "WindChillF"
        case windGustKmph = "WindGustKmph"
        case windGustMiles = "WindGustMiles"
        case chanceoffog, chanceoffrost, chanceofhightemp, chanceofovercast, chanceofrain, chanceofremdry, chanceofsnow, chanceofsunshine, chanceofthunder, chanceofwindy, cloudcover
        case diffRAD = "diffRad"
        case humidity
        case langEs = "lang_es"
        case precipInches, precipMM, pressure, pressureInches
        case shortRAD = "shortRad"
        case tempC, tempF, time, uvIndex, visibility, visibilityMiles, weatherCode, weatherDesc
        case weatherIconURL = "weatherIconUrl"
        case winddir16Point, winddirDegree, windspeedKmph, windspeedMiles
    }
}
