//
//  LoginView.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel
    @State private var navigateToStaff = false

    init(sessionManager: SessionManager) {
        _viewModel = StateObject(wrappedValue: LoginViewModel(session: sessionManager))
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer().frame(height: 50)

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

                Button {
                    viewModel.login()
                } label: {
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
                .disabled(viewModel.isLoading)

                Spacer()
            }
            .padding()
            .alert(
                "Error",
                isPresented: Binding(
                    get: { viewModel.errorMessage != nil },
                    set: { _ in viewModel.errorMessage = nil }
                )
            ) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage ?? "")
            }
            .onChange(of: viewModel.session.isLoggedIn) { _, loggedIn in
                navigateToStaff = loggedIn
            }
            .onAppear {
                navigateToStaff = false
            }
            .navigationDestination(isPresented: $navigateToStaff) {
                StaffView(viewModel: StaffViewModel())
             }
        }
    }
}
