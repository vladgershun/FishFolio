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
    var date: Date
    var totalCaught: Int
}

struct StatisticsView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("weightUnits") private var weightUnits: WeightUnits = .pounds
    
    let data = [
        TestData(date: Calendar.current.date(byAdding: .month, value: 1, to: .now)!, totalCaught: 3),
        TestData(date: Calendar.current.date(byAdding: .month, value: 2, to: .now)!, totalCaught: 13),
        TestData(date: Calendar.current.date(byAdding: .month, value: 3, to: .now)!, totalCaught: 31),
        TestData(date: Calendar.current.date(byAdding: .month, value: 4, to: .now)!, totalCaught: 23),
        TestData(date: Calendar.current.date(byAdding: .month, value: 5, to: .now)!, totalCaught: 55),
        TestData(date: Calendar.current.date(byAdding: .month, value: 6, to: .now)!, totalCaught: 0),
        TestData(date: Calendar.current.date(byAdding: .month, value: 7, to: .now)!, totalCaught: 51),
        TestData(date: Calendar.current.date(byAdding: .month, value: 8, to: .now)!, totalCaught: 15),
        TestData(date: Calendar.current.date(byAdding: .month, value: 9, to: .now)!, totalCaught: 55),
        TestData(date: Calendar.current.date(byAdding: .month, value: 10, to: .now)!, totalCaught: 0),
        TestData(date: Calendar.current.date(byAdding: .month, value: 11, to: .now)!, totalCaught: 51),
        TestData(date: Calendar.current.date(byAdding: .month, value: 12, to: .now)!, totalCaught: 15)
    ]
    
    var body: some View {
        NavigationView {
            Form {
                GroupBox {
                    Chart {
                        ForEach(data) { shape in
                            BarMark(
                                x: .value("Shape Type", shape.date, unit: .month),
                                y: .value("Total Count", shape.totalCaught)
                            )
                            .foregroundStyle(.orange)
                            .annotation(position: .top, alignment: .top, spacing: 3) {
                                Text(shape.totalCaught, format: .number)
                                    .font(.footnote)
                            }
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .stride(by: .month)) { _ in
                            AxisValueLabel(format: .dateTime.month(), centered: true)
                        }
                    }
                } label: {
                    VStack(alignment: .leading) {
                        Text("Total Caught")
                        Text("132")
                            .font(.headline)
                            .foregroundColor(.orange)
                    }
                }
                .backgroundStyle(colorScheme == .light ? .white : .clear)
                .listRowInsets(EdgeInsets())
                
                
                Section("More Stats") {
                    HStack {
                        Text("Largest Fish")
                        Spacer()
                        Text(Measurement(value: 56, unit: UnitLength.inches), format: .measurement(width: .abbreviated))
                            .foregroundColor(.orange)
                    }
                    HStack {
                        Text("Heaviest Fish (\(self.weightUnits.rawValue))")
                        Spacer()
//                        Text(Measurement(value: 34, unit: UnitMass.pounds).converted(to: self.weightUnits.unit).formatted(.measurement(width: .abbreviated, usage: .asProvided)))
//                        Text(Measurement(value: 34, unit: UnitMass.pounds).converted(to: self.weightUnits.unit), format: .measurement(width: .abbreviated, usage: .asProvided))
                        Text(Measurement(value: 34, unit: UnitMass.pounds), format: .customMeasurement(unit: weightUnits))
                            .foregroundColor(.orange)
                    }
                    
                }
                Section("Most Frequent") {
                    HStack {
                        Text("Species")
                        Spacer()
                        Text("Trout")
                            .foregroundColor(.orange)
                    }
                    HStack {
                        Text("Bait")
                        Spacer()
                        Text("Eggs")
                            .foregroundColor(.orange)
                    }
                    HStack {
                        Text("Location")
                        Spacer()
                        Text("Klineline")
                            .foregroundColor(.orange)
                    }
                }
            }
            .navigationTitle("Statistics")
        }
        .navigationViewStyle(.stack)
    }
}

struct CustomMeasurmentFormat<U: UnitConvertible>: FormatStyle {
    var base: Measurement<U.U>.FormatStyle
    var unit: U
    
    func format(_ value: Measurement<U.U>) -> String {
        value.converted(to: unit.unit).formatted(base)
    }
}
extension FormatStyle {
    static func customMeasurement<U: UnitConvertible>(unit: U) -> CustomMeasurmentFormat<U> where Self == CustomMeasurmentFormat<U> {
        CustomMeasurmentFormat(base: .init(width: .abbreviated, locale: .current, usage: .asProvided, numberFormatStyle: .number), unit: unit)
    }
}
protocol UnitConvertible: Codable, Hashable {
    associatedtype U: Dimension
    
    var unit: U { get }
}

extension WeightUnits: UnitConvertible {
    var unit: UnitMass {
        switch self {
        case .pounds:
            return .pounds
        case .kilograms:
            return .kilograms
        }
    }
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
