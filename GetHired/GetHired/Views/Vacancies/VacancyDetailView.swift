//
//  VacancyDetailView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 15.08.22.
//

import SwiftUI

struct VacancyDetailView: View {
    
    @Namespace var namespace
    
    @EnvironmentObject var modelData: ModelData
        
    @State var vacancy: Vacancy
    @State var showsSafari = false
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                VacancyExpanded(vacancy: vacancy)
                    .animation(.spring(), value: vacancy.description)
                ActionsView(vacancyID: vacancy.id, showsSafari: $showsSafari)
                    .transition(.scale)
                if modelData.isUpdatingVacancy {
                    VStack {
                        ProgressView()
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10)
                        .matchedGeometryEffect(id: "mask", in: namespace))
                } else {
                    VStack {
                        Text(vacancy.description)
                            .padding(.top, 10)
                            .transition(.opacity)
                            .padding()
                    }
                    .background(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 10)
                        .matchedGeometryEffect(id: "mask", in: namespace))
                }
            }
            .animation(.spring(), value: modelData.isUpdatingVacancy)
            .task {
                if vacancy.description.isEmpty {
                    vacancy.description = await modelData.updatedVacancyDescription(id: vacancy.id)
                }
            }
            .padding()
        }
        .fullScreenCover(isPresented: $showsSafari) {
            SFSafariViewWrapper(url: URL(string: vacancy.detailURL)!)
        }
        
    }
        
}

struct VacancyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VacancyDetailView(vacancy: Vacancy.dummyVacancy)
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
