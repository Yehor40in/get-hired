//
//  User.swift
//  GetHired
//
//  Created by Yehor Sorokin on 01.12.22.
//

import Foundation

public enum Degree: String, Identifiable, CaseIterable {
    case bachelor
    case master
    case student
    case noDegree = "No Degree"
    
    public var id: String { rawValue }
}

public enum Experience: String, Identifiable, CaseIterable {
    case experienced
    case noExperience
    
    public var id: String { rawValue }
}

struct User {
    var degree: Degree = .noDegree
    var educationField: String = ""
    var experience: Experience = .noExperience
    var interests: [String] = []
    
    var isDraft = true
    var isSearchValid = true
    
    public static var draftUser = User()
}

