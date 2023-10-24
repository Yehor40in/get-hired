//
//  ListView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 13.08.22.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .leading) {
            
            if modelData.filteredVacancies.isEmpty {
                SearchCardView()
            } else {
                ForEach(modelData.filteredVacancies) { vacancy in
                    NavigationLink(destination: VacancyDetailView(vacancy: vacancy)) {
                        VacancyRow(vacancy: vacancy)
                    }
                }
            
            }
        }
        
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}

