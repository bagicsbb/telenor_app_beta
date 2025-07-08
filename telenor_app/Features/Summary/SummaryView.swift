//
//  SummaryView.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

struct SummaryView: View {
    @ObservedObject var viewModel: SummaryViewModel
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: .zero) {
            ScrollView {
                VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                    headerView
                    vehicleInfoSection
                    Divider()
                    vignetteListSection
                    Divider()
                    totalSection
                }
                .padding()
            }

            Spacer()
            buttonSection
        }
        .navigationTitle(Strings.Summary.navTitle)
        .navigationBarTitleDisplayMode(.inline)
        .overlay(loadingOverlay)
        .onAppear {
            viewModel.onFinished = {
                isLoading = false
            }
        }
    }
}

private extension SummaryView {
    var headerView: some View {
        Text(Strings.Summary.header)
            .font(.title2.bold())
            .padding(.top)
    }

    var vehicleInfoSection: some View {
        VStack(spacing: Constants.smallSpacing) {
            HStack {
                Text(Strings.Summary.plate)
                    .foregroundColor(.gray)
                Spacer()
                Text(viewModel.plateNumber.uppercased())
            }

            HStack {
                Text(Strings.Summary.stickerType)
                    .foregroundColor(.gray)
                Spacer()
                Text(viewModel.vignetteTypeLabel)
            }
        }
        .padding(.bottom, Constants.smallSpacing)
    }

    var vignetteListSection: some View {
        VStack(spacing: Constants.smallSpacing) {
            ForEach(viewModel.vignettes) { item in
                HStack {
                    Text(item.name).bold()
                    Spacer()
                    Text("\(Int(item.price)) \(Strings.Common.currency)")
                }
            }
        }
    }

    var totalSection: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(Strings.Common.totalLabel)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }

            Text("\(Int(viewModel.totalPrice)) \(Strings.Common.currency)")
                .font(.largeTitle.bold())
        }
    }

    var buttonSection: some View {
        VStack(spacing: Constants.buttonSpacing) {
            Button(action: {
                isLoading = true
                viewModel.confirmPurchase()
            }) {
                Text(Strings.Common.purchase)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isLoading ? Color.gray : Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(Constants.buttonCornerRadius)
            }
            .disabled(isLoading)

            Button(action: {
                viewModel.popToRoot()
            }) {
                Text(Strings.Common.cancel)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.black)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.buttonCornerRadius)
                            .stroke(Color.black)
                    )
            }
            .disabled(isLoading)
        }
        .padding(Constants.buttonPadding)
        .background(Color(.systemBackground))
    }

    var loadingOverlay: some View {
        Group {
            if isLoading {
                ZStack {
                    Color.black.opacity(0.2).ignoresSafeArea()
                    ProgressView(Strings.Summary.processing)
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(Constants.cornerRadius)
                }
            }
        }
    }
}

private extension SummaryView {
    enum Constants {
        static let verticalSpacing: CGFloat = 16
        static let smallSpacing: CGFloat = 8
        static let buttonSpacing: CGFloat = 12
        static let buttonPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 24
    }
}
