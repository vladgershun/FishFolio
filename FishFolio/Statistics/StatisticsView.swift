//
//  StatisticsView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import Charts
import SwiftUI

struct TestData: Identifiable {
    var id = UUID()
    var month: String
    var totalCaught: Int
}

struct StatisticsView: View {
    
    let data = [
        TestData(month: "June", totalCaught: 3),
        TestData(month: "July", totalCaught: 13),
        TestData(month: "August", totalCaught: 5)
    ]
    
    var body: some View {
        VStack {
            Chart {
                ForEach(data) { shape in
                    BarMark(
                        x: .value("Shape Type", shape.month),
                        y: .value("Total Count", shape.totalCaught)
                    )
                }
            }
            .chartXAxisLabel("Month")
            .chartYAxisLabel("Caught")
            .padding()
        }
        .frame(maxHeight: 300)
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
