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
        GeometryReader { geometry in
            ZStack {
                Hexagon()
                    .stroke(Color.black, lineWidth: 0)
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
                    .stroke(Color.black, lineWidth: 0)
                    .overlay(
                        Hexagon()
                            .stroke(Color.green, lineWidth: 4)
                    )
                    .opacity(hexagon.legalDropTarget == .accepted ? 1 : 0)

                if let unit = hexagon.unit {
                    UnitView(unit: unit)
                        .frame(width: geometry.size.width * 0.7,
                               height: geometry.size.height * 0.7)
                        .dragable(
                            object: unit,
                            onDragObject: onDragPiece,
                            onDropped: onDropPiece)
                }
            }
        }
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
    let hexagon = UnitHexagon(id: HexagonCoordinate(row: 0, col: 0), dropArea: nil, unit: Unit.mockGerman)

    HexagonView(hexagon: hexagon)
        .environmentObject(model)
}
