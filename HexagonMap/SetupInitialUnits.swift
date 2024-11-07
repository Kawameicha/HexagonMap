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
    var unitHexagon: [HexagonCoordinate: UnitHexagon] = [:]
    let columns = 17
    let evenColumnRows = 12
    let oddColumnRows = 11

    // Mission-specific unit setup
    switch mission {
    case .mission1:
        let initialFootCoordinate = HexagonCoordinate(row: 3, col: 3)
        let initialFootUnit = Unit(
            name: "Rifles '41", type: .foot, army: .german,
            hexagon: initialFootCoordinate, orientation: .N, costAttack: 3, costMove: 1,
            attackSoft: 2, attackArmored: 0, maxRange: 5, defenseFlank: 11, defenseFront: 12
        )
        unitHexagon[initialFootCoordinate] = UnitHexagon(id: initialFootCoordinate, dropArea: nil, unit: initialFootUnit)

        let initialTrackedCoordinate = HexagonCoordinate(row: 9, col: 9)
        let initialTrackedUnit = Unit(
            name: "T-34a", type: .tracked, army: .soviet,
            hexagon: initialTrackedCoordinate, orientation: .N, costAttack: 5, costMove: 1,
            attackSoft: 5, attackArmored: 7, maxRange: 8, defenseFlank: 15, defenseFront: 19
        )
        unitHexagon[initialTrackedCoordinate] = UnitHexagon(id: initialTrackedCoordinate, dropArea: nil, unit: initialTrackedUnit)

    case .mission2:
        let specialUnitCoordinate = HexagonCoordinate(row: 4, col: 4)
        let specialUnit = Unit(
            name: "Special Ops", type: .foot, army: .german,
            hexagon: specialUnitCoordinate, orientation: .S, costAttack: 4, costMove: 2,
            attackSoft: 3, attackArmored: 1, maxRange: 6, defenseFlank: 12, defenseFront: 14
        )
        unitHexagon[specialUnitCoordinate] = UnitHexagon(id: specialUnitCoordinate, dropArea: nil, unit: specialUnit)

        let tankUnitCoordinate = HexagonCoordinate(row: 10, col: 10)
        let tankUnit = Unit(
            name: "Panzer IV", type: .tracked, army: .german,
            hexagon: tankUnitCoordinate, orientation: .N, costAttack: 6, costMove: 1,
            attackSoft: 4, attackArmored: 8, maxRange: 7, defenseFlank: 16, defenseFront: 20
        )
        unitHexagon[tankUnitCoordinate] = UnitHexagon(id: tankUnitCoordinate, dropArea: nil, unit: tankUnit)
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
