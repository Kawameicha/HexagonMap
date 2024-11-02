//
//  Unit.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import Foundation

struct Unit: Dragable {
    var name: String
    var orientation: PieceOrientation
    var costAttack: Int? = 0
    var costMove: Int? = 0
    var attackSoft: Int? = 0
    var attackArmored: Int? = 0
    var range: Int? = 0
    var defenseFlank: Int? = 0
    var defenseFront: Int? = 0
    var type: PieceType
    var color: PieceColor
    var hexagon: HexagonCoordinate

    enum PieceOrientation{
        case N, NE, SE, S, SW, NW
    }

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

extension Unit {
    static var mockGerman: Unit {
        Unit(name: "Rifles '41", orientation: .N,  costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, range: 5, defenseFlank: 11, defenseFront: 12, type: .foot, color: .german, hexagon: HexagonCoordinate(row: 1, col: 1))
    }
    static var mockRussian: Unit {
        Unit(name: "Rifles '41", orientation: .N,  costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, range: 5, defenseFlank: 11, defenseFront: 12, type: .foot, color: .russian, hexagon: HexagonCoordinate(row: 1, col: 1))
    }
}
