//
//  HexagonViewModel.swift
//  HexagonMap
//
//  Created by Christoph Freier on 29.10.24.
//

import SwiftUI

class HexagonViewModel: DropReceivableObservableObject {
    @Published var unitHexagon: [HexagonCoordinate: UnitHexagon] = [:]
    @Published var pieceDidMoveFrom: HexagonCoordinate? = nil
    @Published var selectedHexagon: HexagonCoordinate?

    init(mission: Mission) {
        unitHexagon = setupInitialUnits(for: mission)
    }

    func selectHexagon(_ coordinate: HexagonCoordinate) {
            selectedHexagon = coordinate
        }

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
        case .control:
            let nearbyPositions = [
                HexagonCoordinate(row: origin.row, col: origin.col)
            ]
            return nearbyPositions.contains(hexagon) ? .accepted : .rejected
        }
    }

    func movePiece(location: CGPoint) -> Bool {
        if let destinationCoordinate = unitHexagon.first(where: {
            $0.value.dropArea?.contains(location) == true
        })?.key,
            unitHexagon[destinationCoordinate]?.legalDropTarget == .accepted,
            let movingPiece = unitHexagon[pieceDidMoveFrom!]?.unit
        {

            let statsDictionary = loadUnitStatsFromFile()
            unitHexagon[destinationCoordinate]?.unit = Unit(
                name: movingPiece.name,
                type: movingPiece.type,
                army: movingPiece.army,
                hexagon: destinationCoordinate,
                orientation: movingPiece.orientation,
                exhausted: movingPiece.exhausted,
                statsDictionary: statsDictionary
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
}
