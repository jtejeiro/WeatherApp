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
    
    var test: CurrentCondition {
        return CurrentCondition(
            feelsLikeC: "16",
            feelsLikeF: "60",
            cloudcover: "0",
            humidity: "53",
            langEs: [LangE(value: "Soleado")],
            localObsDateTime: "2024-10-02 10:20 AM",
            observationTime: "02:20 PM",
            precipInches: "0.0",
            precipMM: "0.0",
            pressure: "1019",
            pressureInches: "30",
            tempC: "16",
            tempF: "60",
            uvIndex: "4",
            visibility: "16",
            visibilityMiles: "9",
            weatherCode: "113",
            weatherDesc: [LangE(value: "Sunny")],
            weatherIconURL: [LangE(value: "")],
            winddir16Point: "N",
            winddirDegree: "354",
            windspeedKmph: "7",
            windspeedMiles: "4"
        )
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
    
    var test: NearestArea {
        return NearestArea(
            areaName: [LangE(value: "Detroit")],
            country: [LangE(value: "United States of America")],
            latitude: "42.331",
            longitude: "-83.046",
            population: "884941",
            region: [LangE(value: "Michigan")],
            weatherURL: [LangE(value: "")]
        )
    }
}

// MARK: - Request
struct Request: Codable {
    var query, type: String
    
    var test: Request {
        return Request(
            query: "Lat 42.35 and Lon -83.06",
            type: "LatLon")
    }
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
    
    static var test: Hourly {
        return Hourly(
            dewPointC: "7",
            dewPointF: "44",
            feelsLikeC: "17",
            feelsLikeF: "63",
            heatIndexC: "17",
            heatIndexF: "63",
            windChillC: "17",
            windChillF: "63",
            windGustKmph: "14",
            windGustMiles: "9",
            chanceoffog: "0",
            chanceoffrost: "0",
            chanceofhightemp: "0",
            chanceofovercast: "0",
            chanceofrain: "0",
            chanceofremdry: "91",
            chanceofsnow: "0",
            chanceofsunshine: "86",
            chanceofthunder: "0",
            chanceofwindy: "0",
            cloudcover: "17",
            diffRAD: "0.0",
            humidity: "50",
            langEs: [LangE(value: "Despejado")],
            precipInches: "0.0",
            precipMM: "0.0",
            pressure: "1014",
            pressureInches: "30",
            shortRAD: "0.0",
            tempC: "17",
            tempF: "63",
            time: "0",
            uvIndex: "1",
            visibility: "10",
            visibilityMiles: "6",
            weatherCode: "113",
            weatherDesc: [LangE(value: "Clear")],
            weatherIconURL: [LangE(value: "")],
            winddir16Point: "ENE",
            winddirDegree: "75",
            windspeedKmph: "9",
            windspeedMiles: "6"
        )
    }

}
