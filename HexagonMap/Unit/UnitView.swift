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
        ZStack(alignment: .center) {
            pieceImage()
                .resizable()
                .scaledToFit()
                .padding(10)

            VStack {
                HStack(alignment: .top) {
                    ZStack(alignment: .top) {
                        if let cost = unit.costAttack {
                            Text("\(cost)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Spacer()

                        if let cost = unit.costMove {
                            Text("\(cost)")
                                .foregroundStyle(unit.type == .foot ? .red : .blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }

                        GeometryReader { geometry in
                            HStack {
                                Spacer()
                                UnitFacing(unit: unit)
                                    .padding(-4)
                                    .frame(width: geometry.size.width * 0.6, alignment: .center)
                                Spacer()
                            }

                            Text(unit.name)
                                .font(.system(size: 8))
                                .fontWeight(.regular)
                                .frame(width: geometry.size.width, alignment: .center)
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }

                Spacer()

                HStack(alignment: .bottom) {
                    ZStack(alignment: .bottom) {
                        VStack {
                            if let attack = unit.attackSoft {
                                Text("\(attack)")
                                    .foregroundStyle(.red)
                            }
                            if let attack = unit.attackArmored {
                                Text("\(attack)")
                                    .foregroundStyle(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

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
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(unit.type == .foot ? .red : .blue)

                        GeometryReader { geometry in
                            HStack {
                                Spacer()
                                VStack {
                                    Spacer()
                                    UnitSymbol(unit: unit)
                                        .frame(width: geometry.size.width * 0.2, alignment: .center)
                                }
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(4)
            .fontWeight(.bold)
            .foregroundStyle(.black)
        }
        .aspectRatio(1.0, contentMode: .fit)
        .background(RoundedRectangle(cornerRadius: 9, style: .continuous)
            .fill(Color("\(unit.army)")))
        .rotationEffect(rotationAngle(for: unit.orientation))
    }

    func rotationAngle(for orientation: Unit.UnitOrientation) -> Angle {
        switch orientation {
        case .N: return .degrees(0)
        case .NE: return .degrees(60)
        case .SE: return .degrees(120)
        case .S: return .degrees(180)
        case .SW: return .degrees(240)
        case .NW: return .degrees(300)
        }
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
    UnitView(unit: Unit.mockGerman)
}
