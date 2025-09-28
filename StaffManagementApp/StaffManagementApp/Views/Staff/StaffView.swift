//
//  StaffView.swift
//  StaffManagementApp
//
//  Created by John Liu on 27/9/2025.
//
import SwiftUI

struct StaffView: View {
    @StateObject var viewModel: StaffViewModel

    var body: some View {
        List {
            if viewModel.staffList.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else {
                ForEach(viewModel.staffList) { staff in
                    // Staff Item
                    HStack {
                        AsyncImage(url: URL(string: staff.avatar)) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text("\(staff.first_name) \(staff.last_name)").bold()
                            Text(staff.email).font(.caption)
                        }
                    }
                    .onAppear {
                        viewModel.fetchNextPageIfNeeded(currentItem: staff)
                    }
                }
            }
            
            // Load More Indicator
            if viewModel.isLoading && viewModel.currentPage < viewModel.totalPages {
                HStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    Text("Loading more...")
                        .foregroundColor(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
        .task {
            viewModel.fetchStaffList()
        }
        .navigationTitle("Staff List")
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}
