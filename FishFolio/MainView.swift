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
        //        TabBarContainerView(selection: $tabSelection) {
        //            AllFishView()
        //                .tabBarItem(tab: .fish, selection: $tabSelection)
        //            NewFishView()
        //                .tabBarItem(tab: .new, selection: $tabSelection)
        //            StatisticsView()
        //                .tabBarItem(tab: .statistics, selection: $tabSelection)
        //            SettingsView()
        //                .tabBarItem(tab: .settings, selection: $tabSelection)
        //        }
        TabView(selection: $tabSelection) {
            AllFishView()
                .tabItem {
                    Label(TabBarItem.fish.title, systemImage: TabBarItem.fish.iconName)
                }
                .tag(TabBarItem.fish)
            NewFishView()
                .tabItem {
                    Label(TabBarItem.new.title, systemImage: TabBarItem.new.iconName)
                }
                .tag(TabBarItem.new)
            StatisticsView()
                .tabItem {
                    Label(TabBarItem.statistics.title, systemImage: TabBarItem.statistics.iconName)
                }
                .tag(TabBarItem.statistics)
            SettingsView()
                .tabItem {
                    Label(TabBarItem.settings.title, systemImage: TabBarItem.settings.iconName)
                }
                .tag(TabBarItem.settings)
        }
        .selectedTab(tabSelection)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
