//
//  MainView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct MainView: View {
    @State private var tabSelection: TabBarItem = .catchs

    var body: some View {
        TabBarContainerView(selection: $tabSelection) {
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .frame(width: 200, height: 100)
                .tabBarItem(tab: .catchs, selection: $tabSelection)
            RoundedRectangle(cornerRadius: 10)
                .fill(.green)
                .frame(width: 200, height: 100)
                .tabBarItem(tab: .new, selection: $tabSelection)
            RoundedRectangle(cornerRadius: 10)
                .fill(.yellow)
                .frame(width: 200, height: 100)
                .tabBarItem(tab: .statistics, selection: $tabSelection)
            RoundedRectangle(cornerRadius: 10)
                .fill(.red)
                .frame(width: 200, height: 100)
                .tabBarItem(tab: .settings, selection: $tabSelection)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
