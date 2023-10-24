//
//  VacancyRow.swift
//  GetHired
//
//  Created by Yehor Sorokin on 06.08.22.
//

import SwiftUI

struct VacancyRow: View {
    
    var vacancy: Vacancy
    
    var body: some View {
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
            Spacer()
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
        .frame(height: 150)
        .foregroundColor(.white)
        .padding()
        .background (LinearGradient(colors: [.blue, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
        .mask(RoundedRectangle(cornerRadius: 10))
    }
}

struct VacancyRow_Previews: PreviewProvider {
    static var previews: some View {
        VacancyRow(vacancy: Vacancy(title: "Gardener", companyName: "Garden solutions", companyLocation: "Dresden", type: "Full-time", daysAgo: "14", detailURL: "https://blank.com"))
    }
}
