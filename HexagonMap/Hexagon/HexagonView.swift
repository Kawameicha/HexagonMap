//
//  HexagonView.swift
//  HexagonMap
//
//  Created by Christoph Freier on 29.10.24.
//

import SwiftUI

struct HexagonView: View {
    @EnvironmentObject var model: HexagonViewModel
    let hexagon: UnitHexagon

    var body: some View {
        ZStack {
            Hexagon()
                .overlay(
                    Hexagon()
                        .fill(
                            Color.green.opacity(
                                hexagon.legalDropTarget == .accepted ? 0.3 : 0))
                )
                .dropReceiver(
                    for: model.unitHexagon[hexagon.id]
                        ?? UnitHexagon(id: HexagonCoordinate(row: 0, col: 0)),
                    model: model)
            Hexagon()
                .overlay(
                    Hexagon()
                        .stroke(Color.green, lineWidth: 4)
                )
                .opacity(hexagon.legalDropTarget == .accepted ? 1 : 0)
            switch hexagon.unit {
            case .none:
                EmptyView()
            case .some(let unit):
                UnitView(unit: unit)
                    .dragable(
                        object: unit,
                        onDragObject: onDragPiece,
                        onDropped: onDropPiece)
            }
        }
        .scaledToFit()
    }

    func onDragPiece(piece: Dragable, position: CGPoint) -> DragState {
        if model.pieceDidMoveFrom == nil {
            model.setPieceOrigin((piece as! Unit).hexagon)
            model.setLegalDropTargets()
        }
        return .none
    }

    func onDropPiece(position: CGPoint) -> Bool {
        if model.movePiece(location: position) {
            return true
        } else {
            model.clearPieceOrigin()
            model.setLegalDropTargets()
            return false
        }
    }
}

#Preview {
    @Previewable @StateObject var model = HexagonViewModel()
    let hexagon = UnitHexagon(
        id: HexagonCoordinate(row: 0, col: 0), dropArea: nil,
        unit: Unit(
            type: .foot, color: .german,
            hexagon: HexagonCoordinate(row: 0, col: 0)))

    HexagonView(hexagon: hexagon)
        .environmentObject(model)
}
