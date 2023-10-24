//
//  ProgressCardView().swift
//  GetHired
//
//  Created by Yehor Sorokin on 06.12.22.
//

import SwiftUI

struct ProgressCardView: View {
    var body: some View {
        VStack {
            Text("Please standby. Personalised search may take a few minutes")
                .multilineTextAlignment(.center)
                .bold()
            Spacer()
            ProgressView()
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
}

struct ProgressCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressCardView()
    }
}
