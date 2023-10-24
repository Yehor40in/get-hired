//
//  Personaliser.swift
//  GetHired
//
//  Created by Yehor Sorokin on 04.12.22.
//


import Foundation

final class Personaliser: PersonaliseManager {
    
    static let shared = Personaliser()
    
    func personaliseVanacies(_ vacancies: [Vacancy], using profile: User) -> [Vacancy] {
        print("\n\nin personaliseVanacies\n\n ")
        print(vacancies)
        var copy: [Vacancy] = vacancies
        copy = personaliseByDegree(copy, using: profile)
        copy = personaliseByEducationField(copy, using: profile)
        copy = personaliseByExperience(copy, using: profile)
        return copy
    }
    
    
    private func personaliseByDegree(_ vacancies: [Vacancy], using profile: User) -> [Vacancy] {
        //------------------------------------------------
        //
        // TODO: Switch to regex instead of plain string
        //
        //------------------------------------------------
        print("\n\nin personaliseByDegree\n\n ")
        print(vacancies)
        var searchTerm: String?
        switch profile.degree {
        case .bachelor:
            searchTerm = "(Bachelor( Dimplom| Grad)?)|Bachelorabschluss"
        case .master:
            searchTerm = "(Master-Abschlüsse)|Master( Diplom| Grad)?"
        case .student:
            searchTerm = "Student|Studentin|Absolvent"
        default:
            break
        }
        if let expr = searchTerm {
//            return vacancies.filter { $0.description.contains(expr) }
            return vacancies.filter {
                $0.description.range(of: expr, options: .regularExpression) != nil
            }
        }
        return vacancies
    }
    
    
    private func personaliseByExperience(_ vacancies: [Vacancy], using profile: User) -> [Vacancy] {
        //------------------------------------------------
        //
        // TODO: Switch to regex instead of plain string
        //
        //------------------------------------------------
        print("\n\nin personaliseByExperience\n\n ")
        print(vacancies)
        if profile.experience == .experienced {
            return vacancies.filter {
                $0.description.range(of: "Erfahrung|Berufserfahrung|Experience", options: .regularExpression) != nil
            }
        }
        return vacancies
    }
    
    
    private func personaliseByEducationField(_ vacancies: [Vacancy], using profile: User) -> [Vacancy] {
        print("\n\nin personaliseByEducationField\n\n ")
        print(vacancies)
        if !profile.educationField.isEmpty {
            return vacancies.filter {$0.description.contains(profile.educationField)}
        }
        return vacancies
    }
    
}
