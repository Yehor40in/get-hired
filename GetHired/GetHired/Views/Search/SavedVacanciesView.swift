//
//  SavedVacanciesView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 20.11.22.
//

import SwiftUI

struct SavedVacanciesView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationView {
            if modelData.savedVacancies.isEmpty {
                SavedVacanciesEmptyView()
                    .navigationTitle("Saved")
            } else {
                ScrollView {
                    ForEach(modelData.savedVacancies) { vacancy in
                        NavigationLink (destination: VacancyDetailView(vacancy: vacancy)) {
                            VacancyRow(vacancy: vacancy)
                        }
                    }
                }
                .padding()
                .navigationTitle("Saved")
            }
        }
    
    }
}

struct SavedVacanciesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedVacanciesView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
