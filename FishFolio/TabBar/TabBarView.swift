//
//  TabBarView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct TabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabBarItem(tab: tab)
                    .onTapGesture {
                        tabSwitch(tab: tab)
                    }
            }
        }
        .padding(6)
        .background {
            TabBarBackground().fill(Material.thickMaterial)
                .edgesIgnoringSafeArea(.bottom)
                .shadow(color: Color.accentColor.opacity(0.3), radius: 5, x: 0, y: -3)
        }
    }
}

extension TabBarView {
    
    private func tabBarItem(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.title2)
            Text(tab.title)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
        }
        .foregroundColor(selection == tab ? Color.accentColor : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
    }
    
    private func tabSwitch(tab: TabBarItem) {
        selection = tab
    }
}

struct TabBarView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .fish, .settings, .new, .settings
    ]
    
    static var previews: some View {
        TabBarView(tabs: tabs, selection: .constant(tabs.first!))
    }
}
