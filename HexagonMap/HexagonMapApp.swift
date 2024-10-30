//
//  HexagonMapApp.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import SwiftUI

@main
struct HexagonMapApp: App {
    @StateObject private var model = HexagonViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
