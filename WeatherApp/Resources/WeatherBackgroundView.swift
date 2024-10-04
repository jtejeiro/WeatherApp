//
//  WeatherBackgroundView.swift
//  SearchHero
//
//  Created by Jaime Tejeiro on 14/6/24.
//

import SwiftUI

struct WeatherBackgroundView: View {
    @Binding var typeWeather: WeatherType
    
    var body: some View {
       
        ZStack {
            LinearGradient(gradient: weatherBackgroundtype(type: typeWeather), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.vertical)
        }

    }
    
    func weatherBackgroundtype(type:WeatherType = .Sunny) -> Gradient {
        switch type {
        case .Sunny:
            return Gradient(colors: [Color.cyan,Color.blue,Color.blue,Color.cyan])
        case .Rain:
            return Gradient(colors: [Color.gray,Color.cyan,Color.gray,Color.cyan,Color.gray])
        case .Snow:
            return Gradient(colors: [Color.white,Color.cyan,Color.cyan,Color.white])
        }
    }
}

#Preview {
    WeatherBackgroundView(typeWeather: .constant(.Sunny))
}
