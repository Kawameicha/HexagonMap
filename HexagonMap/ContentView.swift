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

    let cells: [HexagonCell] = {
        var generatedCells: [HexagonCell] = []
        let columns = 17
        let evenColumnRows = 12
        let oddColumnRows = 11

        for column in 0..<columns {
            let rows = column.isMultiple(of: 2) ? evenColumnRows : oddColumnRows
            for row in 0..<rows {
                let cell = HexagonCell(
                    offsetCoordinate: HexagonCoordinate(row: row, col: column))
                generatedCells.append(cell)
            }
        }
        return generatedCells
    }()

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
            ZStack {
                Image("AtB_Planning_Map_1_Plains")
                    .resizable()
                    .scaledToFill()

                HexagonGrid(cells) { cell in
                    if let unitHexagon = model.unitHexagon[cell.offsetCoordinate] {
                        HexagonView(hexagon: unitHexagon)
                            .overlay(alignment: .top) {
                            }
                            .zIndex(model.pieceDidMoveFrom == cell.offsetCoordinate ? 1 : 0)
                            .onTapGesture {
                                model.selectHexagon(cell.offsetCoordinate)
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var model = HexagonViewModel()

    ContentView()
        .environmentObject(model)
}
