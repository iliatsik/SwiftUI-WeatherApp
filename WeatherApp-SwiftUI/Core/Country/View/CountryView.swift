//
//  CountryView.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 25.03.22.
//

import SwiftUI
import UniformTypeIdentifiers

struct CountryView: View {
    
    @ObservedObject private var viewModel = CountryViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.countries, id: \.identifier) { country in
                    VStack {
                        HStack {
                            Text(country.name ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(40)
                                .shadow(color: .black, radius: 20)
                            Spacer()
                            Text(country.capital ?? "")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(40)
                                .shadow(color: .black, radius: 20)
                        }
                        Text("Population: \(country.population)")
                            .font(.title)
                            .fontWeight(.bold)
                            .shadow(color: .black, radius: 10)
                        Spacer()
                        
                    }.frame(width: UIScreen.screenWidth,
                            height: UIScreen.screenHeight/4,
                            alignment: .center)
                        .padding(-20)
                        .background(AsyncImage(url: URL(string: country.flagURL ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                            
                        } placeholder: {
                            
                        })
                        .opacity(0.4)
                        .cornerRadius(15)
                        .shadow(color: Color.white, radius: 6, x: 0.4, y: 0.8)
                }.listStyle(.plain)
                
            }.onAppear(perform: {
                viewModel.getAllCountries();
            }).fileExporter(
                isPresented: $viewModel.isExporting,
                document: viewModel.document,
                contentType: .plainText,
                defaultFilename: "Message"
            ) { result in
                if case .success = result {
                    print("Success")
                } else {
                    print("Failure")
                }
            }.navigationBarItems(leading:
                                    Button {
                viewModel.exportingToggle()
                viewModel.configureMessage()
            } label: {
                Text("Export")
            }
                                 ,trailing:
                                    Button {
                print("TAPPED")
            } label: {
                Image(systemName: "square.and.arrow.up")
            } )
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
