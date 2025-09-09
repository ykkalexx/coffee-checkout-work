import SwiftUI

struct CatalogView: View {
    @StateObject private var viewModel = CatalogViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Text("Menu")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
                
                Image(systemName: "basket")
                    .font(.title3)
                    .foregroundColor(.white)
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
}
