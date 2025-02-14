//
//  MeliApp.swift
//  Meli
//
//  Created by Ronal Fabra Jimenez on 11/02/25.
//

import SwiftUI

@main
struct MeliApp: App {
    @StateObject private var toastManager = ToastManager()

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView(dependencyContainer: DIContainer.shared)
                ToastView()
            }
            .environmentObject(toastManager)
        }
    }
}
