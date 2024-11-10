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

func loadMissionUnits(from filename: String) -> [MissionUnit] {
    guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
          let data = try? Data(contentsOf: url) else {
        print("Error: Unable to load file \(filename).json")
        return []
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode([MissionUnit].self, from: data)
    } catch {
        print("Error decoding JSON data: \(error)")
        return []
    }
}

func setupInitialUnits(for mission: Mission) -> [HexagonCoordinate: UnitHexagon] {
    let statsDictionary = loadUnitStatsFromFile()
    var unitHexagon: [HexagonCoordinate: UnitHexagon] = [:]
    let columns = 17
    let evenColumnRows = 12
    let oddColumnRows = 11

    // Load mission units from JSON file
    let missionUnits = loadMissionUnits(from: "\(mission)")

    // Create units based on JSON data
    for missionUnit in missionUnits {
        let coordinate = missionUnit.hexagon
        let unit = Unit(
            name: missionUnit.name,
            type: missionUnit.type,
            army: missionUnit.army,
            hexagon: coordinate,
            orientation: missionUnit.orientation,
            statsDictionary: statsDictionary
        )
        unitHexagon[coordinate] = UnitHexagon(id: coordinate, dropArea: nil, unit: unit)
    }

    // Fill in remaining hexagons with empty UnitHexagon instances
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
