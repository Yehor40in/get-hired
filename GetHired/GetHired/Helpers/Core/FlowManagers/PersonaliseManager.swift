//
//  PersonaliseManager.swift
//  GetHired
//
//  Created by Yehor Sorokin on 04.12.22.
//

import Foundation

protocol PersonaliseManager: AnyObject {
    func personaliseVanacies(_ vacancies: [Vacancy], using profile: User) -> [Vacancy]
}
