//
//  WeightSubView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct WeightSubView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var weightWhole: Int?
    @Binding var weightDecimal: Int?
    
    var body: some View {
        VStack {
            Text("\(weightWhole ?? 0).\(weightDecimal ?? 0) pounds")
                .font(.title)
                .bold()
            
            HStack(spacing: 0.0) {
                Picker("Whole", selection: $weightWhole) {
                    ForEach(0..<100, id: \.self) { whole in
                        Text(whole, format: .number)
                            .tag(whole as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: weightWhole) { newValue in
                    if newValue == 0 {
                        weightWhole = nil
                    }
                }
                
                Text(".")
                
                Picker("Decimal", selection: $weightDecimal) {
                    ForEach(0..<10, id: \.self) { decimal in
                        Text(decimal, format: .number)
                            .tag(decimal as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: weightDecimal) { newValue in
                    if newValue == 0 {
                        weightDecimal = nil
                    }
                }
            }
            
            Button("CLEAR") {
                withAnimation(.easeInOut) {
                    weightWhole = 0
                    weightDecimal = 0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
            
            Spacer()
        }   
    }
}

struct WeightSubView_Previews: PreviewProvider {
    static var previews: some View {
        WeightSubView(weightWhole: .constant(1), weightDecimal: .constant(1))
    }
}
