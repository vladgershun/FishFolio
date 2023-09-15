//
//  TabSelection.swift
//  FishFolio
//
//  Created by Vlad Gershun on 9/14/23.
//

import SwiftUI

extension View {
    func onTabAppear(_ tab: some Hashable, perform action: @escaping () -> ()) -> some View {
        self.modifier(OnTabAppearModifier(thisTab: tab, action: action))
    }
    func tabTask(_ tab: some Hashable, perform action: @escaping () async -> ()) -> some View {
        self.modifier(TabTaskModifier(thisTab: tab, action: action))
    }
    func selectedTab(_ tab: some Hashable) -> some View {
        self.environment(\.selectedTab, AnyHashable(tab))
    }
}
private struct OnTabAppearModifier: ViewModifier {
    var thisTab: AnyHashable?
    var action: () -> ()
    @Environment(\.selectedTab) private var selectedTab: AnyHashable?
    
    func body(content: Content) -> some View {
        content.onChange(of: selectedTab) { newValue in
            if newValue == thisTab {
                action()
            }
        }
    }
}
private struct TabTaskModifier: ViewModifier {
    var thisTab: AnyHashable?
    var action: () async -> ()
    @State private var task: Task<Void, Never>? = nil
    @Environment(\.selectedTab) private var selectedTab: AnyHashable?
    
    func body(content: Content) -> some View {
        content
            .task(id: selectedTab) {
                if selectedTab == thisTab {
                    await action()
                }
            }
    }
}
enum SelectedTabKey: EnvironmentKey {
    static var defaultValue: AnyHashable? = nil
}
extension EnvironmentValues {
    fileprivate var selectedTab: AnyHashable? {
        get { self[SelectedTabKey.self] }
        set { self[SelectedTabKey.self] = newValue }
    }
}
