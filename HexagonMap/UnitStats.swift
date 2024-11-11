//
//  UnitStats.swift
//  HexagonMap
//
//  Created by Christoph Freier on 08.11.24.
//

import Foundation

struct UnitStats: Decodable {
    var name: String = ""
    var desc: String = ""
    var game: UnitGame? = .AtB
    var type: UnitType = .foot
    var army: UnitArmy = .german
    var costAttack: Int? = nil
    var indirectAttack: Int? = nil
    var turretUnit: Bool? = false
    var costMove: Int? = nil
    var moveBon1: UnitType? = nil
    var moveBon2: UnitType? = nil
    var defBonus: Int? = nil
    var attackSoft: Int? = nil
    var attackArmored: Int? = nil
    var attackSort: UnitAttack? = nil
    var crewedUnit: Bool? = false
    var minRange: Int? = nil
    var maxRange: Int? = nil
    var defenseFlank: Int? = nil
    var defenseFront: Int? = nil
    var openVehicle: Bool? = false

    var identifier: UnitIdentifier {
        return UnitIdentifier(name: name, army: army)
    }

    init(name: String = "", desc: String = "", game: UnitGame? = .AtB, type: UnitType = .foot, army: UnitArmy = .german, costAttack: Int? = nil, indirectAttack: Int? = nil, turretUnit: Bool? = false, costMove: Int? = nil, moveBon1: UnitType? = nil, moveBon2: UnitType? = nil, defBonus: Int? = nil, attackSoft: Int? = nil, attackArmored: Int? = nil, attackSort: UnitAttack? = nil, crewedUnit: Bool? = false, minRange: Int? = nil, maxRange: Int? = nil, defenseFlank: Int? = nil, defenseFront: Int? = nil, openVehicle: Bool? = false) {
        self.name = name
        self.desc = desc
        self.game = game
        self.type = type
        self.army = army
        self.costAttack = costAttack
        self.indirectAttack = indirectAttack
        self.turretUnit = turretUnit
        self.costMove = costMove
        self.moveBon1 = moveBon1
        self.moveBon2 = moveBon2
        self.defBonus = defBonus
        self.attackSoft = attackSoft
        self.attackArmored = attackArmored
        self.attackSort = attackSort
        self.crewedUnit = crewedUnit
        self.minRange = minRange
        self.maxRange = maxRange
        self.defenseFlank = defenseFlank
        self.defenseFront = defenseFront
        self.openVehicle = openVehicle
    }
}

@Observable
class Unit: Dragable {
    var name: String
    var game: UnitGame?
    var type: UnitType
    var army: UnitArmy
    var hexagon: HexagonCoordinate
    var orientation: UnitFront
    var exhausted: Bool
    var stats: UnitStats

    var identifier: UnitIdentifier {
        return UnitIdentifier(name: name, army: army)
    }

    init(name: String, type: UnitType, army: UnitArmy, hexagon: HexagonCoordinate = HexagonCoordinate(row: 0, col: 0), orientation: UnitFront = .N, exhausted: Bool = false, statsDictionary: [UnitIdentifier: UnitStats]) {
        self.name = name
        self.type = type
        self.army = army
        self.hexagon = hexagon
        self.orientation = orientation
        self.exhausted = exhausted

        let identifier = UnitIdentifier(name: name, army: army)
        self.stats = statsDictionary[identifier] ?? UnitStats(name: name, type: type, army: army)
        self.game = stats.game
    }
}

struct UnitIdentifier: Hashable {
    let name: String
    let army: UnitArmy
}

enum UnitGame: String, Decodable {
    case AtB = "Awakening the Bear"
    case SoS = "Storm of Steel"
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum UnitType: String, Decodable {
    case foot
    case tracked
    case wheeled
    case control
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum UnitArmy: String, Decodable {
    case german = "german"
    case soviet = "soviet"
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum UnitAttack: String, Decodable {
    case flamethrower, explosive
    var id: Self { self }
    var name: String { rawValue.capitalized }
}

enum UnitFront: String, Decodable {
    case N, NE, SE, S, SW, NW
}
