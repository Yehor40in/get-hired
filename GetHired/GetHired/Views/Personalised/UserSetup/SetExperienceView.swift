//
//  SetExperienceView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.12.22.
//

import SwiftUI

struct SetExperienceView: View {
    @EnvironmentObject var modelData: ModelData
    
    var question: String
    
    var body: some View {
        VStack {
            Text(question)
                .bold()
                .padding()
            Picker(question, selection: $modelData.user.experience) {
                ForEach(Experience.allCases) { type in
                    Text(type.rawValue).tag(type)
                }
            }
            .padding()
            
            NavigationLink(value: Routes.interests("Tell us about your interests")) {
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
        .navigationTitle("Step 2. Experience")
        .padding()
    }
}

struct SetExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        SetExperienceView(question: "Do you have previous experience?")
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
