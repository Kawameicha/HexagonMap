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
        ZStack {
            VStack {
                HStack {
                    if let cost = unit.costAttack {
                        Text("\(cost)")
                    }
                    Spacer()
                    Text(unit.name)
                        .font(.caption)
                    Spacer()
                    if let cost = unit.costMove {
                        Text("\(cost)")
                            .foregroundStyle(unit.type == .foot ? .red : .blue)
                    }
                }
                .fontWeight(.bold)
                .foregroundStyle(.black)
                Spacer()
                HStack {
                    VStack {
                        if let attack = unit.attackSoft {
                            Text("\(attack)")
                                .foregroundStyle(.red)
                        }
                        if let value = unit.attackArmored {
                            Text("\(value)")
                                .foregroundStyle(.blue)
                        }
                    }
                    .fontWeight(.bold)
                    Spacer()
                        VStack {
                            if let defense = unit.defenseFlank {
                                Text("\(defense)")
                                    .foregroundStyle(.white)
                                    .background(unit.type == .foot ? .red : .blue)
                            }
                            if let defense = unit.defenseFront {
                                Text("\(defense)")
                            }
                        }
                        .fontWeight(.bold)
                        .foregroundStyle(unit.type == .foot ? .red : .blue)
                }
            }

            pieceImage()
                .resizable()
                .scaledToFit()
                .padding()
        }
        .background(RoundedRectangle(cornerRadius: 9, style: .continuous)
            .fill(Color("\(unit.color)")))
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
    UnitView(unit: Unit.mockUnit)
}
