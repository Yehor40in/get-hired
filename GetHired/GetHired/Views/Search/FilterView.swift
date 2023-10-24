//
//  FilterView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 10.08.22.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var modelData: ModelData
    
    @Binding var filters: ModelData.Filters
    
    var body: some View {
        VStack {
            HStack() {
                Button("Cancel", role: .cancel) {
                    filters = modelData.searchFilters
                    dismiss()
                }
                .foregroundColor(.red)
                .padding()
                Spacer()
                Button("Done") {
                    dismiss()
                }
                .padding()
            }
            List {
                TextField("By city", text: $filters.byCity)
                
                Toggle("Newest first", isOn: $filters.newestFirst)
                Toggle("Salary specified", isOn: $filters.salarySpecified)
                Toggle("Remote only", isOn: $filters.remoteOnly)
                
                Picker("Experience level", selection: $filters.seniority) {
                    ForEach(ModelData.Filters.Seniority.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.inline)
                Button(action: {
                    filters = ModelData.Filters.defaults
                }, label: {
                    Text("Reset")
                        .bold()
                        .foregroundColor(.red)
                })
            }
        }
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView(filters: .constant(ModelData.Filters.defaults))
    }
}
