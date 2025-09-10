import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()
    @EnvironmentObject var basketManager: BasketManagement
    @State private var showingConfirmation = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Menu")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                BasketButtonView(basketManager: basketManager)
            }
            .padding()
            
            VStack {
                ScrollView {
                    if viewModel.isLoading {
                        ProgressView("Loading...")
                            .foregroundColor(.white)
                            .padding()
                    } else if let error = viewModel.error {
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ForEach(viewModel.coffees) {
                            coffee in CardView {
                                HStack(spacing: 20) {
                                    VStack(alignment: .leading, spacing: 15) {
                                        Text(coffee.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                        Text(coffee.desc)
                                            .font(.system(size: 18))
                                            .foregroundColor(.miniText)
                                            .fontWeight(.light)
                                            .lineLimit(10)
                                        Text("\(fetchLocalCurrency())\(String(format: "%.2f", coffee.price))")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    }
                                    Spacer()
                                    Button(action: {
                                        basketManager.addCoffeeToBasket(coffee)
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
                            .frame(maxWidth: 450)
                            .frame(maxHeight: 160)
                            .padding(.vertical, 6)
                        }
                    }
                }
            }.padding()
            Spacer()
        }
        .background(Color.mainBg)
        .task {
            await viewModel.fetchCoffee()
        }
    }
}

#Preview {
    CatalogView()
        .environmentObject(BasketManagement())
}
