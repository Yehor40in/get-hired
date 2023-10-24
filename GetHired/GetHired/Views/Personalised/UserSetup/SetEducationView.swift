//
//  SetEducationView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.12.22.
//

import SwiftUI

struct SetEducationView: View {
    @EnvironmentObject var modelData: ModelData
    
    var question: String
    
    var body: some View {
        VStack {
            Text(question)
                .bold()
                .padding()
            Picker(question, selection: $modelData.user.degree) {
                ForEach(Degree.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .padding()
            
            if modelData.user.degree != .noDegree {
                Text("Please specify your field of study")
                    .padding()
                    .bold()
                TextField("Type here", text: $modelData.user.educationField)
                    .padding()
                    .background(.ultraThinMaterial)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
            }
            
            NavigationLink(value: Routes.experience("Do you have previous experience?")) {
                Text("Next")
                    .padding()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .background(.cyan)
                    .cornerRadius(10)
            }
            .padding(.top, 10)
            .shadow(radius: 10)
        }
        .pickerStyle(.segmented)
        .navigationTitle("Step 1. Education")
        .padding()
    }
}

struct SetEducationView_Previews: PreviewProvider {
    static var previews: some View {
        SetEducationView(question: "Spectify if you have a degree")
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
