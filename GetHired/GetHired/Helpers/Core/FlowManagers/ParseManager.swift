//
//  ParseManager.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import Foundation


protocol ParseManager: AnyObject {
    
    func parseVacancies(from data: Data) -> [Vacancy]
    func parseDetails(of data: Data) -> String
    
}
