//
//  NavigationService.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI
import Combine

enum NavigationDestination {
    case login
    case staff
}

class NavigationService: ObservableObject {
    @Published var path = NavigationPath()
    
    func backToRoot() {
        path.removeLast(path.count)
    }
}
