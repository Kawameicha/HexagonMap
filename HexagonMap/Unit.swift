//
//  Unit.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import Foundation

struct Unit: Dragable {
    var type: PieceType
    var color: PieceColor
    var hexagon: HexagonCoordinate

    enum PieceType {
        case foot
        case tracked
        case wheeled
    }

    enum PieceColor {
        case german
        case russian
    }
}
