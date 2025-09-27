//
//  StaffView.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI

struct StaffView: View {
    @ObservedObject var viewModel: StaffViewModel
    
    var body: some View {
        Text("Token: \(viewModel.token)")
    }
}
