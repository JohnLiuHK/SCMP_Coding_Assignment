//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                    .frame(height: 50)

                Text("Login")
                    .font(.largeTitle)
                    .bold()

                TextField("Email", text: $viewModel.email)
                    .padding()
                    .frame(height: 50)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)

                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .frame(height: 50)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                    .keyboardType(.emailAddress)

                Button(
                    action: {

                    },
                    label: {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text("Login")
                                .bold()
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                )
                .disabled(viewModel.isLoading)

                Spacer()
            }
        }
        .padding()
    }
}
