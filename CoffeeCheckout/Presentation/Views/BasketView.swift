import SwiftUI

struct BasketView: View {
    @EnvironmentObject var basketManager: BasketManagement
    
    var body: some View {
        VStack {
            HStack {
                Text("Basket")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                BasketButtonView(basketManager: basketManager)
            }.padding()
            
            
            if basketManager.basketItems.isEmpty {
                Text("No items in the basket")
                    .foregroundColor(Color.miniText)
                    .font(.title3)
            }
            
            ScrollView {
                ForEach(basketManager.basketItems) { item in
                    BasketCard {
                        HStack(spacing: 20) {
                            
                            VStack(alignment: .leading, spacing: 15) {
                                Text(item.coffee.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text(item.coffee.desc)
                                    .font(.system(size: 18))
                                    .foregroundColor(.miniText)
                                    .fontWeight(.light)
                                    .lineLimit(10)
                                
                                Text("\(fetchLocalCurrency())\(String(format: "%.2f", item.coffee.price * Double(item.quantity)))")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Button(action: {
                                    basketManager.decreaseQuanityOfItem(item.coffee)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.orange)
                                }
                                
                                Text("\(item.quantity)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Button(action: {
                                    basketManager.addCoffeeToBasket(item.coffee)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.orange)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.secondary.opacity(0.1))
                            .cornerRadius(20)
                        }
                    }
                    .frame(height: 100)
                    .padding()
                }
            }
            
            Spacer()
            
            VStack(spacing: 15) {
                HStack {
                    Text("Subtotal")
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(fetchLocalCurrency())\(basketManager.subtotal, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                
                HStack {
                    Text("Delivery")
                        .foregroundColor(.white)
                    Spacer()
                    Text("\(fetchLocalCurrency())\(basketManager.deliveryFee, specifier: "%.2f")")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }

                Divider().background(Color.white)

                HStack {
                    Text("Total")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                    Spacer()
                    Text("\(fetchLocalCurrency())\(basketManager.total, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.orange)
                }
            }
            .padding()
            .background(Color.cardC)
            .cornerRadius(20)
            .padding()
            
            BasketButton(action: {
                basketManager.emptyBasket()
            }) {
                Text("Proceed to Checkout")
            }.disabled(basketManager.basketItems.isEmpty)
            
            Spacer()
        }
        .background(Color.mainBg)
    }
}

#Preview {
    BasketView()
        .environmentObject(BasketManagement())
}
