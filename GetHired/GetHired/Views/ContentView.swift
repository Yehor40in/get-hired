//
//  ContentView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            SearchView()
                .tabItem {
                    Label("Explore", systemImage: "magnifyingglass")
                }
                .tag(1)
            PersonalisedVacanciesView()
                .tabItem {
                    Label("For you", systemImage: "person.crop.circle")
                }
                .tag(2)
            SavedVacanciesView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .tag(3)
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
