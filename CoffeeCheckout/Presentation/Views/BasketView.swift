//
//  BasketView.swift
//  CoffeeCheckout
//
//  Created by Vlad Alex Barbatescu on 09/09/2025.
//

import SwiftUI

struct BasketView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Basket")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                Image(systemName: "basket")
                    .font(.title3)
                    .foregroundColor(.white)
            }.padding()
            
            VStack {}
            Spacer()
            .padding()
        }.background(Color.mainBg)
    }
}

#Preview {
    BasketView()
}
