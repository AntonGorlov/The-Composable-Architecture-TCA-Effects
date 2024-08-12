//
//  EffectsApp.swift
//  Effects
//
//  Created by Anton Gorlov on 05.08.2024.
//

import SwiftUI
import ComposableArchitecture

@main
struct EffectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: ProcessingReducer.State(), reducer: {
                ProcessingReducer()
            }))
        }
    }
}
