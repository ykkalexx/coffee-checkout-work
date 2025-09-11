import SwiftUI

struct CatalogView: View {
    @EnvironmentObject private var viewModel: CatalogViewModel
    @EnvironmentObject private var basketViewModel: BasketViewModel
    
    @State private var showingConfirmation = false
    
    var body: some View {
        VStack {
            
            HStack {
                Text("Menu")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                Button(action: {
                    print("meow")
                }) {
                    Text("")
                }.buttonStyle(BasketButtonStyle(quantity: basketViewModel.totalQuantity))
                
            }
            .padding()
            
            ScrollView {
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else if let error = viewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ForEach(viewModel.coffees) { coffee in
                        CardView(
                            title: coffee.name,
                            description: coffee.desc,
                            price: "€\(String(format: "%.2f", coffee.price))",
                            action: {
                                viewModel.addToBasket(coffee: coffee)
                                
                                showingConfirmation = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    showingConfirmation = false
                                }
                            }
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 15)
                    }
                }
            }
            
            Spacer()
            Spacer()
        }
        .background(Color.mainBg.ignoresSafeArea())
        .task {
            if viewModel.coffees.isEmpty {
                await viewModel.fetchCoffee()
            }
        }
        .overlay(
            Text("Added to Basket!")
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .opacity(showingConfirmation ? 1 : 0)
                .animation(.easeInOut, value: showingConfirmation)
        )
    }
}
