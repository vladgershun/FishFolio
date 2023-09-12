//
//  DetailVM.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/12/23.
//

import MapKit
import Foundation

@MainActor
class DetailVM: ObservableObject {
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    func editFish(_ fish: UIFish) { }
    func deleteFish(_ fish: UIFish) { }
}
