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
//            .blending(color: Color(unit.color == .german ? .red : .black))
    }
    
    func pieceImage() -> Image {
        switch unit.type {
        case .foot:
            return Image("chess-pawn")
        case .tracked:
            return Image("chess-pawn")
        case .wheeled:
            return Image("chess-pawn")
        }
    }
}

#Preview {
    UnitView(unit: Unit(type: .foot, color: .german, hexagon: HexagonCoordinate(row: 0, col: 0)))
}
