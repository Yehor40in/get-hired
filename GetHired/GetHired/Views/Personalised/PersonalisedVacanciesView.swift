//
//  PersonalisedVacanciesView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 01.12.22.
//

import SwiftUI

enum Routes: Hashable {
    case degree(String)
    case experience(String)
    case interests(String)
}

struct PersonalisedVacanciesView: View {

    @State var path: [Routes] = []
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                if !modelData.user.isDraft {
                    PersonalisedVacanciesListView()
                        .task {
                            if modelData.personalisedVacancies.isEmpty {
                                await modelData.personalisedSearch()
                            }
                        }
                } else if !modelData.user.isSearchValid {
                    PersonalisedNotFoundView()
                        .padding()
                } else {
                    PersonalisedEmptyView()
                        .padding()
                }
                VacanciesByAreaView()
                
            }
            .navigationDestination(for: Routes.self) { route in
                switch route {
                case let .degree(value):
                    SetEducationView(question: value)
                case let .experience(value):
                    SetExperienceView(question: value)
                case let .interests(value):
                    SetInterestsView(path: $path, question: value)
                        .environment(\.editMode, .constant(EditMode.active))
                }
            }
            .foregroundColor(.white)
            .navigationTitle("Top picks for you")
            .background {
                Image("background_main")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea(.all)
            }
        }
    }
}

struct PersonalisedVacanciesView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalisedVacanciesView()
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
