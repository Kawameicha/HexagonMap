//
//  Unit.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import Foundation

struct Unit: Dragable {
    var name: String
    var orientation: UnitOrientation
    var costAttack: Int? = nil
    var costMove: Int? = nil
    var attackSoft: Int? = nil
    var attackArmored: Int? = nil
    var range: Int? = nil
    var defenseFlank: Int? = nil
    var defenseFront: Int? = nil
    var type: UnitType
    var army: UnitArmy
    var hexagon: HexagonCoordinate

    enum UnitOrientation {
        case N, NE, SE, S, SW, NW
    }

    enum UnitType {
        case foot
        case tracked
        case wheeled
    }

    enum UnitArmy {
        case de
        case ru
    }
}

extension Unit {
    static var mockGerman: Unit {
        Unit(name: "Rifles '41", orientation: .N,  costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, range: 5, defenseFlank: 11, defenseFront: 12, type: .foot, army: .de, hexagon: HexagonCoordinate(row: 1, col: 1))
    }
    static var mockRussian: Unit {
        Unit(name: "Rifles '41", orientation: .N,  costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, range: 5, defenseFlank: 11, defenseFront: 12, type: .foot, army: .ru, hexagon: HexagonCoordinate(row: 1, col: 1))
    }
}
