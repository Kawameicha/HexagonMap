//
//  Unit.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import Foundation

struct Unit: Dragable {
    var name: String
    var costAttack: Int? = 0
    var costMove: Int? = 0
    var attackSoft: Int? = 0
    var attackArmored: Int? = 0
    var defenseFlank: Int? = 0
    var defenseFront: Int? = 0
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

extension Unit {
    static var mockUnit: Unit {
        Unit(name: "Rifles '41", costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, defenseFlank: 11, defenseFront: 12, type: .foot, color: .german, hexagon: HexagonCoordinate(row: 1, col: 1))
    }
}
