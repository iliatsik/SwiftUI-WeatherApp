//
//  CountryView.swift
//  WeatherApp-SwiftUI
//
//  Created by Ilia Tsikelashvili on 25.03.22.
//

import SwiftUI
import UniformTypeIdentifiers
import Kingfisher

struct CountryView: View {
    
    @ObservedObject private var viewModel = CountryViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.getAllCountries(), id: \.identifier) { country in
                    VStack {
                        HStack {
                            Text(country.name ?? "")
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(40)
                                .opacity(0.8)
                                .shadow(color: .black, radius: 20)
                            Spacer()
                            Text(country.capital ?? "")
                                .font(.title3)
                                .fontWeight(.bold)
                                .padding(40)
                                .opacity(0.8)
                                .shadow(color: .black, radius: 20)
                        }
                        Text("Population: \(country.population)")
                            .font(.title)
                            .fontWeight(.bold)
                            .opacity(0.8)
                            .shadow(color: .black, radius: 10)
                        Spacer()
                        
                    }.frame(width: UIScreen.screenWidth,
                            height: UIScreen.screenHeight/4,
                            alignment: .center)
                        .padding(-20)
                        .background(KFImage(URL(string: country.flagURL ?? ""))
                                        .resizable()
                                        .opacity(0.6)
                                        .cornerRadius(15))
                }.listStyle(.plain)
                
            }.onAppear(perform: {
            }).fileExporter(
                isPresented: $viewModel.isExporting,
                document: viewModel.document,
                contentType: .plainText,
                defaultFilename: "Message"
            ) { _ in
            }.navigationBarItems(trailing:
                                    Button {
                viewModel.configureMessage()
            } label: {
                Image(systemName: "square.and.arrow.up")
            })
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView()
    }
}
