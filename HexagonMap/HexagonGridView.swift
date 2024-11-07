//
//  HexagonGridView.swift
//  HexagonMap
//
//  Created by Christoph Freier on 06.11.24.
//

import SwiftUI

struct HexagonGridView: View {
    @EnvironmentObject var model: HexagonViewModel
    let cells: [HexagonCell]

    var body: some View {
        ZStack {
            Image("AtB_Planning_Map_1_Plains")
                .resizable()
                .scaledToFit()

            HexagonGrid(cells) { cell in
                if let unitHexagon = model.unitHexagon[cell.offsetCoordinate] {
                    HexagonView(hexagon: unitHexagon)
                        .zIndex(model.pieceDidMoveFrom == cell.offsetCoordinate ? 1 : 0)
                        .onTapGesture {
                            model.selectHexagon(cell.offsetCoordinate)
                        }
                }
            }
        }
    }
}
