//
//  BoardViewModel.swift
//  HexagonMap
//
//  Created by Christoph Freier on 29.10.24.
//

import SwiftUI

class BoardViewModel: DropReceivableObservableObject {
    typealias DropReceivable = UnitHexagon
    @Published var unitHexagon: [UnitHexagon]
    @Published var pieceDidMoveFrom: Int? = nil

    func setDropArea(_ dropArea: CGRect, on dropReceiver: UnitHexagon) {
        hexagonBoard[dropReceiver.id].updateDropArea(with: dropArea)
    }

    // Assuming an 8x8 board, this method retrieves squares for each row
//    func getRowOfSquares(rowNumber: Int) -> [UnitHexagon] {
//        let startIndex = rowNumber * 8
//        let endIndex = startIndex + 8
//        return Array(hexagonBoard[startIndex..<endIndex])
//    }

    func setLegalDropTargets() {
        for index in 0..<unitHexagon.count {
            unitHexagon[index].legalDropTarget = getDropLegalState(at: index)
        }
    }

    private func getDropLegalState(at square: Int) -> DragState {
        if let origin = pieceDidMoveFrom,
           square != origin,
           let piece = unitHexagon[origin].unit
        {
            switch piece.type {
            case .foot:
                if [
                    origin + 1, origin - 1, origin + 8, origin - 8, origin + 9,
                    origin - 7,
                ].contains(square) {
                    return .accepted
                } else {
                    return .rejected
                }
            case .tracked:
                if ((square - origin) % 7 == 0) || ((square - origin) % 9 == 0)
                    || ((square - origin) % 8 == 0)
                    || (Int(origin / 8) == Int(square / 8))
                {
                    return .accepted
                } else {
                    return .rejected
                }
            case .wheeled:
                if ((square - origin) % 7 == 0) || ((square - origin) % 9 == 0)
                {
                    return .accepted
                } else {
                    return .rejected
                }
            }
            return .none
        }

        func movePiece(location: CGPoint) -> Bool {
            if let index = unitHexagon.firstIndex(where: {
                $0.getDropArea()!.contains(location)
            }),
               unitHexagon[index].legalDropTarget == .accepted,
               let movingPiece = unitHexagon[pieceDidMoveFrom!].unit
            {
                unitHexagon[index].unit = Unit(
                    type: movingPiece.type, color: movingPiece.color, hexagon: HexagonCoordinate(row: <#T##Int#>, col: <#T##Int#>))
                unitHexagon[pieceDidMoveFrom!].unit = nil
                clearPieceOrigin()
                setLegalDropTargets()
                return true
            }
            return false
        }

        func setPieceOrigin(_ square: Int) {
            if pieceDidMoveFrom == nil {
                pieceDidMoveFrom = square
            }
        }

        func clearPieceOrigin() {
            pieceDidMoveFrom = nil
        }

        // init()
    }
}
