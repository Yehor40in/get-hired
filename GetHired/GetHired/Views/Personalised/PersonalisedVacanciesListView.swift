//
//  PersonalisedVacanciesListView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 04.12.22.
//

import SwiftUI

struct PersonalisedVacanciesListView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        if modelData.isSearching {
            VStack {
                ProgressCardView()
                VacanciesByAreaView()
            }
        } else {
            ScrollView {
                VStack {
                    ForEach(modelData.personalisedVacancies) { vacancy in
                        NavigationLink(destination: VacancyDetailView(vacancy: vacancy)) {
                            VacancyRow(vacancy: vacancy)
                        }
                    }
                }
                .padding()
                VacanciesByAreaView()
            }
        }
    }
}

struct PersonalisedVacanciesListView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalisedVacanciesListView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
