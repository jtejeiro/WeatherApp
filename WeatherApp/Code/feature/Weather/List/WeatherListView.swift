//
//  WeatherListView.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 2/10/24.
//

import SwiftUI

struct WeatherListView: View {
    @State var viewModel:WeatherListViewModel
    
    init(_ viewModel: WeatherListViewModel = WeatherListViewModel()) {
        self._viewModel =  State(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            WeatherBackgroundView(typeWeather: $viewModel.typeWeather)
            
            VStack {
                WeatherSearchView()
                    .environment(viewModel)
                ScrollView {
                    VStack(spacing:20) {
                        Spacer()
                        contentBody
                        
                        if viewModel.locationManagerLogic.isActiveLocation {
                            WeatherButtonLocationView()
                                .environment(viewModel)
                        }
                        
                        WeathertemporalyListView()
                            .environment(viewModel)
                    }
                }
            }
            
            if viewModel.isLoading {
                LoadingProgressView()
            }
        }
        .alert(isPresented: $viewModel.isAlertbox) {
            Alert(
                title: Text(viewModel.alertTitle),
                message: Text(viewModel.alertMessage),
                dismissButton: .cancel(Text(viewModel.alertButton)))
        }
    }
    
    var contentBody: some View {
        VStack {
            Spacer()
            if viewModel.processState == .display {
                WeatherContainerListView()
                    .environment(viewModel)
            }else {
                EmptyView()
            }
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.horizontal,30)
        .onAppear {
            Task {
               await viewModel.configViewModel()
            }
        }
        
    }
}

struct WeatherSearchView: View {
    @Environment(WeatherListViewModel.self) var viewModel
    @State private var text: String = ""
    @State private var citiesText: String = ""
    @State var isPopup: Bool = false
    
    
    var body: some View {
        VStack {
            Spacer().frame(height: 5)
            HStack {
                
                TextField("Buscar una ciudad", text: $text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                    .onTapGesture {
                        self.isPopup.toggle()
                    }
                   
            }
            Spacer().frame(height: 10)
        }
        .background(Color.white.opacity(0.8))
        .fullScreenCover(isPresented: $isPopup) {
            SearchCitiesView(searchText: $text, citiesText: $citiesText, isClose: $isPopup)
        }.onChange(of: citiesText) { oldValue, newValue in
            if newValue != "" {
                fechedWeatherSearchData()
            }
        }
    }
    
    func fechedWeatherSearchData(){
        Task {
            do {
               try await self.viewModel.fechWeatherSearchData(text: citiesText)
                self.text = ""
                self.citiesText = ""
            } catch {
                self.text = ""
                self.citiesText = ""
            }
        }
    }
    
}


struct WeatherContainerListView: View {
    @Environment(WeatherListViewModel.self) var viewModel
    @State var isTypeCentigrados:Bool = false
    
    
    fileprivate func refreshButtton() -> some View{
        let areaName = viewModel.weatherSearchLogic.weatherModel.nearestArea.first?.areaName.first?.value ?? ""
        let country = viewModel.weatherSearchLogic.weatherModel.nearestArea.first?.country.first?.value ?? ""
        
        let areaCountry = areaName + ", " + country
        
        return Button {
            fechedWeatherSearchData(areaCountry)
        } label: {
            VStack{
                HStack {
                    Image(systemName: "arrow.2.circlepath")
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 17,height: 15)
                    Text("Recargar")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
            }
        }
    }
    
    var body: some View {
        let currentCondition = viewModel.weatherSearchLogic.weatherModel.currentCondition.first
        let nearestArea = viewModel.weatherSearchLogic.weatherModel.nearestArea.first
        
        VStack(spacing: 8) {
            HStack {
                refreshButtton()
                    .padding(.leading,10)
                Spacer()
                Button {
                    self.isTypeCentigrados.toggle()
                    
                    self.viewModel.typeTemp = isTypeCentigrados ? .fahrenheit: .centigrados
                } label: {
                    Text(!isTypeCentigrados ? "Cº":"Fº")
                        .font(.title3)
                        .bold()
                    Text(" | ")
                        .foregroundStyle(.gray)
                        .font(.title3)
                    Text(!isTypeCentigrados ? "Fº":"Cº")
                        .foregroundStyle(.gray)
                        .font(.title3)
                }.padding(.trailing,10)
            }

            HStack {
                Spacer()
                Text(nearestArea?.areaName.first?.value ?? "Ciudad")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                Spacer()
            }
            HStack {
                Spacer()
                Text(viewModel.getTempString(type: self.viewModel.typeTemp))
                    .font(.system(size: 40))
                    .bold()
                Spacer()
            }
            HStack {
                Spacer()
                Text("Máx. \(viewModel.getTempMaxString(type: self.viewModel.typeTemp))")
                    .font(.system(size: 20))
                    .bold()
                Text("Mín. \(viewModel.getTempMinString(type: self.viewModel.typeTemp))")
                    .font(.system(size: 20))
                    .bold()
                Spacer()
            }
            HStack {
                Spacer()
              
                Text(currentCondition?.langEs.first?.value ?? "Soleado")
                    .font(.title2)
                    .bold()
                Spacer()
            }
            HStack {
                Spacer()
                let country = nearestArea?.country.first?.value ?? "pais"
                let region = nearestArea?.region.first?.value ?? "region"
                Text(country + ", " + region)
                    .font(.title3)
                Spacer()
            }
            
            HStack {
                Spacer()
                let  humidity = currentCondition?.humidity ?? "0"
                Text("Humedad: \(humidity)%")
                    .font(.subheadline)
                Spacer()
            }
            HStack {
                Spacer()
                let windspeedKmph = currentCondition?.windspeedKmph ?? "0"
                Text("Velocidad del Viento: \(windspeedKmph) Km/h")
                    .font(.subheadline)
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Text("Hora de observacion:")
                    Text(viewModel.getHoursObs())
                }
                Spacer()
            }
            
            Spacer()
            WeatherOtherDayListView()
                .environment(viewModel)
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
    }
    
