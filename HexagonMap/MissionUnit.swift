//
//  MissionUnit.swift
//  HexagonMap
//
//  Created by Christoph Freier on 10.11.24.
//

struct MissionUnit: Decodable {
    let name: String
    let type: UnitType
    let army: UnitArmy
    let hexagon: HexagonCoordinate
    let orientation: UnitFront

    init(name: String, type: UnitType, army: UnitArmy, hexagon: HexagonCoordinate, orientation: UnitFront) {
        self.name = name
        self.type = type
        self.army = army
        self.hexagon = hexagon
        self.orientation = orientation
    }
}

