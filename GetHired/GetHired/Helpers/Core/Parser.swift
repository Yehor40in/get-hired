//
//  Parser.swift
//  GetHired
//
//  Created by Yehor Sorokin on 03.08.22.
//

import Foundation
import SwiftSoup


final class Parser: ParseManager {
    
    static let shared = Parser()
    
    func parseVacancies(from data: Data) -> [Vacancy] {
        var vacancies: [Vacancy] = []
        let html = String(data: data, encoding: .utf8)!
        
        vacancies += parseFromIndeed(html: html)
        vacancies += parseFromStepstone(html: html)
        vacancies += parseFromGlassdoor(html: html)
        
        return vacancies
    }
    
    func parseDetails(of data: Data) -> String {
        let html = String(data: data, encoding: .utf8)!
        
        if let description = parseIndeedDetails(html: html) {
            return description
        }
        if let description = parseGlassdoorDetails(html: html) {
            return description
        }
        return ""
    }
    
    
    private func parseIndeedDetails(html: String) -> String? {
        do {
            return try SwiftSoup.parse(html).select("#jobDescriptionText").text()
        } catch {
            print("Error in parser \n\n\n \(error)")
        }
        return nil
    }
    
    private func parseGlassdoorDetails(html: String) -> String? {
        do {
            return try SwiftSoup.parse(html).select(".desc").text()
        } catch {
            print("Error in parser \n\n\n \(error)")
        }
        return nil
    }
    
    
    
    private func parseFromIndeed(html: String) -> [Vacancy] {
        var indeedVacancies: [Vacancy] = []
        do {
            let result: Elements = try SwiftSoup.parse(html).select(".result")
            for element in result.array() {
                var fields: [String: String] = [:]
                
                let children: Elements = element.children()
                fields["title"] = try children.select(".jobTitle").text()
                fields["companyName"] = try children.select(".companyName").text()
                fields["companyLocation"] = try children.select(".companyLocation").text()
                fields["type"] = try children.select(".attribute_snippet").text()
                fields["daysAgo"] = try children.select(".date").text()
                fields["url"] = try children.select(".jcs-JobTitle").attr("href")
                
                indeedVacancies.append(Vacancy(title: fields["title"] ?? "",
                                               companyName: fields["companyName"] ?? "",
                                               companyLocation: fields["companyLocation"] ?? "",
                                               type: fields["type"] ?? "",
                                               daysAgo: fields["daysAgo"] ?? "> 30 days ago",
                                               detailURL: "https://de.indeed.com" + (fields["url"] ?? ""))
                )
            }
        } catch {
            print("Error in parser \n\n\n \(error)")
            return []
        }
        return indeedVacancies
    }
    
    
    private func parseFromStepstone(html: String) -> [Vacancy] {
        return []
    }
    
    
    private func parseFromGlassdoor(html: String) -> [Vacancy] {
        var glassdoorVacancies: [Vacancy] = []
        do {
            let result: Elements = try SwiftSoup.parse(html).select(".react-job-listing")
            for element in result.array() {
                var fields: [String: String] = [:]
                
                let children: Elements = element.children()
                fields["title"] = try children.select(".jobLink").text()
                fields["companyName"] = try children.select(".job-search-key-l2wjgv").text()
                fields["companyLocation"] = try children.select(".job-search-key-1m2z0go").text()
                fields["type"] = try children.select(".job-search-key-1a46cm1").text()
                fields["daysAgo"] = try children.select(".css-17n8uzw").text()
                fields["url"] = try children.select(".jobLink").attr("href")
                
                glassdoorVacancies.append(Vacancy(title: fields["title"] ?? "",
                                               companyName: fields["companyName"] ?? "",
                                               companyLocation: fields["companyLocation"] ?? "",
                                               type: fields["type"] ?? "",
                                               daysAgo: fields["daysAgo"] ?? "",
                                               detailURL: "https://www.glassdoor.de" + (fields["url"] ?? ""))
                )
            }
        } catch {
            print("Error in parser \n\n\n \(error)")
            return []
        }
        return glassdoorVacancies
    }
}
