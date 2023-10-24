//
//  VacancyExpanded.swift
//  GetHired
//
//  Created by Yehor Sorokin on 15.08.22.
//

import SwiftUI

struct VacancyExpanded: View {
    
    var vacancy: Vacancy
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading) {
                HStack {
                    VStack (alignment: .leading) {
                        Text(vacancy.title)
                            .font(.headline)
                            .bold()
                            .lineLimit(3)
                        Text(vacancy.companyLocation)
                            .italic()
                            .font(.footnote)
                    }
                    Spacer()
                    Text(vacancy.companyName)
                        .font(.caption)
                        .bold()
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                }
                HStack {
                    Text(vacancy.type)
                        .font(.subheadline)
                        .lineLimit(2)
                    Spacer()
                    Text(vacancy.daysAgo)
                        .font(.footnote)
                        .italic()
                }
            }
            .foregroundColor(.white)
            .padding()
            .background (LinearGradient(colors: [.blue, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
            .mask(RoundedRectangle(cornerRadius: 10))
        }
    }
    
}

struct VacancyExpanded_Previews: PreviewProvider {
    static var previews: some View {
        VacancyExpanded(vacancy: Vacancy.dummyVacancy)
    }
}
