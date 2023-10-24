//
//  PersonalisedNotFoundView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 18.12.22.
//

import SwiftUI

struct PersonalisedNotFoundView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
            Text("We couldn't find any offers matching you profile. Let's try different search criterias")
                .padding()
                .multilineTextAlignment(.center)
                .italic()
            NavigationLink(value: Routes.degree("Please specify your education")) {
                Text("Adjust search settings")
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
            }
        }
        .padding()
        .shadow(radius: 10)
        .foregroundColor(.white)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 10))
        
    }
}

struct PersonalisedNotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalisedNotFoundView()
    }
}
