////
////  Unit.swift
////  HexagonMap
////
////  Created by Christoph Freier on 28.10.24.
////
//
//import SwiftUI
//
//@Observable
//class Unit: Dragable {
//    var name: String
//    var suit: UnitSuit? = nil
//    var rank: Int? = nil
//    var game: UnitGame? = .AtB
//    var type: UnitType
//    var army: UnitArmy
//    var hexagon: HexagonCoordinate
//    var orientation: UnitFront
//    var exhausted: Bool
//    var costAttack: Int? = nil
//    var indirectAttack: Int? = nil
//    var turretUnit: Bool? = false
//    var costMove: Int? = nil
//    var moveBon1: UnitType? = nil
//    var moveBon2: UnitType? = nil
//    var defBonus: Int? = nil
//    var attackSoft: Int? = nil
//    var attackArmored: Int? = nil
//    var attackSort: UnitAttack? = nil
//    var crewedUnit: Bool? = false
//    var minRange: Int? = nil
//    var maxRange: Int? = nil
//    var defenseFlank: Int? = nil
//    var defenseFront: Int? = nil
//    var openVehicle: Bool? = false
//
//    enum UnitSuit: String {
//        case diamond, club, heart, spade
//        var id: Self { self }
//        var name: String { rawValue.capitalized }
//    }
//
//    enum UnitAttack: String {
//        case flamethrower, explosive
//        var id: Self { self }
//        var name: String { rawValue.capitalized }
//    }
//
//    enum UnitGame: String {
//        case AtB = "Awakening the Bear"
//        case SoS = "Storm of Steel"
//        var id: Self { self }
//        var name: String { rawValue.capitalized }
//    }
//
//    enum UnitArmy: String {
//        case german = "German"
//        case soviet = "Soviet"
//        var id: Self { self }
//        var name: String { rawValue.capitalized }
//    }
//
//    enum UnitFront {
//        case N, NE, SE, S, SW, NW
//    }
//
//    enum UnitType: String {
//        case foot
//        case tracked
//        case wheeled
//        var id: Self { self }
//        var name: String { rawValue.capitalized }
//    }
//
//    init(name: String, suit: UnitSuit? = nil, rank: Int? = nil, game: UnitGame? = nil, type: UnitType, army: UnitArmy, hexagon: HexagonCoordinate, orientation: UnitFront, exhausted: Bool = false, costAttack: Int? = nil, indirectAttack: Int? = nil, turretUnit: Bool? = nil, costMove: Int? = nil, moveBon1: UnitType? = nil, moveBon2: UnitType? = nil, defBonus: Int? = nil, attackSoft: Int? = nil, attackArmored: Int? = nil, attackSort: UnitAttack? = nil, crewedUnit: Bool? = nil, minRange: Int? = nil, maxRange: Int? = nil, defenseFlank: Int? = nil, defenseFront: Int? = nil, openVehicle: Bool? = nil) {
//        self.name = name
//        self.suit = suit
//        self.rank = rank
//        self.game = game
//        self.type = type
//        self.army = army
//        self.hexagon = hexagon
//        self.orientation = orientation
//        self.exhausted = exhausted
//        self.costAttack = costAttack
//        self.indirectAttack = indirectAttack
//        self.turretUnit = turretUnit
//        self.costMove = costMove
//        self.moveBon1 = moveBon1
//        self.moveBon2 = moveBon2
//        self.defBonus = defBonus
//        self.attackSoft = attackSoft
//        self.attackArmored = attackArmored
//        self.attackSort = attackSort
//        self.crewedUnit = crewedUnit
//        self.minRange = minRange
//        self.maxRange = maxRange
//        self.defenseFlank = defenseFlank
//        self.defenseFront = defenseFront
//        self.openVehicle = openVehicle
//    }
//}
//
//extension Unit {
//    static var mockGerman: Unit {
//        Unit(name: "Rifles '41", type: .foot, army: .german, hexagon: HexagonCoordinate(row: 1, col: 1), orientation: .N, costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, maxRange: 5, defenseFlank: 11, defenseFront: 12)
//    }
//    static var mockRussian: Unit {
//        Unit(name: "Rifles '41", type: .foot, army: .soviet, hexagon: HexagonCoordinate(row: 1, col: 1), orientation: .N, costAttack: 3, costMove: 1, attackSoft: 2, attackArmored: 0, maxRange: 5, defenseFlank: 11, defenseFront: 12)
//    }
//}
