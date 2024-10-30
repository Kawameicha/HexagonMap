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

func rowToLetter(row: Int) -> String {
    guard row > 0, row <= 26 else { return "?" }
    return String(UnicodeScalar(64 + row)!)
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
        HexagonGrid(cells) { cell in
            if let unitHexagon = model.unitHexagon[cell.offsetCoordinate] {
                HexagonView(hexagon: unitHexagon)
                    .frame(width: 33, height: 33)
                    .overlay(alignment: .top) {
                        if unitHexagon.unit == nil {
                            Text(
                                "\(rowToLetter(row: cell.offsetCoordinate.row + 1))\(cell.offsetCoordinate.col + 1)"
                            )
                            .font(.system(size: 6))
                            .foregroundColor(.black)
                            .offset(y: 3)
                        }
                    }
                    .zIndex(
                        model.pieceDidMoveFrom == cell.offsetCoordinate ? 1 : 0)
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var model = HexagonViewModel()

    ContentView()
        .environmentObject(model)
}
