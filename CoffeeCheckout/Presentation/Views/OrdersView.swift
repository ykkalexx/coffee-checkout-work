import SwiftUI

struct OrdersView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Orders")
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
    OrdersView()
}
