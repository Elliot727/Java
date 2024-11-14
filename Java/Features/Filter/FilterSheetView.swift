import SwiftUI

struct FilterSheetView: View {
    @Binding var selectedFlavor: String
    @Binding var selectedGrind: String
    var data: [Coffee]
    @State private var flavours: [String] = []
    @State private var grinds: [String] = []
    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 10)
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    sectionView(title: "Flavor", options: flavours, selected: $selectedFlavor)
                    sectionView(title: "Grind", options: grinds, selected: $selectedGrind)
                }
                .padding()
            }
            .background(Color.white)
            .navigationTitle("Filters")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Reset") {
                        selectedFlavor = ""
                        selectedGrind = ""
                    }
                    .foregroundColor(.blue)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Apply") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            flavours = getUniqueFlavorProfiles(from: data)
            grinds = getUniqueGrinds(from: data)
        }
    }

    private func sectionView(title: String, options: [String], selected: Binding<String>) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(options, id: \.self) { option in
                    filterButton(for: option, isSelected: selected.wrappedValue == option) {
                        selected.wrappedValue = selected.wrappedValue == option ? "" : option
                    }
                }
            }
        }
    }

    private func filterButton(for text: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.black : Color.gray.opacity(0.1))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(8)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func getUniqueFlavorProfiles(from coffeeItems: [Coffee]) -> [String] {
        Array(Set(coffeeItems.flatMap { $0.flavorProfile })).sorted()
    }

    private func getUniqueGrinds(from coffeeItems: [Coffee]) -> [String] {
        Array(Set(coffeeItems.flatMap { $0.grindOption })).sorted()
    }
}
