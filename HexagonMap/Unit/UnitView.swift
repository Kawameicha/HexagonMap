//
//  UnitView.swift
//  HexagonMap
//
//  Created by Christoph Freier on 28.10.24.
//

import SwiftUI

struct UnitView: View {
    @Bindable var unit: Unit

    var body: some View {
        ZStack(alignment: .center) {
            pieceImage()
                .resizable()
                .scaleEffect(0.5, anchor: .center)

            VStack {
                ZStack(alignment: .top) {
                    UnitFacing(unit: unit)
                        .padding(-4)

                    HStack(alignment: .top) {
                        if let cost = unit.stats.turretUnit {
                            Text("\(cost)")
                                .background(Circle().fill(Color.white))
                                .frame(maxWidth: .infinity, alignment: .leading)
                        } else if let cost = unit.stats.costAttack, let indirect = unit.stats.indirectAttack {
                            VStack {
                                Text("\(cost)")
                                Text("(\(indirect))")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        } else if let cost = unit.stats.costAttack {
                            Text("\(cost)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }

                        Text(unit.name)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fontWeight(.regular)
                            .lineLimit(1)
                            .minimumScaleFactor(0.3)

                        if let cost = unit.stats.costMove {
                            Text("\(cost)")
                                .foregroundStyle(unit.type == .foot ? .red : .blue)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                }

                Spacer()

                GeometryReader { geometry in
                    HStack {
                        Button(action: rotateCounterClockwise) {
                            Image(systemName: "arrow.counterclockwise")
                                .frame(width: geometry.size.width * 0.05, alignment: .center)
                        }
                        .clipShape(Capsule())

                        Spacer()

                        Button {
                            unit.exhausted.toggle()
                        } label: {
                            Image(systemName: "play")
                                .symbolVariant(unit.exhausted ? .none : .slash)
                                .frame(width: geometry.size.width * 0.05, alignment: .center)
                        }
                        .clipShape(Capsule())

                        Spacer()

                        Button(action: rotateClockwise) {
                            Image(systemName: "arrow.clockwise")
                                .frame(width: geometry.size.width * 0.05, alignment: .center)
                        }
                        .clipShape(Capsule())
                    }
                    .background(
                        Rectangle()
                            .fill(.exhausted)
                            .opacity(unit.exhausted == true ? 0.7 : 0)
                    )
                    .padding(-4)
                }

                Spacer()

                ZStack(alignment: .bottom) {
                    UnitSymbol(unit: unit)
                        .scaleEffect(0.4, anchor: .bottom)

                    HStack(alignment: .bottom) {
                        VStack {
                            if let attack = unit.stats.attackSoft {
                                Text("\(attack)")
                                    .background(unit.stats.crewedUnit ?? false ? .white : .clear)
                                    .foregroundStyle(.red)
                            }
                            if let attack = unit.stats.attackArmored {
                                Text("\(attack)")
                                    .background(unit.stats.crewedUnit ?? false ? .white : .clear)
                                    .foregroundStyle(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)

                        if let minRange = unit.stats.minRange, let maxRange = unit.stats.maxRange {
                            Text("\(minRange)-\(maxRange)")
                                .foregroundStyle(.yellow)
                                .frame(maxWidth: .infinity, alignment: .center)
                        } else if let range = unit.stats.maxRange {
                            Text("\(range)")
                                .foregroundStyle(.yellow)
                                .frame(maxWidth: .infinity, alignment: .center)
                        }

                        VStack {
                            if let _ = unit.stats.openVehicle, let defense = unit.stats.defenseFlank {
                                Text("\(defense)")
                                    .background(.white)
                                    .background{Rectangle().stroke(Color.red)}
                            } else if let defense = unit.stats.defenseFlank {
                                Text("\(defense)")
                                    .foregroundStyle(.white)
                                    .background(unit.type == .foot ? .red : .blue)
                            }
                            if let defense = unit.stats.defenseFront {
                                Text("\(defense)")
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundStyle(unit.type == .foot ? .red : .blue)
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

    // Rotate clockwise by moving to the next orientation case
    func rotateClockwise() {
        unit.orientation = unit.orientation.next()
    }

    // Rotate counterclockwise by moving to the previous orientation case
    func rotateCounterClockwise() {
        unit.orientation = unit.orientation.previous()
    }

    // Helper to get rotation angle based on orientation
    func rotationAngle(for orientation: UnitFront) -> Angle {
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

extension UnitFront {
    // Method to get the next orientation, wrapping around if needed
    func next() -> UnitFront {
        switch self {
        case .N: return .NE
        case .NE: return .SE
        case .SE: return .S
        case .S: return .SW
        case .SW: return .NW
        case .NW: return .N
        }
    }

    // Method to get the previous orientation, wrapping around if needed
    func previous() -> UnitFront {
        switch self {
        case .N: return .NW
        case .NE: return .N
        case .SE: return .NE
        case .S: return .SE
        case .SW: return .S
        case .NW: return .SW
        }
    }
}

//#Preview {
//    UnitView(unit: Unit.mockGerman)
//}
