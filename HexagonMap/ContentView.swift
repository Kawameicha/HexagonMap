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
    var colorName = Color(.white)
}

struct ContentView: View {
    let cells: [HexagonCell] = {
        var generatedCells: [HexagonCell] = []
        let columns = 17
        let evenColumnRows = 12
        let oddColumnRows = 11

        for column in 0..<columns {
            let rows = column.isMultiple(of: 2) ? evenColumnRows : oddColumnRows
            for row in 0..<rows {
                let cell = HexagonCell(offsetCoordinate: HexagonCoordinate(row: row, col: column))
                generatedCells.append(cell)
            }
        }
        return generatedCells
    }()

    var body: some View {
        HexagonGrid(cells) { cell in
            cell.colorName
                .frame(width: 50, height: 50)
                .overlay(Text("(\(cell.offsetCoordinate.row), \(cell.offsetCoordinate.col))")
                            .font(.caption)
                            .foregroundColor(.black))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
