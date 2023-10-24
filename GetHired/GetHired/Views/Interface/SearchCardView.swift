//
//  SearchCardView().swift
//  GetHired
//
//  Created by Yehor Sorokin on 11.12.22.
//

import SwiftUI

struct SearchCardView: View {
    var body: some View {
        VStack {
            Image(systemName: "magnifyingglass")
                .padding()
            Spacer()
            Text("Type in vacancy related keywords to begin search")
                .padding()
                .multilineTextAlignment(.center)
            Spacer()
        }
        .foregroundColor(.white)
        .background(LinearGradient(colors: [colors[Int.random(in: 0...10)],
                                            colors[Int.random(in: 0...10)]],
                                            startPoint: .topLeading,
                       endPoint: .bottomTrailing))
        .cornerRadius(10)
    }
}

struct SearchCardView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCardView()
    }
}
