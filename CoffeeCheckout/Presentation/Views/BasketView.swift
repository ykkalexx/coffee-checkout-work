import SwiftUI

struct BasketView: View {
    @ObservedObject private var viewModel: BasketViewModel
    
    init(viewModel: BasketViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 0) {
            headerView
            contentView
        }
        .background(Color.mainBg.ignoresSafeArea())
    }
}


private extension BasketView {
    var headerView: some View {
        HStack {
            Text("Basket")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
            Spacer()
        }
        .padding()
    }
    
    @ViewBuilder
    var contentView: some View {
        if viewModel.basketItems.isEmpty {
            emptyBasketView
        } else {
            basketContentsView
        }
    }

    var emptyBasketView: some View {
        VStack {
            Spacer()
            Text("Your basket is empty")
                .foregroundColor(.gray)
                .font(.title3)
            Spacer()
        }
    }
    
    var basketContentsView: some View {
        VStack {
            basketListView
            summaryView
            checkoutButton
        }
    }

    var basketListView: some View {
        ScrollView {
            ForEach(viewModel.basketItems) { item in
                BasketCard(
                    imageName: "cup.and.saucer.fill",
                    title: item.coffee.name,
                    price: "€\(String(format: "%.2f", item.coffee.price))",
                    quantity: item.quantity,
                    onDecrement: {
                        viewModel.decreaseQuantity(for: item.coffee)
                    },
                    onIncrement: {
                        viewModel.add(coffee: item.coffee)
                    }
                )
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
        }
    }
    
    var summaryView: some View {
        VStack(spacing: 15) {
            HStack {
                Text("Subtotal")
                Spacer()
                Text("€\(viewModel.subtotal, specifier: "%.2f")")
                    .fontWeight(.semibold)
            }
            
            HStack {
                Text("Delivery")
                Spacer()
                Text("€\(viewModel.deliveryFee, specifier: "%.2f")")
                    .fontWeight(.semibold)
            }

            Divider().background(Color.white.opacity(0.5))

            HStack {
                Text("Total")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
                Spacer()
                Text("€\(viewModel.total, specifier: "%.2f")")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.orange)
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.white.opacity(0.1))
        .cornerRadius(20)
        .padding()
    }
    
    var checkoutButton: some View {
        Button(action: {
            print("going to checkout")
        }) {
            Text("Proceed to Checkout")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    let previewRepository = InMemoryBasketRepository()
    let previewViewModel = BasketViewModel(repository: previewRepository)
    
    return BasketView(viewModel: previewViewModel)
        .environmentObject(previewViewModel)
}
