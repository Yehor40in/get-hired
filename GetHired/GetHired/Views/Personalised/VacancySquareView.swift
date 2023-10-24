//
//  VacancySquareView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 01.12.22.
//

import SwiftUI

public var colors: [Color] = [.blue, .cyan, .green, .indigo, .mint, .pink, .orange, .purple, .red, .teal, .yellow]

struct VacancySquareView: View {
    
    var description: String
    
    var body: some View {
        Text(description)
            .frame(width: 200, height: 200)
            .bold()
            .italic()
            .font(.title2)
            .multilineTextAlignment(.leading)
            .foregroundColor(.white)
            .padding()
            .background {
                LinearGradient(colors: [colors[Int.random(in: 0...10)],
                                                    colors[Int.random(in: 0...10)]],
                                                    startPoint: .topLeading,
                               endPoint: .bottomTrailing)
                .cornerRadius(10)
            }
    }
}

struct VacancySquareView_Previews: PreviewProvider {
    static var previews: some View {
        VacancySquareView(description: "Computer Science and Technologies")
    }
}
