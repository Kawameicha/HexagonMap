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
                        Text(" \(cost)")
                    }
                    Spacer()
                    Text(unit.name)
                        .font(.system(size: 6))
                    Spacer()
                    if let cost = unit.costMove {
                        Text("\(cost) ")
                            .foregroundStyle(unit.type == .foot ? .red : .blue)
                    }
                }
                .fontWeight(.bold)
                .foregroundStyle(.black)
                Spacer()
                HStack(alignment: .bottom) {
                    VStack {
                        if let attack = unit.attackSoft {
                            Text("\(attack) ")
                                .foregroundStyle(.red)
                        }
                        if let attack = unit.attackArmored {
                            Text("\(attack) ")
                                .foregroundStyle(.blue)
                        }
                    }
                    .frame(width: 15)
                    .fontWeight(.bold)
                    Spacer()
                    UnitSymbol(unit: unit)
                        .frame(width: 20)
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
                        .frame(width: 20)
                        .fontWeight(.bold)
                        .foregroundStyle(unit.type == .foot ? .red : .blue)
                }
            }

            pieceImage()
                .resizable()
                .scaledToFit()
                .padding()
        }
        .aspectRatio(1.0, contentMode: .fit)
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
