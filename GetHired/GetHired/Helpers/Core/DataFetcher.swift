//
//  DataFetcher.swift
//  GetHired
//
//  Created by Yehor Sorokin on 03.08.22.
//

import Foundation
import SwiftUI


final class DataFetcher: RequestsManager, ObservableObject {
    
    @Published var error = ""
    
    internal let parser: ParseManager = Parser.shared
    internal let targets: [Target]
    
    private let safariBrowserHeaders = [
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Encoding": "gzip, deflate, br",
        "User-Agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/15.5 Safari/605.1.15",
        "Accept-Language": "en-GB,en;q=0.9",
        "Connection": "keep-alive"
    ]
    
    // MARK: Init
    init(of list: [Target]) {
        targets = list
    }
    
    
    // MARK: Methods
    func makeRequest(for target: Target, searchParam: String = "") -> URLRequest? {
        var urlString = target.urlString
        
        if !searchParam.isEmpty {
            urlString += target.GETparams.replacingOccurrences(of: "{VACANCY_NAME}", with: searchParam)
        }
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = safariBrowserHeaders
            return request
        } else {
            print("Couldn't make request for target \(urlString)")
            self.error = "Couldn't get contents. Please try again"
        }
        return nil
    }
    
    
    func getContents(using request: URLRequest) async -> Data? {
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        } catch {
            self.error = "Couldn't get contents. Please try again"
        }
        return nil
    }
    
    
    func retrieveVacancies(using raw: Data) -> [Vacancy] {
        return parser.parseVacancies(from: raw)
    }
    
    
    func fetch(using vacancyName: String) async -> [Vacancy] {
        var rawVacancies = Data()
        
        for target in targets {
            if let request = makeRequest(for: target, searchParam: vacancyName),
                let buffer = await getContents(using: request) {
                rawVacancies += buffer
            } else {
                self.error = "Couldn't get contents. Please try again"
            }
        }
        return retrieveVacancies(using: rawVacancies)
        
    }
    
    
    func fetchDetails(from url: String) async -> String {
        if let request = makeRequest(for: Target(urlString: url)),  
           let buffer = await getContents(using: request) {
            return parser.parseDetails(of: buffer)
        }
        return "Couldn't fetch details. Try again"
    }
    
    
}
