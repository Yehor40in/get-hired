//
//  SetInterestsView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.12.22.
//

import SwiftUI

struct SetInterestsView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State var selection: Set<String> = []
    @Binding var path: [Routes]
    
    var question: String
    
    var body: some View {
        VStack {
            Text(question)
                .bold()
                .padding()
            VStack {
                List(modelData.jobAreas, id: \.self, selection: $selection) { area in
                    Text(area)
                }
                .listStyle(.inset)
            }
            
            Button(action: {
                modelData.user.interests.append(contentsOf: Array(selection))
                modelData.user.isDraft = false
                path.removeAll()
            }, label: {
                Text("Finish")
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(.green)
                    .cornerRadius(10)
            })
            .padding(.top, 10)
            .shadow(radius: 10)
        }
        .pickerStyle(.segmented)
        .navigationTitle("Step 3. Interests")
        .padding()
    }
}

struct SetInterestsView_Previews: PreviewProvider {
    static var previews: some View {
        SetInterestsView(path: .constant([]),question: "What are you intereseted in?")
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
