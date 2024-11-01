//
//  HexagonViewModel.swift
//  HexagonMap
//
//  Created by Christoph Freier on 29.10.24.
//

import SwiftUI

class HexagonViewModel: DropReceivableObservableObject {
    typealias DropReceivable = UnitHexagon
    @Published var unitHexagon: [HexagonCoordinate: UnitHexagon] = [:]
    @Published var pieceDidMoveFrom: HexagonCoordinate? = nil

    func setDropArea(_ dropArea: CGRect, on dropReceiver: UnitHexagon) {
        unitHexagon[dropReceiver.id]?.updateDropArea(with: dropArea)
    }

    func setLegalDropTargets() {
        for coordinate in unitHexagon.keys {
            unitHexagon[coordinate]?.legalDropTarget = getDropLegalState(
                at: coordinate)
        }
    }

    private func getDropLegalState(at hexagon: HexagonCoordinate) -> DragState {
        guard let origin = pieceDidMoveFrom,
            hexagon != origin,
            let unit = unitHexagon[origin]?.unit
        else {
            return .none
        }

        switch unit.type {
        case .foot, .tracked, .wheeled:
            if origin.col.isMultiple(of: 2) {
                let nearbyPositions = [
                    HexagonCoordinate(row: origin.row - 1, col: origin.col - 1),
                    HexagonCoordinate(row: origin.row, col: origin.col - 1),
                    HexagonCoordinate(row: origin.row - 1, col: origin.col),
                    HexagonCoordinate(row: origin.row + 1, col: origin.col),
                    HexagonCoordinate(row: origin.row - 1, col: origin.col + 1),
                    HexagonCoordinate(row: origin.row, col: origin.col + 1),
                ]
                return nearbyPositions.contains(hexagon) ? .accepted : .rejected
            } else {
                let nearbyPositions = [
                    HexagonCoordinate(row: origin.row, col: origin.col - 1),
                    HexagonCoordinate(row: origin.row + 1, col: origin.col - 1),
                    HexagonCoordinate(row: origin.row - 1, col: origin.col),
                    HexagonCoordinate(row: origin.row + 1, col: origin.col),
                    HexagonCoordinate(row: origin.row, col: origin.col + 1),
                    HexagonCoordinate(row: origin.row + 1, col: origin.col + 1),
                ]
                return nearbyPositions.contains(hexagon) ? .accepted : .rejected
            }
        }
    }

    func movePiece(location: CGPoint) -> Bool {
        if let destinationCoordinate = unitHexagon.first(where: {
            $0.value.dropArea?.contains(location) == true
        })?.key,
            unitHexagon[destinationCoordinate]?.legalDropTarget == .accepted,
            let movingPiece = unitHexagon[pieceDidMoveFrom!]?.unit
        {

            unitHexagon[destinationCoordinate]?.unit = Unit(
                name: movingPiece.name,
                costAttack: movingPiece.costAttack,
                costMove: movingPiece.costMove,
                attackSoft: movingPiece.attackSoft,
                attackArmored: movingPiece.attackArmored,
                defenseFlank: movingPiece.defenseFlank,
                defenseFront: movingPiece.defenseFront,
                type: movingPiece.type,
                color: movingPiece.color,
                hexagon: destinationCoordinate
            )
            unitHexagon[pieceDidMoveFrom!]?.unit = nil
            clearPieceOrigin()
            setLegalDropTargets()
            return true
        }
        return false
    }

    func setPieceOrigin(_ hexagon: HexagonCoordinate) {
        if pieceDidMoveFrom == nil {
            pieceDidMoveFrom = hexagon
        }
    }

    func clearPieceOrigin() {
        pieceDidMoveFrom = nil
    }

    init() {
        let initialFootCoordinate = HexagonCoordinate(row: 3, col: 3)
        let initialFootUnit = Unit(name: "Rifles '41", costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, defenseFlank: 11, defenseFront: 12, type: .foot, color: .german, hexagon: initialFootCoordinate)
        let initialTrackedCoordinate = HexagonCoordinate(row: 9, col: 9)
        let initialTrackedUnit = Unit(name: "T-34a", costAttack: 5, costMove: 1, attackSoft: 5, attackArmored: 7, defenseFlank: 15, defenseFront: 19, type: .tracked, color: .russian, hexagon: initialTrackedCoordinate)

        let columns = 17
        let evenColumnRows = 12
        let oddColumnRows = 11

        for column in 0..<columns {
            let rows = column.isMultiple(of: 2) ? evenColumnRows : oddColumnRows
            for row in 0..<rows {
                let coordinate = HexagonCoordinate(row: row, col: column)
                if coordinate == initialFootCoordinate {
                    unitHexagon[coordinate] = UnitHexagon(
                        id: coordinate, dropArea: nil, unit: initialFootUnit)
                } else if coordinate == initialTrackedCoordinate {
                    unitHexagon[coordinate] = UnitHexagon(
                        id: coordinate, dropArea: nil, unit: initialTrackedUnit)
                } else {
                    unitHexagon[coordinate] = UnitHexagon(
                        id: coordinate, dropArea: nil, unit: nil)
                }
            }
        }
    }
}
