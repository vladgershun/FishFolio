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
    @Namespace private var tabNamespace
    @State var localSelection: TabBarItem
    
    var body: some View {
        
        
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabBarItem(tab: tab)
                    .onTapGesture {
                        tabSwitch(tab: tab)
                    }
            }
        }
        .padding(12)
//        .background(TabBarBackground().fill(.secondary))
        .background(Color.secondary)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
        .onChange(of: selection) { newValue in
            withAnimation(.easeInOut) {
                localSelection = newValue
            }
        }
        
        
        
    }
}

extension TabBarView {
    private func tabBarItem(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundColor(localSelection == tab ? tab.color : Color.white)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "tab", in: tabNamespace)
                }
            }
        )
    }
    
    private func tabSwitch(tab: TabBarItem) {
        selection = tab
    }
}

struct TabBarView_Previews: PreviewProvider {
    static let tabs: [TabBarItem] = [
        .catchs, .settings, .new
    ]
    
    static var previews: some View {
        TabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
    }
}
