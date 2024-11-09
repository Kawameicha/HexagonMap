//
//  UnitStats.swift
//  HexagonMap
//
//  Created by Christoph Freier on 08.11.24.
//

import Foundation

struct UnitStats: Decodable {
    var name: String
    var desc: String
    var game: Unit.UnitGame?
    var type: Unit.UnitType
    var army: Unit.UnitArmy
    var costAttack: Int?
    var indirectAttack: Int?
    var turretUnit: Bool?
    var costMove: Int?
    var moveBon1: Unit.UnitType?
    var moveBon2: Unit.UnitType?
    var defBonus: Int?
    var attackSoft: Int?
    var attackArmored: Int?
    var attackSort: Unit.UnitAttack?
    var crewedUnit: Bool?
    var minRange: Int?
    var maxRange: Int?
    var defenseFlank: Int?
    var defenseFront: Int?
    var openVehicle: Bool?

    init(name: String, desc: String, game: Unit.UnitGame? = .AtB, type: Unit.UnitType, army: Unit.UnitArmy, costAttack: Int? = nil, indirectAttack: Int? = nil, turretUnit: Bool? = false, costMove: Int? = nil, moveBon1: Unit.UnitType? = nil, moveBon2: Unit.UnitType? = nil, defBonus: Int? = nil, attackSoft: Int? = nil, attackArmored: Int? = nil, attackSort: Unit.UnitAttack? = nil, crewedUnit: Bool? = false, minRange: Int? = nil, maxRange: Int? = nil, defenseFlank: Int? = nil, defenseFront: Int? = nil, openVehicle: Bool? = false) {
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
    var stats: UnitStats?

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

    enum UnitFront {
        case N, NE, SE, S, SW, NW
    }

    init(name: String, type: Unit.UnitType, army: Unit.UnitArmy, hexagon: HexagonCoordinate = HexagonCoordinate(row: 0, col: 0), orientation: UnitFront = .N, exhausted: Bool = false, statsDictionary: [UnitIdentifier: UnitStats]) {
        self.name = name
        self.type = type
        self.army = army
        self.hexagon = hexagon
        self.orientation = orientation
        self.exhausted = exhausted

        let identifier = UnitIdentifier(name: name, army: army)
        if let unitStats = statsDictionary[identifier] {
            self.stats = unitStats
            self.game = unitStats.game
        }
    }
}

func loadUnitStats(from data: Data) -> [UnitIdentifier: UnitStats] {
    do {
        let statsArray = try JSONDecoder().decode([UnitStats].self, from: data)
        let statsDictionary = Dictionary(uniqueKeysWithValues: statsArray.map { ($0.identifier, $0) })

        return statsDictionary
    } catch {
        print("Error decoding UnitStats: \(error)")
        return [:]
    }
}

func loadUnitStatsFromFile() -> [UnitIdentifier: UnitStats] {
    guard let fileURL = Bundle.main.url(forResource: "UnitStats", withExtension: "json") else {
        print("UnitStats.json file not found")
        return [:]
    }

    do {
        let data = try Data(contentsOf: fileURL)
        return loadUnitStats(from: data)
    } catch {
        print("Error loading UnitStats.json: \(error)")
        return [:]
    }
}

struct UnitIdentifier: Hashable {
    let name: String
    let army: Unit.UnitArmy
}

extension UnitStats {
    var identifier: UnitIdentifier {
        return UnitIdentifier(name: name, army: army)
    }
}
