//
//  MainView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var tabSelection: TabBarItem = .fish

    var body: some View {
        TabBarContainerView(selection: $tabSelection) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: 200, height: 100)
                .tabBarItem(tab: .fish, selection: $tabSelection)
            NewFishView()
                .tabBarItem(tab: .new, selection: $tabSelection)
            StatisticsView()
                .tabBarItem(tab: .statistics, selection: $tabSelection)
            SettingsView()
                .tabBarItem(tab: .settings, selection: $tabSelection)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
