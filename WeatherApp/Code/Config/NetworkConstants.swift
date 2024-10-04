//
//  NetworkConstants.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 12/6/24.
//
import UIKit
import Foundation

final class NetworkConstants {
    
    // MARK: - Constant
    
    private let typeFileNetworkConstants = "plist"
    private let nameFileNetworkConstants = "Config"
    
    // MARK: - Shared Instance
    
    static let shared = NetworkConstants()
    
    
    // MARK: - Properties
    
    private var plistNetworkConstants : Dictionary<String, Any>?
    
    
    // MARK: - Init
    init() {
        if let path = Bundle.main.path(forResource: nameFileNetworkConstants, ofType: typeFileNetworkConstants) {
            plistNetworkConstants = NSDictionary(contentsOfFile: path) as? [String: AnyObject]
        }
    }
    
    var baseURL: String {
        guard let baseURL = plistNetworkConstants?["baseURL"] as? String else {
            return ""
        }
        return baseURL
    }
    
    var formatApi: String {
        guard let formatApi = plistNetworkConstants?["format"] as? String else {
            return ""
        }
        return formatApi
    }
    
    var langApi: String {
        guard let langApi = plistNetworkConstants?["lang"] as? String else {
            return ""
        }
        return langApi
    }
    
    
}
