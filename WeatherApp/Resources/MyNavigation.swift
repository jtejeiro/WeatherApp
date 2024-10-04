//
//  MyNavigation.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 9/9/24.
//

import SwiftUI

struct MyNavigation<Content>: View where Content: View {
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        if #available(iOS 16, *) {
            NavigationStack(root: content)
        } else {
            NavigationView(content: content)
                .navigationViewStyle(.stack)
        }
    }
}
