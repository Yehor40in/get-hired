//
//  SavedVacanciesEmptyView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 29.11.22.
//

import SwiftUI

struct SavedVacanciesEmptyView: View {
    var body: some View {
        VStack {
            Image(systemName: "bookmark")
                .padding()
            Text("Your saved offers will appear here")
                .bold()
                .padding()
        }
        .padding()
        .background(LinearGradient(colors: [colors[Int.random(in: 0...10)],
                                            colors[Int.random(in: 0...10)]],
                                            startPoint: .topLeading,
                       endPoint: .bottomTrailing))
        .foregroundColor(.white)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
}

struct SavedVacanciesEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        SavedVacanciesEmptyView()
    }
}
