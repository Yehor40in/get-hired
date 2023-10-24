//
//  TopBar.swift
//  GetHired
//
//  Created by Yehor Sorokin on 14.08.22.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var showsFilters: Bool
    @Binding var text: String
    
    var body: some View {
        VStack {
            HStack {
                Text("Search")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                Spacer()
                Button(action: {
                    showsFilters.toggle()
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .padding()
                        .background(.ultraThinMaterial)
                        .mask(RoundedRectangle(cornerRadius: 10))
                })
                .padding()
                
                
            }
            .offset(y: 25)
            SearchBar(text: $text)
        }
        .background(.ultraThinMaterial)
        
    }
}

struct TopBar_Previews: PreviewProvider {
    static var previews: some View {
        TopBar(showsFilters: .constant(false), text: .constant(""))
    }
}
