//
//  CountySelectionView.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

struct CountySelectionView: View {
    @ObservedObject var viewModel: CountySelectionViewModel
    @State private var showContiguityAlert = false

    var body: some View {
        ScrollView {
            VStack(spacing: Constants.verticalSpacing) {
                header
                map
                countyList
                summarySection
            }
            .padding(.horizontal)
        }
        .background(Color.white.ignoresSafeArea())
        .onChange(of: viewModel.contiguityWarning) { _, newValue in
            if newValue != nil {
                showContiguityAlert = true
            }
        }
        .alert(Strings.CountySelection.alertTitle, isPresented: $showContiguityAlert) {
            Button(Strings.Common.confirm, role: .cancel) {}
        } message: {
            Text(viewModel.contiguityWarning ?? "")
        }
    }
}

private extension CountySelectionView {
    var header: some View {
        Text(Strings.Common.countyYearlyTitle)
            .font(.title3.bold())
            .padding(.top, Constants.headerTopPadding)
            .padding(.bottom, Constants.headerBottomPadding)
    }

    var map: some View {
        HungaryMapView(
            selectedIds: viewModel.selectedCountyIds,
            onTap: { viewModel.toggleCountyById($0) }
        )
        .aspectRatio(CountyMap.canvasSize, contentMode: .fit)
        .frame(maxWidth: .infinity)
    }

    var countyList: some View {
        VStack(spacing: Constants.listItemSpacing) {
            ForEach(viewModel.counties) { county in
                Button(action: {
                    viewModel.toggleCounty(county)
                }) {
                    HStack {
                        Image(systemName: viewModel.isSelected(county) ? "checkmark.square.fill" : "square")
                            .foregroundColor(viewModel.isSelected(county) ? .black : .gray)

                        Text(county.name)
                            .foregroundColor(.primary)

                        Spacer()

                        Text("\(Int(viewModel.yearlyCountyPrice)) \(Strings.Common.currency)")
                            .font(.subheadline.bold())
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 6)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(Constants.cornerRadius)
                }
                .buttonStyle(.plain)
            }
        }
    }

    var summarySection: some View {
        VStack(spacing: Constants.smallSpacing) {
            HStack {
                Text(Strings.Common.totalLabel)
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }

            HStack {
                Text("\(Int(viewModel.totalPrice)) \(Strings.Common.currency)")
                    .font(.title2.bold())
                Spacer()
            }

            Button(action: {
                viewModel.proceedToNextStep()
            }) {
                Text(Strings.CountySelection.continueButton)
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.totalPrice > 0 ? Color.black : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(Constants.buttonCornerRadius)
            }
            .disabled(viewModel.totalPrice == 0)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.cornerRadius)
    }
}

private extension CountySelectionView {
    enum Constants {
        static let verticalSpacing: CGFloat = 20
        static let smallSpacing: CGFloat = 8
        static let listItemSpacing: CGFloat = 6
        static let cornerRadius: CGFloat = 12
        static let buttonCornerRadius: CGFloat = 24
        static let headerTopPadding: CGFloat = 12
        static let headerBottomPadding: CGFloat = 8
    }
}
