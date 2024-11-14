import Kingfisher
import SwiftUI

struct CoffeeDetailView: View {
    var coffee: Coffee
    @Environment(\.dismiss) var dismiss
    @State private var quantity: Int = 1

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .imageScale(.small)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Spacer()
            }
            .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    KFImage(URL(string: coffee.imageUrl))
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 10)
                        .scaleEffect(1.25)
                    
                    Text(coffee.name)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    Text(coffee.description)
                        .font(.body)
                        .padding(.horizontal)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "map")
                            .foregroundColor(.black)
                        Text(coffee.region)
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(.secondary)
                        Spacer()
                        Image(systemName: "scalemass")
                            .foregroundColor(.black)
                        Text("\(coffee.weight)g")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    
                  
                    Stepper("Quantity: \(quantity)", value: $quantity, in: 1...100)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("Flavor Profile")
                            .font(.headline)
                            .padding(.horizontal)
                        HStack {
                            ForEach(coffee.flavorProfile, id: \.self) { flavor in
                                Text(flavor)
                                    .font(.caption)
                                    .padding(8)
                                    .background(.black.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Grind Options")
                            .font(.headline)
                            .padding(.horizontal)
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach(coffee.grindOption, id: \.self) { option in
                                    Text(option)
                                        .font(.caption)
                                        .padding(8)
                                        .background(.black.opacity(0.1))
                                        .clipShape(RoundedRectangle(cornerRadius: 6))
                                }
                            }
                            .padding(.horizontal)
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                
            }
            .scrollIndicators(.hidden)
            HStack{
                Button(action: {
                    
                }) {
                    Text("Buy Now")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.trailing)
                Spacer()
                Text("$\(String(format: "%.2f", coffee.price * Double(quantity)))")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
            .padding()
        }
    }
}

#Preview {
    CoffeeDetailView(coffee: Coffee(
        id: 1,
        name: "Ethiopian Yirgacheffe",
        description: "Bright and floral with a hint of fruitiness. This coffee is known for its complex flavor profile and clean, tea-like body.",
        price: 15.99,
        region: "Ethiopia",
        weight: 250,
        flavorProfile: ["Floral", "Citrus", "Fruity"],
        grindOption: ["Whole Bean", "Coarse", "Medium", "Fine"],
        roastLevel: 2,
        imageUrl: "https://iili.io/H8Y7WEg.webp"
    ))
}