    func fechedWeatherSearchData(_ text:String){
        Task {
            do {
               try await self.viewModel.fechWeatherSearchData(text: text)
            }
        }
    }
    
    
    
}

struct WeatherOtherDayListView: View {
    @Environment(WeatherListViewModel.self) var viewModel
    
    var body: some View {
        let weatherOtherDayList = viewModel.weatherSearchLogic.weatherOtherDayList
        if  weatherOtherDayList.count != 0 {
            HStack(spacing: 5) {
                ForEach(weatherOtherDayList){ item in
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Text(item.dateString)
                            .font(.system(size: 14))
                            .foregroundStyle(.black)
                            .bold()
                        Color.gray.frame(height: 1).padding(.horizontal,4)
                        
                        Text("Máx. \(item.getmaxtemp(type: viewModel.typeTemp))")
                            .font(.system(size: 14))
                        Text("Mín. \(item.getmintemp(type: viewModel.typeTemp))")
                            .font(.system(size: 14))
                    }
                    
                    if weatherOtherDayList.last?.id != item.id {
                        Color.black.frame(width: 1)
                    }
                }
            }
        }
    }
    
}

struct WeatherButtonLocationView: View {
    @Environment(WeatherListViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Button {
                fechedWeatherLocationUser()
            } label: {
                HStack {
                    Spacer()
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 20,height: 20)
                    Text("Buscar Mi Ubicacion")
                    Spacer()
                }
            }
        }.padding(.all,15)
        .background {
            RoundedRectangle(cornerRadius: 20.0)
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.horizontal,30)
    }
    
    func fechedWeatherLocationUser(){
        Task {
            do {
                await self.viewModel.fechlocationUser()
            }
        }
    }
}

struct WeathertemporalyListView: View {
    @Environment(WeatherListViewModel.self) var viewModel
    
    var body: some View {
        let weatherTempList = viewModel.weatherTemporalyLogic.weatherTempList
        if  weatherTempList.count != 0 {
            VStack {
                HStack {
                    Text("Ultimas busquedas:")
                        .font(.callout)
                        .foregroundStyle(.gray)
                    Spacer()
                    Button {
                        Task {
                            do {
                               await  viewModel.weatherTemporalyLogic.removeWeatherTemporaly()
                            }
                        }
                    } label: {
                        Image(systemName: "trash.circle.fill")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(.gray)
                    }

                }
                LazyVStack(spacing: 10) {
                    ForEach(weatherTempList.reversed()) { model in
                        Button {
                            fechedWeatherSearchData(model.locationString)
                        } label: {
                            HStack(spacing: 20) {
                                Spacer()
                                Image(systemName: "scope")
                                    .resizable()
                                    .foregroundStyle(.black)
                                    .frame(width: 20,height: 20)
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(model.areaName)
                                        .font(.headline)
                                        .foregroundStyle(.black)
                                    Text(model.country)
                                        .font(.subheadline)
                                        .foregroundStyle(.black)
                                    Text(model.latLon)
                                        .font(.subheadline)
                                        .foregroundStyle(.black)
                                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                                Spacer()
                            }
                        }
                        Color.black
                            .frame(height: 1)
                            .padding(.horizontal,10)
                    }
                }
            }.padding(.all,15)
                .background {
                    RoundedRectangle(cornerRadius: 20.0)
                        .foregroundColor(.white.opacity(0.6))
                }
                .padding(.horizontal,30)
        }
    }
    
    func fechedWeatherSearchData(_ text:String){
        Task {
            do {
               try await self.viewModel.fechWeatherSearchData(text: text)
            }
        }
    }
}

#Preview {
    WeatherListView(WeatherListViewModel(weatherSearchLogic: WeatherSearchLogic(WeatherMock())))
}
