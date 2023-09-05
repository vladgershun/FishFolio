//
//  MainView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct MainView: View {
    @State private var selection = "Home"
    @State private var tabSelection: TabBarItem = .catchs

    var body: some View {
        TabBarContainerView(selection: $tabSelection) {
            Color.blue
                .tabBarItem(tab: .catchs, selection: $tabSelection)
            Color.green
                .tabBarItem(tab: .new, selection: $tabSelection)
            Color.yellow
                .tabBarItem(tab: .statistics, selection: $tabSelection)
            Color.red
                .tabBarItem(tab: .settings, selection: $tabSelection)
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
