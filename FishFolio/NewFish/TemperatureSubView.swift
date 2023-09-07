//
//  TemperatureSubView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/6/23.
//

import SwiftUI

struct TemperatureSubView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var waterTemperature: Int?
    
    var body: some View {
        VStack {
            if let waterTemperature {
                Text("\(waterTemperature)°F")
                    .font(.title)
                    .bold()
            } else {
                Text("-- °F")
                    .font(.title)
                    .bold()
            }
            
            Picker("Water Temperature", selection: $waterTemperature) {
                Text("--")
                    .tag(nil as Int?)
                ForEach(32..<100, id: \.self) { waterTemperature in
                    Text("\(waterTemperature) °F")
                        .tag(waterTemperature as Int?)
                }
            }
            .tint(.secondary)
            .pickerStyle(.wheel)
            .onChange(of: waterTemperature) { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
            
            Button("CLEAR") {
                withAnimation(.easeInOut) {
                    waterTemperature = nil
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    dismiss()
                }
            }
            
            Spacer()
        }
    }
}

struct TemperatureSubView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureSubView(waterTemperature: .constant(1))
    }
}
