//
//  ModelData.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import Foundation
import Combine

final class ModelData: ObservableObject {
    
    var vacancies: [Vacancy] = []
    var personalisedUnprocessed: [Vacancy] = []
    var jobAreas = [
        "Architecture and engineering",
        "Arts, culture and entertainment",
        "Business, management and administration",
        "Communications",
        "Community and social services",
        "Computers, IT",
        "Education",
        "Science and technology",
        "Installation, repair and maintenance",
        "Farming, fishing and forestry",
        "Government",
        "Health and medicine",
        "Law and public policy",
        "Sales"
    ]
    
    @Published var vacanciesByArea: [String: [Vacancy]] = [:]
    @Published var savedVacancies: [Vacancy] = []
    @Published var personalisedVacancies: [Vacancy] = []
    @Published var filteredVacancies: [Vacancy] = []
    @Published var searchHistory: [String] = []
    @Published var searchText = ""
    @Published var isSearching = false
    @Published var isUpdatingVacancy = false
    @Published var searchFilters = Filters.defaults
    @Published var user = User.draftUser
    
    private let fetcher: RequestsManager
    private let saver: StorageManager
    private let personaliser: PersonaliseManager
    
    private var searchTask: Task<Void, Never>?
    
    struct Filters {
        enum Seniority: String, Identifiable, CaseIterable  {
            case junior
            case middle
            case senior
            case all
            var id: String { rawValue }
        }
        var remoteOnly: Bool
        var salarySpecified: Bool
        var newestFirst: Bool
        var seniority: Seniority
        var byCity: String = ""
        
        static var defaults = Filters(remoteOnly: false, salarySpecified: false, newestFirst: false, seniority: .all)
    }
    
    
    // MARK: Init
    init(using requestsManager: RequestsManager, storageManager: StorageManager, personaliseManager: PersonaliseManager) {
        fetcher = requestsManager
        saver = storageManager
        personaliser = personaliseManager
    }
    
    
    @MainActor
    func update() async {
        searchTask?.cancel()
        let currentSearchTerm = searchText.replacingOccurrences(of: " ", with: "-").lowercased()
        if currentSearchTerm.isEmpty {
            isSearching = false
        } else {
            searchTask = Task {
                isSearching = true
                vacancies = await fetcher.fetch(using: currentSearchTerm)
                filterResults()
                if !Task.isCancelled {
                    isSearching = false
                    updateHistory(with: searchText)
                }
            }
        }
    }
    
    @MainActor
    func updatedVacancyDescription(id: UUID) async -> String {
        isUpdatingVacancy = true
        let description = await fetcher.fetchDetails(from: vacancyByID(id: id).detailURL)
        isUpdatingVacancy = false
        return description
    }
    
    
    @MainActor
    func personalisedSearch () async {
        isSearching = true
        for intereset in user.interests {
            personalisedUnprocessed += await fetcher.fetch(using: intereset.replacingOccurrences(of: " ", with: "-").lowercased())
        }
        for i in personalisedUnprocessed.indices {
            personalisedUnprocessed[i].description = await updatedVacancyDescription(id: personalisedUnprocessed[i].id)
        }
        personalisedVacancies = personaliser.personaliseVanacies(personalisedUnprocessed, using: user)
        if personalisedVacancies.isEmpty {
            user.isSearchValid = false
            user.isDraft = true
        }
        isSearching = false
    }
    
    
    @MainActor
    func fetchVacanciesByArea(using keyword: String) async {
        isSearching = true
        vacanciesByArea[keyword] = await fetcher.fetch(using: keyword.replacingOccurrences(of: " ", with: "-").lowercased())
        isSearching = false
    }
    
    
    func filterResults() -> Void {
        var copy: [Vacancy] = vacancies
        if searchFilters.salarySpecified {
            copy = copy.filter({$0.type.contains("€")})
        }
        if searchFilters.newestFirst {
            copy = copy.sorted(by: {
        //---------------------------------------------
        // TODO: Fix this (possibly via regex)
            Int($0.daysAgo)! > Int($1.daysAgo)!
        //
        //---------------------------------------------
            })
        }
        if !searchFilters.byCity.isEmpty {
            copy = copy.filter({ $0.companyLocation.contains(searchFilters.byCity) })
        }
        if searchFilters.seniority != .all {
            copy = copy.filter({ $0.title.lowercased().contains(searchFilters.seniority.rawValue) })
        }
        if searchFilters.remoteOnly {
            copy = copy.filter({ $0.companyLocation.contains("Homeoffice") || $0.companyLocation.contains("Remote") })
        }
        filteredVacancies = copy
    }
    
    func vacancyByID(id: UUID) -> Vacancy {
        if let v = vacancies.first(where: {$0.id == id}) {
            return v
        }
        if let v = personalisedUnprocessed.first(where: {$0.id == id}) {
            return v
        }
        for key in vacanciesByArea.keys {
            if let v = vacanciesByArea[key]?.first(where: {$0.id == id}) {
                return v
            }
        }
        return Vacancy.dummyVacancy
    }
    
    
    private func updateHistory(with item: String) -> Void {
        if !searchHistory.contains(item) {
            searchHistory.append(item)
        }
    }
}


//MARK: StorageManagement
extension ModelData {
    
    //---------------------------------------------
    //
    // TODO: Implement
    //
    //---------------------------------------------
    
    func saveVacancies() {
        saver.save(vacancies: vacancies.filter{ $0.isSaved })
    }
    
    func loadSavedVacancies() {
        
    }
}
