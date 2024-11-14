import SwiftUI

struct SearchBar: View {
    @Binding var text:String
    var body: some View {
        TextField("Search for a coffee", text: $text)
            .font(.callout)
            .padding()
            .background(.white)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.black, lineWidth: 2)
            }
    }
}

#Preview {
    SearchBar(text: .constant(""))
}
