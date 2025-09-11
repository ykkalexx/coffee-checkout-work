//
//  BottomSheetView.swift
//  CoffeeCheckout
//
//  Created by Vlad Alex Barbatescu on 10/09/2025.
//

import SwiftUI

struct BottomSheetPaymentFailed: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.red)

            Text("Payment Failed!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.red)

            Text("Something went wrong. Try again later.")
                .font(.body)
                .foregroundColor(Color.miniText)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 40)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color.cardC.ignoresSafeArea())
    }
}

