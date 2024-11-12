//
//  UnitHexagon.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import SwiftUI

struct UnitHexagon: Identifiable, DropReceiver {
    let id: HexagonCoordinate
    var dropArea: CGRect? = nil

    var units: [Unit] = []
    var legalDropTarget: DragState = .none

    mutating func addUnit(_ unit: Unit) {
        units.append(unit)
    }
}
