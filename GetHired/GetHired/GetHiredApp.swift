//
//  GetHiredApp.swift
//  GetHired
//
//  Created by Yehor Sorokin on 02.08.22.
//

import SwiftUI

@main
struct GetHiredApp: App {
    
    @StateObject var modelData = ModelData(using: DataFetcher(of: Config.targets),
                                           storageManager: Saver.shared,
                                           personaliseManager: Personaliser.shared)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
