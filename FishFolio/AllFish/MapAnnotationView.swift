//
//  MapAnnotationView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/11/23.
//

import SwiftUI

struct MapAnnotationView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "fish.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .font(.headline)
                .foregroundColor(.white)
                .padding(6)
                .background(Color.accentColor)
                .cornerRadius(36)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(Color.accentColor)
                .frame(width: 10, height: 10)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3)
                .padding(.bottom, 40)
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView()
    }
}
