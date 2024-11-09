//
//  SetupInitialUnits.swift
//  HexagonMap
//
//  Created by Christoph Freier on 06.11.24.
//

import Foundation

enum Mission {
    case mission1
    case mission2
    // Add more missions as needed
}

func setupInitialUnits(for mission: Mission) -> [HexagonCoordinate: UnitHexagon] {
    let statsDictionary = loadUnitStatsFromFile()
    var unitHexagon: [HexagonCoordinate: UnitHexagon] = [:]
    let columns = 17
    let evenColumnRows = 12
    let oddColumnRows = 11

    // Mission-specific unit setup
    switch mission {
    case .mission1:
        let initialGermanCoordinate = HexagonCoordinate(row: 3, col: 3)
        let initialFootUnit = Unit(name: "Pioneers", type: .foot, army: .german, hexagon: initialGermanCoordinate, orientation: .SE, statsDictionary: statsDictionary)
        unitHexagon[initialGermanCoordinate] = UnitHexagon(id: initialGermanCoordinate, dropArea: nil, unit: initialFootUnit)

        let initialRussianCoordinate = HexagonCoordinate(row: 9, col: 9)
        let initialTrackedUnit = Unit(name: "MMG Maxim", type: .foot, army: .soviet, hexagon: initialRussianCoordinate, orientation: .N, statsDictionary: statsDictionary)
        unitHexagon[initialRussianCoordinate] = UnitHexagon(id: initialRussianCoordinate, dropArea: nil, unit: initialTrackedUnit)

    case .mission2:
        let initialGermanCoordinate = HexagonCoordinate(row: 3, col: 3)
        let initialFootUnit = Unit(name: "Rifles '41", type: .foot, army: .german, hexagon: initialGermanCoordinate, orientation: .SE, statsDictionary: statsDictionary)
        unitHexagon[initialGermanCoordinate] = UnitHexagon(id: initialGermanCoordinate, dropArea: nil, unit: initialFootUnit)

        let initialRussianCoordinate = HexagonCoordinate(row: 9, col: 9)
        let initialTrackedUnit = Unit(name: "Rifles '41", type: .foot, army: .soviet, hexagon: initialRussianCoordinate, orientation: .N, statsDictionary: statsDictionary)
        unitHexagon[initialRussianCoordinate] = UnitHexagon(id: initialRussianCoordinate, dropArea: nil, unit: initialTrackedUnit)
    }

    // Fill remaining hexagons
    for column in 0..<columns {
        let rows = column.isMultiple(of: 2) ? evenColumnRows : oddColumnRows
        for row in 0..<rows {
            let coordinate = HexagonCoordinate(row: row, col: column)
            if unitHexagon[coordinate] == nil {
                unitHexagon[coordinate] = UnitHexagon(id: coordinate, dropArea: nil, unit: nil)
            }
        }
    }

    return unitHexagon
}
