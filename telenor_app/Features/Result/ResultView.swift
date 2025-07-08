//
//  ResultView.swift
//  telenor_app
//
//  Created by Bagics Bence
//

import SwiftUI

struct ResultView: View {
    let isSuccess: Bool
    let coordinator: StickerSelectionCoordinatorInterface

    var body: some View {
        ZStack {
            backgroundColor
            VStack(spacing: verticalSpacing) {
                Spacer()
                emojiView
                messageView
                Spacer()
                actionButton
            }
            .padding()
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

private extension ResultView {
    var backgroundColor: Color {
        isSuccess ? .successGreen : .failureRed
    }

    var verticalSpacing: CGFloat { 32 }
    var emojiFontSize: Font { .largeTitle }
    var messageFont: Font { .largeTitle.bold() }
    var messageTextColor: Color { .black }
    var buttonTextColor: Color { .white }
    var buttonBackgroundColor: Color { .black }
    var buttonHorizontalPadding: CGFloat { 16 }
    var emojiText: String { "🎉🎉🎉" }
    var messageText: String {
        isSuccess ? Strings.Result.success : Strings.Result.failure
    }

    @ViewBuilder
    var emojiView: some View {
        if isSuccess {
            Text(emojiText)
                .font(emojiFontSize)
        }
    }

    var messageView: some View {
        Text(messageText)
            .multilineTextAlignment(.center)
            .font(messageFont)
            .foregroundColor(messageTextColor)
    }

    var actionButton: some View {
        Button(action: {
            coordinator.popToRoot()
        }) {
            Text(Strings.Common.confirm)
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonBackgroundColor)
                .foregroundColor(buttonTextColor)
                .clipShape(Capsule())
        }
        .padding(.horizontal, buttonHorizontalPadding)
    }
}

extension Color {
    static let successGreen = Color(red: 0.7, green: 1.0, blue: 0.2)
    static let failureRed = Color(red: 1.0, green: 0.2, blue: 0.2)
}
