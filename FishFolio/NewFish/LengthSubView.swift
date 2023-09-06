//
//  LengthSubView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct LengthSubView: View {
    
    @Binding var lengthWhole: Int?
    @Binding var lengthDecimal: Int?
    
    var body: some View {
        VStack {
            Text("\(lengthWhole ?? 0).\(lengthDecimal ?? 0) inches")
                .font(.title)
                .bold()
            
            HStack(spacing: 0.0) {
                Picker("Whole", selection: $lengthWhole) {
                    ForEach(0..<100, id: \.self) { whole in
                        Text(whole, format: .number)
                            .tag(whole as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: lengthWhole) { newValue in
                    if newValue == 0 {
                        lengthWhole = nil
                    }
                }
                
                Text(".")
                
                Picker("Decimal", selection: $lengthDecimal) {
                    ForEach(0..<10, id: \.self) { decimal in
                        Text(decimal, format: .number)
                            .tag(decimal as Int?)
                    }
                }
                .tint(.secondary)
                .pickerStyle(.wheel)
                .onChange(of: lengthDecimal) { newValue in
                    if newValue == 0 {
                        lengthDecimal = nil
                    }
                }
            }
            Spacer()
        }
        
    }
}

struct LengthSubView_Previews: PreviewProvider {
    static var previews: some View {
        LengthSubView(lengthWhole: .constant(1), lengthDecimal: .constant(1))
    }
}
