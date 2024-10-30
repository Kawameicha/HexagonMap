//
//  UnitView.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import SwiftUI

struct UnitView: View {
    let unit: Unit

    var body: some View {
        pieceImage()
            .resizable()
            .scaledToFit()
    }

    func pieceImage() -> Image {
        switch unit.type {
        case .foot:
            return Image("foot")
        case .tracked:
            return Image("tracked")
        case .wheeled:
            return Image("wheeled")
        }
    }
}

#Preview {
    UnitView(unit: Unit(type: .foot, color: .german, hexagon: HexagonCoordinate(row: 0, col: 0)))
}
