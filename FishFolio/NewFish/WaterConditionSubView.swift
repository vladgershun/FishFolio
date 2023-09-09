//
//  WaterConditionSubView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct WaterConditionSubView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var waterCondition: WaterCondition?
    
    var body: some View {
        Form {
            Picker("Select Water Condition", selection: $waterCondition) {
                Text("None")
                    .tag(nil as WaterCondition?)
                ForEach(WaterCondition.allCases) { waterCondition in
                    Text(waterCondition.description)
                        .tag(waterCondition as WaterCondition?)
                }
            }
            .tint(.secondary)
            .pickerStyle(.inline)
            .onChange(of: waterCondition) { _ in
                dismiss()
            }
        }
        .toolbar {
            Button("Clear") { waterCondition = nil }
        }
    }
}

struct WaterConditionSubView_Previews: PreviewProvider {
    static var previews: some View {
        WaterConditionSubView(waterCondition: .constant(.algae))
    }
}
