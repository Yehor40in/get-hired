//
//  VacanciesByAreaView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 01.12.22.
//

import SwiftUI

struct VacanciesByAreaView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("More job areas")
                .bold()
                .font(.largeTitle)
                .padding()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(modelData.jobAreas, id: \.self) { area in
                        NavigationLink(destination: VacanciesByAreaListView(keyword: area)) {
                            VacancySquareView(description: area)
                        }
                        
                    }
                }
                .padding(.leading, 10)
            }
        }
    }
}

struct VacanciesByAreaView_Previews: PreviewProvider {
    static var previews: some View {
        VacanciesByAreaView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
