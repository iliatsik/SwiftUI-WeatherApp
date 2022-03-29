//
//  WeatherView.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 24.03.22.
//

import SwiftUI

struct WorldClockView: View {
    @ObservedObject private var viewModel = WorldClockViewModel()
    @State private var selection = 0

    var body: some View {
        
        TabView(selection: $selection) {
            NavigationView{
                listOfCountries()
                    .navigationTitle("World Clock")
                
            }
            .tabItem {
                Image(systemName: "flag.square")
                Text("List")
            }
            .tag(0)
            
            CountryView()
            .tabItem {
                    Image(systemName: "star.square")
                    Text("Favourites")
                }
                .tag(1)
        }
    }
    
    fileprivate func listOfCountries() -> some View {
        return List(viewModel.countryList, id: \.id) { country in
            HStack {
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text(country.timeZone)
                        .font(.subheadline)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Text(country.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .searchable(text: $viewModel.searchText)
                    Spacer()
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Spacer()

                    Button {
                        viewModel.countryTapped(with: country)
                    } label: {
                        Image(systemName: country.isFavourite ? "star.fill" : "star")
                    }
                    .padding(.trailing)

                    Spacer()
                    
                    Text(country.exactTime)
                        .fontWeight(.bold)
                        .font(.title2)
                        .padding(.trailing)
                    
                    Spacer()
                }
                
            }
            
        }
        .listStyle(.plain)
        .onAppear(perform: self.viewModel.fetchCountries)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WorldClockView()
        }
    }
}

