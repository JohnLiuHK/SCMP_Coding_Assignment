//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var navigationService: NavigationService
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack(path: $navigationService.path) {
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
                        viewModel.login()
                    },
                    label: {
                        if viewModel.isLoading {
                            VStack(spacing: 20) {
                                Text("Logging in...")
                                ProgressView()
                            }
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
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .staff:
                    StaffView(viewModel: StaffViewModel(token: viewModel.token ?? ""))
                case .login:
                    LoginView()
                }
            }
        }
        .padding()
        .alert(
            "Error", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .onChange(of: viewModel.isLoggedIn) { oldValue, newValue in
            print("isLoggedIn!");
            navigationService.path.append(NavigationDestination.staff)
        }
    }
}
