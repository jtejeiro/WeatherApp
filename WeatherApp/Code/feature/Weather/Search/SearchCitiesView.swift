//
//  SearchCitiesView.swift
//  WeatherApp
//
//  Created by Jaime Tejeiro on 5/10/24.
//

import SwiftUI

struct SearchCitiesView: View {
    @State var searchCitiesLogic:SearchCityLogic
    @Binding var searchText: String
    @Binding var citiesText: String
    @Binding var isClose:Bool
    
    
    init(searchCitiesLogic: SearchCityLogic = SearchCityLogic.sharer,
         searchText:Binding<String>,
         citiesText:Binding<String>,
         isClose:Binding<Bool>) {
        self.searchCitiesLogic = searchCitiesLogic
        self._isClose = isClose
        self._citiesText = citiesText
        self._searchText = searchText
    }
    
    
    var body: some View {
        ZStack(alignment: .top) {
            FormPopupView(titleBox: "", isClose: $isClose){
                VStack {
                    SearchCitiesTextView(text: $searchText, citiesText: $citiesText, isClose: $isClose)
                    ScrollView {
                        if searchText.count >= 2 {
                            LazyVStack{
                                ForEach(
                                    searchCitiesLogic.citiesList.filter{$0.city.lowercased().hasPrefix(searchText.lowercased()) ||  $0.country.lowercased().hasPrefix(searchText.lowercased())  || searchText.lowercased() == ""}){ item in
                                        Button {
                                            debugPrint(item.city)
                                            self.searchText = item.cityCountry
                                            self.citiesText = item.cityCountry
                                            self.isClose.toggle()
                                        } label: {
                                            VStack(alignment: .leading ,spacing: 10) {
                                                Text(item.cityCountry)
                                                    .font(.callout)
                                                    .foregroundStyle(.black)
                                                
                                                Color.gray.frame(height: 1)
                                            }.frame(height: 40)
                                        }
                                        .padding(.horizontal,20)
                                    }
                            }
                        }
                    }
                    .frame(height: getIdealHeight())
                }
            }
        }
    }
    
    //TODO: Implementar cambio por cantidad de repuestas
    private func getListCities()-> Int {
        return searchCitiesLogic.citiesList.filter{$0.city.lowercased().hasPrefix(searchText.lowercased()) ||  $0.country.lowercased().hasPrefix(searchText.lowercased())  || searchText.lowercased() == ""}.count
    }
    
    private func getIdealHeight() -> CGFloat {
        let countList = getListCities()
       let height = ((40 * CGFloat(countList + 1)) + 20)
        debugPrint("getIdealHeight")
        debugPrint(height)
        if height < 200 {
            return height
        }
        
        return 200
    }
}

struct FormPopupView<Content: View>: View  {
    var titleBox:String = ""
    @Binding var isClose:Bool
    @ViewBuilder var content: () -> Content
    
    
    var body: some View {
        ZStack(alignment:.top ) {
            Color.black
                .ignoresSafeArea(.all)
                .opacity(0.5).onTapGesture {
                    isClose.toggle()
                }
            
            VStack(alignment: .leading, spacing: 0) {
                if titleBox != ""  {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Spacer()
                        
                        Text(titleBox)
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .padding()
                        Spacer()
                    }
                    .background(.black)
                }
                ZStack {
                    content()
                }
                .padding(.vertical,5)
            }
            .frame(minWidth: 100,maxWidth: 400, alignment: .topLeading)
            .background(Color.white)
            .cornerRadius(6)
            .padding(.horizontal,10)
        }.background(BackgroundGrayView())
    }
}

struct SearchCitiesTextView: View {
    @Binding var text: String
    @State private var isEditing = false
    @Binding var citiesText: String
    @Binding var isClose:Bool
    @FocusState private var focusedField: FocusedField?
    
    enum FocusedField {
        case textField
    }
    
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
                    .focused($focusedField,equals: .textField)
                    .keyboardType(.default)
                    .submitLabel(.done)
                    .onSubmit {
                        self.citiesText = text
                        self.isClose.toggle()
                    }
                    .onAppear {
                        focusedField = .textField
                    }
                
               
                    Button(action: {
                        self.citiesText = text
                        self.isClose.toggle()
                    }) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .foregroundStyle(.orange)
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut(duration: 1.0), value: UUID())
            }
            Spacer().frame(height: 10)
        }
        .background(Color.white.opacity(0.8))
    }
    
}

#Preview {
    SearchCitiesView(searchText: .constant(""), citiesText: .constant(""), isClose: .constant(true))
}
