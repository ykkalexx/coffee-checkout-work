//
//  BottomSheetView.swift
//  CoffeeCheckout
//
//  Created by Vlad Alex Barbatescu on 10/09/2025.
//

import SwiftUI

struct BottomSheetView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(Color.green)

            Text("Payment Success!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.green)

            Text("Your order has been placed successfully.")
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

