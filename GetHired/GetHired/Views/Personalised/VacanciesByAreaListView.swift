//
//  VacanciesByAreaListView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 11.12.22.
//

import SwiftUI

struct VacanciesByAreaListView: View {
    
    var keyword: String
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ScrollView {
            if modelData.isSearching {
                ProgressView()
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            } else {
                VStack {
                    if let vacancies = modelData.vacanciesByArea[keyword] {
                        ForEach(vacancies) { vacancy in
                            NavigationLink(destination: VacancyDetailView(vacancy: vacancy)) {
                                VacancyRow(vacancy: vacancy)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .task {
            if modelData.vacanciesByArea[keyword]?.isEmpty == nil {
                await modelData.fetchVacanciesByArea(using: keyword)
            }
        }
        .navigationTitle(keyword)
        
    }
}

struct VacanciesByAreaListView_Previews: PreviewProvider {
    static var previews: some View {
        VacanciesByAreaListView(keyword: "Computers, IT")
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
