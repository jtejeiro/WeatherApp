//
//  WeatherBackgroundView.swift
//  SearchHero
//
//  Created by Jaime Tejeiro on 14/6/24.
//

import SwiftUI

struct WeatherBackgroundView: View {
    var gradient = Gradient(colors: [Color.cyan,Color.blue,Color.purple,Color.blue,Color.black])
    
    var body: some View {
       
        ZStack {
            LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.vertical)
                .overlay {
                   
                }
        }

        
    }
}

#Preview {
    WeathetBackgroundView()
}
