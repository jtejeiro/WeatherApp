//
//  ContentView.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 2/10/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MyNavigation{
            WeatherListView()
        }
        
    }
}

#Preview {
    ContentView()
}
