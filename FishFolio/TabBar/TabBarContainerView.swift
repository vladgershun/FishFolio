//
//  TabBarContainerView.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/5/23.
//

import SwiftUI

struct TabBarContainerView<Content: View>: View {
    
    @Binding var selection: TabBarItem
    let content: Content
    @State private var tabs: [TabBarItem] = []
    
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .frame(maxHeight: .infinity)
            TabBarView(tabs: tabs, selection: $selection)
            
        }
        .onPreferenceChange(TabBarItemPreferenceKey.self) { newValue in
            self.tabs = newValue
        }
    }
}

struct TabBarContainerView_Previews: PreviewProvider {
    
    static let tabs: [TabBarItem] = [
        .fish, .settings, .new, .settings
    ]

    static var previews: some View {
        TabBarContainerView(selection: .constant(tabs.first!)) {
            Color.red
        }
    }
}