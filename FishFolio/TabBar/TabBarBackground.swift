//
//  TabBarBackground.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct TabBarBackground: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let waveHeight: CGFloat = 15.0
        let radius: CGFloat = 20.0

        // Move to the starting point of the wave
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))

        // Calculate the number of waves based on the width of the rectangle
        let numberOfWaves = Int(rect.width / (waveHeight * 2))

        for i in 0..<numberOfWaves {
            // Calculate control points for the wave
            let startX = rect.minX + CGFloat(i) * waveHeight * 2
            let controlX1 = startX + waveHeight / 2
            let controlX2 = startX + waveHeight * 1.5
            let endX = startX + waveHeight * 2

            // Add a wave segment
            path.addCurve(
                to: CGPoint(x: endX, y: rect.minY),
                control1: CGPoint(x: controlX1, y: rect.minY + waveHeight / 2),
                control2: CGPoint(x: controlX2, y: rect.minY + waveHeight / 2)
            )
        }

        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.closeSubpath()

        return path
    }
}


struct TabBarBackground_Preview: PreviewProvider {
    static var previews: some View {
        TabBarBackground()
            .stroke(.red, lineWidth: 3)
            .frame(width: 200, height: 200)
   }
}
