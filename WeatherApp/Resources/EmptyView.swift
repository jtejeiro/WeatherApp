//
//  EmptyView.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 14/6/24.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Image(systemName: "umbrella")
                        .resizable()
                        .frame(width:100,height: 120)
                        .foregroundStyle(.gray)
                    Spacer()
                }
                HStack {
                    Text("El clima de hoy es...")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.gray)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    EmptyView()
}
