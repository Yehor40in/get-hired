//
//  ActionsView.swift
//  GetHired
//
//  Created by Yehor Sorokin on 15.08.22.
//

import SwiftUI

struct ActionsView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var vacancyID: UUID
    
    @Binding var showsSafari: Bool
    
    var body: some View {
        VStack (alignment: .leading) {
            safariButton
            Divider()
            shareButton
            Divider()
            saveButton
        }
        .frame(width: 150)
        .padding()
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 10))
    }
    
    var safariButton: some View {
        Button(action: {
            showsSafari.toggle()
        }, label: {
            Label("Visit website", systemImage: "safari")
        })
        .foregroundColor(.black)
    }
    
    var shareButton: some View {
        Button(action: {
            showsSafari.toggle()
        }, label: {
            Label("Share", systemImage: "square.and.arrow.up")
        })
        .foregroundColor(.black)
    }
    
    var saveButton: some View {
        Button(action: {
            if modelData.savedVacancies.contains(where: {$0.id == vacancyID}) {
                modelData.savedVacancies = modelData.savedVacancies.filter({$0.id != vacancyID})
            } else {
                modelData.savedVacancies.append(modelData.vacancyByID(id: vacancyID))
            }
        }, label: {
            HStack {
                Label("Save", systemImage: modelData.savedVacancies.contains{$0.id == vacancyID} ? "bookmark.fill" : "bookmark")
            }
            .foregroundColor(.black)
        })
    }
}

struct ActionsView_Previews: PreviewProvider {
    static var previews: some View {
        ActionsView(vacancyID: UUID(), showsSafari: .constant(false))
            .environmentObject(ModelData(using: DataFetcher(of: Config.targets),
                                         storageManager: Saver.shared,
                                         personaliseManager: Personaliser.shared))
    }
}
