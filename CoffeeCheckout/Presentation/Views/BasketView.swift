import SwiftUI

struct BasketView: View {
    @StateObject private var viewModel: BasketViewModel
    
    init(viewModel: BasketViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Basket")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }.padding()
            
            if viewModel.basketItems.isEmpty {
                VStack {
                    Spacer()
                    Text("No items in the basket")
                        .foregroundColor(.gray)
                        .font(.title3)
                    Spacer()
                }
            } else {
                ScrollView {
                    ForEach(viewModel.basketItems) { item in
                        HStack(spacing: 20) {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(item.coffee.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text(item.coffee.desc)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .fontWeight(.light)
                                    .lineLimit(2)
                                
                                Text("€\(String(format: "%.2f", item.coffee.price * Double(item.quantity)))")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                            }
                            
                            Spacer()
                            
                            HStack(spacing: 12) {
                                Button(action: {
                                    viewModel.decreaseQuantity(for: item.coffee)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.orange)
                                        .font(.title2)
                                }
                                
                                Text("\(item.quantity)")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .font(.title3)
                                
                                Button(action: {
                                    viewModel.add(coffee: item.coffee)
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.orange)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 12)
                            .background(Color.white.opacity(0.1))
                            .cornerRadius(20)
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                VStack(spacing: 15) {
                    HStack {
                        Text("Subtotal")
                            .foregroundColor(.white)
                        Spacer()
                        Text("€\(viewModel.subtotal, specifier: "%.2f")")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                    }
                    
                    HStack {
                        Text("Delivery")
                            .foregroundColor(.white)
                        Spacer()
                        Text("€\(viewModel.deliveryFee, specifier: "%.2f")")
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
                        Text("€\(viewModel.total, specifier: "%.2f")")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(20)
                .padding()
                
                Button(action: {
                    print("going to checkout")
                }) {
                    Text("Proceed to Checkout")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.basketItems.isEmpty ? Color.gray : Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(viewModel.basketItems.isEmpty)
                .padding(.horizontal)
                .padding(.bottom)
            }
        }
        .background(Color.mainBg.ignoresSafeArea())
    }
}

#Preview {
    let previewRepository = InMemoryBasketRepository()
    
    let previewViewModel = BasketViewModel(repository: previewRepository)
    BasketView(viewModel: previewViewModel)
}
