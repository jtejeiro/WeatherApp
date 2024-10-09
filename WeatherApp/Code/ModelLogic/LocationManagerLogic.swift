//
//  LocationManagerLogic.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 2/10/24.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func userLocationdidUpdate(userLocationString:String)
}
 

@Observable
final class LocationManagerLogic:NSObject,CLLocationManagerDelegate  {
    static let sharer = LocationManagerLogic()
    private var locationManager = CLLocationManager()
    public var delegate: LocationManagerDelegate?
    public var isActiveLocation:Bool = false
    
    private(set) var userLocation: CLLocation? = nil {
        didSet {
            delegate?.userLocationdidUpdate(userLocationString: getUserLocationString() ?? "")
        }
    }
    
    override init() {
        super.init()
        ConfigLocationManager()
    }
    
    func ConfigLocationManager() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    // Este método se llama cada vez que cambia la ubicación del usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.isActiveLocation = true
        if let location = locations.last {
            DispatchQueue.main.async {
                self.userLocation = location
            }
        }
    }
    
    // Si ocurre un error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error obteniendo la ubicación del usuario: \(error.localizedDescription)")
        self.isActiveLocation = false
        
    }
    
    
    
    func getUserLocationString() -> String? {
        guard let userLocation = userLocation else {
            return ""
        }
        // Redondear a 2 decimales
        let latitude = String(format: "%.2f", userLocation.coordinate.latitude)
        let longitude = String(format: "%.2f", userLocation.coordinate.longitude)
        return latitude + "," + longitude
    }
}
