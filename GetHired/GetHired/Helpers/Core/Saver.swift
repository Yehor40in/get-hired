//
//  Saver.swift
//  GetHired
//
//  Created by Yehor Sorokin on 03.08.22.
//

import Foundation


final class Saver: StorageManager {
    
    private let fileName = "savedVacancies"
    private let ext = "json"
    
    var path: String {
        "\(fileName).\(ext)"
    }
    
    static let shared = Saver()
    
    
    func save(vacancies: [Vacancy]) -> Void {
        do {
            let json = try JSONEncoder().encode(vacancies)
            if (FileManager.default.fileExists(atPath: path)) {
                if let path = Bundle.main.url(forResource: fileName, withExtension: ext) {
                    try json.write(to: path)
                } else {
                    print("\n\n\n\n !!!!! \n Couldn't save vacancies to file\n\n\n\n")
                }
            }
            else {
                FileManager.default.createFile(atPath: path, contents: json)
            }
        } catch let error {
            print("\n\n\n\n !!!!!!!! \n Couldn't encode vacancies to JSON \(error.localizedDescription)\n\n\n\n")
        }
    }
    
    
    func load() -> [Vacancy] {
        do {
            if let url = Bundle.main.url(forResource: fileName, withExtension: ext) {
                let data = try Data(contentsOf: url)
                let vacancies = try JSONDecoder().decode([Vacancy].self, from: data)
                return vacancies
            }
        } catch let error {
            print("\n\n\n\n !!!!!!!! \n Couldn't encode vacancies to JSON \(error.localizedDescription)\n\n\n\n")
        }
        
        return []
    }
    
    
}
