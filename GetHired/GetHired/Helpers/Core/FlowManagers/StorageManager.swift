//
//  StorageManager.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import Foundation


protocol StorageManager: AnyObject {
    
    func save(vacancies: [Vacancy]) -> Void
    func load() -> [Vacancy]
    
}
