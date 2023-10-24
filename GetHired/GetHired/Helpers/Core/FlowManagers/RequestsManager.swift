//
//  RequestsManager.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import Foundation
import Combine

protocol RequestsManager: AnyObject {
    
    var targets: [Target] { get }
    var parser: ParseManager { get }
    
    func makeRequest(for target: Target, searchParam: String) -> URLRequest?
    func getContents(using request: URLRequest) async -> Data?
    func retrieveVacancies(using raw: Data) -> [Vacancy]
    
    func fetch(using vacancyName: String) async -> [Vacancy]
    func fetchDetails(from url: String) async -> String
}
