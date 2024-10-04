//
//  LoadingProgressView.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 12/6/24.
//

import SwiftUI


struct LoadingProgressView: View {
    @State private var isLoading = true
    
    var body: some View {
        ZStack(alignment:.center ) {
            Color.clear
                .ignoresSafeArea(.all)
                .opacity(0.1)

        ZStack(alignment: .center) {
            VStack {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                    .scaleEffect(2.0, anchor: .center)
                    .foregroundStyle(.white)
                    .colorMultiply(.white)
                    .padding(.all,10)
                Spacer()
                Text("Cargando...")
                    .foregroundStyle(.white)
                    .colorMultiply(.white)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.all,10)
                Spacer()
            }
            .frame(width: 150, height: 120, alignment: .center)
            // Optional: make it bigger
        }
        .padding(.all,10)
        .background(Color.black.opacity(0.8))
        .cornerRadius(10)
        .shadow(radius: 2)
            .onAppear {
                startAnimating()
            }
        }.background(BackgroundGrayView())
    }
    
    func startAnimating() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(Animation.linear(duration: 1.5).repeatForever()) {
                isLoading = true
            }
        }
    }
    
}

struct BackgroundGrayView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIVisualEffectView(effect: .none)
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
