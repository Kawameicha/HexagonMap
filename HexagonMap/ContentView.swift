//
//  ContentView.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import SwiftUI

struct HexagonCell: Identifiable, OffsetCoordinateProviding {
    var id: Int { offsetCoordinate.hashValue }
    var offsetCoordinate: HexagonCoordinate
    var colorName = Color(.clear)
}

struct ContentView: View {
    @EnvironmentObject var model: HexagonViewModel
    let cells = hexagonGridGenerator()

    var body: some View {
        NavigationSplitView {
            if let selectedCoordinate = model.selectedHexagon,
               let unit = model.unitHexagon[selectedCoordinate]?.unit {
                VStack(alignment: .leading) {
                    UnitView(unit: unit)

                    Spacer()

                    Text("Coordinate: \(selectedCoordinate)")
                    Text("Unit: \(unit.name)")
                    // Add other unit properties here
                }
                .padding()
            } else {
                Text("Select a hexagon to see details")
                    .foregroundColor(.gray)
                    .padding()
            }
        } detail: {
            HexagonGridView(cells: cells)
        }
    }
}

#Preview {
    @Previewable @StateObject var model = HexagonViewModel(mission: .mission1)

    ContentView()
        .environmentObject(model)
}
