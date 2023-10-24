//
//  PersonalisedEmptyView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 01.12.22.
//

import SwiftUI

struct PersonalisedEmptyView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "rectangle.stack.badge.person.crop")
            Text("Add information about you to explore vacancies picked just for your profile")
                .padding()
                .multilineTextAlignment(.center)
                .italic()
            NavigationLink(value: Routes.degree("Please specify your education")) {
                Text("Get started with personalised search")
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

struct PersonalisedEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalisedEmptyView()
    }
}
