//
//  Targtes.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import Foundation

struct Target {
    var urlString: String
    var GETparams: String = ""
}


struct Config {
    
    
    static let targets = [
        
        Target(urlString: "https://de.indeed.com", GETparams: "/jobs?q={VACANCY_NAME}"),
        Target(urlString: "https://www.stepstone.de", GETparams: "/jobs/{VACANCY_NAME}"),
        Target(urlString: "https://www.glassdoor.de/Job", GETparams: "/{VACANCY_NAME}-jobs-SRCH_KO0,13.htm")

    ]
    
}
