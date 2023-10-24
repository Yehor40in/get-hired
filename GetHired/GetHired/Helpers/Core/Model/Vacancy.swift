//
//  Vacancy.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import Foundation


struct Vacancy: Codable, Identifiable {
    var id = UUID()
    
    var title: String
    var companyName: String
    var companyLocation: String
    var type: String
    var daysAgo: String
    var detailURL: String
    var description: String = ""
    var isSaved: Bool = false
    
    static var dummyVacancy = Vacancy(title: "", companyName: "", companyLocation: "", type: "", daysAgo: "", detailURL: "https://qwerty.uio")
}
