import SwiftUI
import Kingfisher

struct CoffeeCard: View {
    var coffee: Coffee

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(URL(string: coffee.imageUrl))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(coffee.name)
                    .font(.headline)
                    .lineLimit(1)
                
                Text(coffee.description)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                
                HStack {
                    Text(String(format: "$%.2f", coffee.price))
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text(coffee.region)
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                Text(coffee.flavorProfile.joined(separator: ", "))
                    .font(.caption2)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(.white)
        .foregroundStyle(.black)
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.black, lineWidth: 2)
        }
        .shadow(color: Color.black.opacity(0.1), radius: 1, x: 0, y: 1)
        .padding(4)
        .onAppear(){
            print(coffee.imageUrl)
        }
    }
}
