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

                BasketButtonView(quantity: basketViewModel.totalQuantity)
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
                        CardView {
                            HStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(coffee.name)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                    Text(coffee.desc)
                                        .font(.subheadline)
                                        .foregroundColor(Color.gray)
                                        .lineLimit(2)
                                    Text("€\(String(format: "%.2f", coffee.price))")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    viewModel.addToBasket(coffee: coffee)
                                    
                                    showingConfirmation = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        showingConfirmation = false
                                    }
                                }) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40, height: 40)
                                        .foregroundColor(Color.orange)
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 4)
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

#Preview {
    let basketRepo = InMemoryBasketRepository()
    let coffeeRepo = MockCoffeeRepository()
    let addCoffeeUseCase = AddCoffeeToBasketUseCase(repository: basketRepo)
    
    let catalogVM = CatalogViewModel(
        coffeeRepository: coffeeRepo,
        addCoffeeToBasketUseCase: addCoffeeUseCase
    )
    let basketVM = BasketViewModel(repository: basketRepo)
    
    return CatalogView()
        .environmentObject(catalogVM)
        .environmentObject(basketVM)
}
