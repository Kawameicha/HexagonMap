//
//  UnitSymbol.swift
//  HexagonMap
//
//  Created by Christoph Freier on 01.11.24.
//

import SwiftUI

struct UnitSymbol: View {
    let unit: Unit

    var body: some View {
        ZStack {
            switch unit.color {
            case .german:
                CrossShape(width: 8.5)
                    .foregroundColor(.black)

                CrossShape(width: 7.5)
                    .foregroundColor(.white)

                CrossShape(width: 5.0)
                    .foregroundColor(.black)

                if let range = unit.range {
                    Text("\(range)")
                        .font(.system(size: 10))
                        .foregroundColor(.yellow)
                }
            case .russian:
                StarShape()
                    .fill(Color.red)

                if let range = unit.range {
                    Text("\(range)")
                        .font(.system(size: 10))
                        .foregroundColor(.yellow)
                }
            }
        }
        .aspectRatio(1.0, contentMode: .fit)
    }
}

struct CrossShape: Shape {
    var width: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let verticalRect = CGRect(
            x: rect.midX - width / 2,
            y: rect.minY,
            width: width,
            height: rect.height
        )
        path.addRect(verticalRect)

        let horizontalRect = CGRect(
            x: rect.minX,
            y: rect.midY - width / 2,
            width: rect.width,
            height: width
        )
        path.addRect(horizontalRect)

        return path
    }
}

struct StarShape: Shape {
    let corners: Int = 5
    let smoothness: Double = 0.5

    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() }
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        var currentAngle = -CGFloat.pi / 2
        let angleAdjustment = .pi * 2 / Double(corners * 2)
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness
        var path = Path()
        path.move(
            to: CGPoint(
                x: center.x * cos(currentAngle), y: center.y * sin(currentAngle)
            ))
        var bottomEdge: Double = 0

        for corner in 0..<corners * 2 {
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: Double

            if corner.isMultiple(of: 2) {
                bottom = center.y * sinAngle
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom))
            } else {
                bottom = innerY * sinAngle
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom))
            }
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            currentAngle += angleAdjustment
        }

        let unusedSpace = (rect.height / 2 - bottomEdge) / 2
        let transform = CGAffineTransform(
            translationX: center.x, y: center.y + unusedSpace)

        return path.applying(transform)
    }
}

#Preview {
    HStack {
        UnitSymbol(unit: Unit.mockGerman)
        UnitSymbol(unit: Unit.mockRussian)
    }
    .aspectRatio(1.0, contentMode: .fit)
    .frame(width: 50, height: 50)
}
