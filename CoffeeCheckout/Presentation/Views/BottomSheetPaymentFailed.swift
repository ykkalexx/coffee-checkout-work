//
//  BottomSheetView.swift
//  CoffeeCheckout
//
//  Created by Vlad Alex Barbatescu on 10/09/2025.
//

import SwiftUI

struct BottomSheetPayment: View {
    let imageName: String
    let title: String
    let message: String
    let isSuccess: Bool
    
    init(
        imageName: String,
        title: String,
        message: String,
        isSuccess: Bool
    ) {
        self.imageName = imageName
        self.title = title
        self.message = message
        self.isSuccess = isSuccess
    }
    
    var body: some View {
        VStack(spacing: 20) {
            imageView
            titleView
            messageView
        }
        .padding(.vertical, 40)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .background(Color.cardC.ignoresSafeArea())
    }
}

private extension BottomSheetPayment {
    var imageView: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 50)
            .foregroundColor(isSuccess ? Color.green : Color.red)
    }
    
    var titleView: some View {
        Text(title)
            .font(.title)
            .fontWeight(.bold)
            .foregroundColor(isSuccess ? Color.green : Color.red)
    }
    
    var messageView: some View {
        Text(message)
            .font(.body)
            .foregroundColor(Color.miniText)
            .foregroundColor(isSuccess ? Color.green : Color.red)
    }
}
