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
        let radius: CGFloat = 20.0
        let centerRadius: CGFloat = 30
//        let wavesLength = rect.width - 2 * radius

        // Move to the starting point of the wave
        path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))

        path.addWaveLine(to: CGPoint(x: rect.midX - centerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.minY), radius: centerRadius, startAngle: .degrees(-180), endAngle: .degrees(0), clockwise: true)
        path.addWaveLine(to: CGPoint(x: rect.maxX - centerRadius, y: rect.minY))


        path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
        path.addArc(center: CGPoint(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
        path.addArc(center: CGPoint(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)

        return path
    }
}

extension Path {
    mutating func addWaveLine(to: CGPoint) {
        let waveHeight: CGFloat = 10.0
        let minX = (self.currentPoint?.x ?? 0)
        let minY = (self.currentPoint?.y ?? 0)
        let width = to.x - minX // TODO: Handle negative?
        let wavesLength = width

        // Calculate the number of waves based on the width of the rectangle
        let numberOfWaves = Int(wavesLength / (waveHeight * 2))
        let lengthOfWave = wavesLength / Double(numberOfWaves)

        for i in 0..<numberOfWaves {
            // Calculate control points for the wave
            let startX = minX + CGFloat(i) * lengthOfWave
            let controlX1 = startX + waveHeight / 2
            let controlX2 = startX + waveHeight * 1.5
            let endX = startX + waveHeight * 2

            // Add a wave segment
            addCurve(
                to: CGPoint(x: endX, y: minY),
                control1: CGPoint(x: controlX1, y: minY + waveHeight / 2),
                control2: CGPoint(x: controlX2, y: minY + waveHeight / 2)
            )
        }
    }
}


struct TabBarBackground_Preview: PreviewProvider {
    
    static var previews: some View {
        TabBarBackground()
            .stroke(.red, lineWidth: 3)
            .frame(width: 200, height: 200)
   }
}
