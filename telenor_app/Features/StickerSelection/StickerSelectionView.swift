//
//  StickerSelectionView.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

struct StickerSelectionView: View {
    @StateObject var viewModel: StickerSelectionViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Constants.verticalSpacing) {
                
                if let vehicle = viewModel.vehicleInfo {
                    VStack {
                        vehicleHeader(vehicle)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(Constants.cornerRadius)
                }

                VStack(spacing: Constants.sectionSpacing) {
                    nationalVignetteSection
                    purchaseButton
                }
                .padding()
                .background(Color.white)
                .cornerRadius(Constants.cornerRadius)

                countySelectionSection

                Spacer()
            }
            .padding()
        }
        .background(Color(.systemGray6))
        .navigationTitle(Strings.StickerSelection.title)
    }
}

private extension StickerSelectionView {
    @ViewBuilder
    func vehicleHeader(_ vehicle: VehicleInfo) -> some View {
        VStack {
            HStack(spacing: Constants.iconSpacing) {
                Image(systemName: vehicleIcon(for: vehicle.type))
                    .resizable()
                    .frame(width: Constants.iconSize, height: Constants.iconSize)
                    .foregroundColor(.primary)

                VStack(alignment: .leading, spacing: 4) {
                    Text(vehicle.plate.uppercased())
                        .font(.title3.bold())
                        .foregroundColor(.primary)

                    Text(vehicle.name)
                        .foregroundColor(.gray)
                }

                Spacer()
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(Constants.cornerRadius)
    }

    var nationalVignetteSection: some View {
        VStack(alignment: .leading, spacing: Constants.sectionSpacing) {
            Text(Strings.StickerSelection.national)
                .font(.headline)

            nationalVignetteButtons()
        }
    }

    var purchaseButton: some View {
        Button(action: {
            viewModel.proceedToSummary()
        }) {
            Text(Strings.Common.purchase)
                .bold()
                .frame(maxWidth: .infinity)
                .padding()
                .background(viewModel.canProceed ? Color.black : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(Constants.cornerRadius)
        }
        .disabled(!viewModel.canProceed)
    }

    var countySelectionSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Strings.Common.countyYearlyTitle)
                .font(.headline)

            Button(action: {
                viewModel.proceedToCountySelection()
            }) {
                HStack {
                    Text(Strings.StickerSelection.countySelect)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: Constants.chevronIcon)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(Constants.cornerRadius)
            }
        }
    }

    func localizedDuration(for vignette: HighwayVignette) -> String {
        switch vignette.type {
        case .day:
            return Strings.Common.Period.daily
        case .week:
            return Strings.Common.Period.weekly
        case .month:
            return Strings.Common.Period.monthly
        case .year:
            return Strings.Common.Period.yearly
        }
    }

    func categoryLabel(for vignette: HighwayVignette) -> String {
        viewModel.vignetteCategory(for: vignette)
    }

    func vehicleIcon(for type: String) -> String {
        switch type.uppercased() {
        case "CAR": return "car.fill"
        case "MOTORCYCLE": return "scooter"
        case "TRUCK": return "truck.box.fill"
        case "BUS": return "bus.fill"
        default: return "car.fill"
        }
    }

    @ViewBuilder
    func nationalVignetteButtons() -> some View {
        ForEach(viewModel.availableNationalVignettes, id: \.self) { vignette in
            Button(action: {
                viewModel.selectNationalVignette(vignette)
            }) {
                HStack(spacing: Constants.iconSpacing) {
                    ZStack {
                        Circle()
                            .stroke(viewModel.isNationalVignetteSelected(vignette) ? Constants.primaryColor : Color.gray.opacity(0.5), lineWidth: 2)
                            .frame(width: 24, height: 24)

                        if viewModel.isNationalVignetteSelected(vignette) {
                            Circle()
                                .fill(Color.black)
                                .frame(width: 12, height: 12)
                        }
                    }

                    VStack(alignment: .leading) {
                        Text("\(categoryLabel(for: vignette)) - \(localizedDuration(for: vignette))")
                            .fontWeight(.semibold)
                    }

                    Spacer()

                    Text("\(Int(vignette.price)) \(Strings.Common.currency)")
                        .fontWeight(.bold)
                }
                .padding()
                .background(roundedBackground(vignette: vignette))
            }
            .buttonStyle(.plain)
        }
    }

    @ViewBuilder
    func roundedBackground(vignette: HighwayVignette) -> some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .stroke(viewModel.isNationalVignetteSelected(vignette) ? Constants.primaryColor : Color.gray.opacity(0.2), lineWidth: 1)
            .background(
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(viewModel.isNationalVignetteSelected(vignette) ? Constants.primaryColor.opacity(0.05) : Color.white)
            )
    }
}

private extension StickerSelectionView {
    enum Constants {
        static let chevronIcon = "chevron.right"

        static let iconSize: CGFloat = 32
        static let iconSpacing: CGFloat = 12
        static let sectionSpacing: CGFloat = 16
        static let verticalSpacing: CGFloat = 24
        static let cornerRadius: CGFloat = 24

        static let primaryColor = Color(red: 0, green: 0.2, blue: 0.4)
    }
}
