//
//  SearchView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 10.08.22.
//

import SwiftUI


struct SearchView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State var showsFilters = false
    @State var draftFilters = ModelData.Filters.defaults
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                ListView()
                    .searchable(text: $modelData.searchText)
                    .animation(.easeInOut, value: modelData.isSearching)
                    .padding()
            }
            .toolbar {
                Button("Filter") {
                    showsFilters.toggle()
                }
            }
            .navigationTitle("Explore")
            .blur(radius: modelData.isSearching ? 200 : 0)
            .onReceive(modelData.$searchText) { _ in
                Task {
                    await modelData.update()
                }
            }
            .overlay {
                if modelData.isSearching {
                    ProgressView()
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
            }
            .sheet(isPresented: $showsFilters) {
                FilterView(filters: $draftFilters)
                    .onAppear {
                        draftFilters = modelData.searchFilters
                    }
                    .onDisappear {
                        modelData.searchFilters = draftFilters
                        modelData.filterResults()
                    }
            }

        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
            .previewInterfaceOrientation(.portrait)
    }
}
