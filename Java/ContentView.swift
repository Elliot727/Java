import SwiftUI

struct ContentView: View {
    @Environment(CoffeeViewModel.self) var coffeeViewModel:CoffeeViewModel
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @State var searchText:String = ""
    @State private var selectedFlavor: String = ""
    @State private var selectedGrind: String = ""

    @State private var isFilterSheetPresented: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack {
                if let data = coffeeViewModel.data{
                    HStack(spacing:12){
                        Image(systemName: "person")
                            .imageScale(.small)
                            .foregroundStyle(.white)
                            .padding()
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        Text("Welcome Back")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)
                    HStack{
                        SearchBar(text: $searchText)
          
                        Button {
                            isFilterSheetPresented.toggle()
                        } label: {
                            Image(systemName: "slider.vertical.3")
                                .imageScale(.small)
                                .foregroundStyle(.white)
                                .padding()
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 12)) 
                        }

                    }
                    .padding()
                    ScrollView{
                        LazyVGrid(columns: columns) {
                            ForEach(data, id: \.self) { data in
                                NavigationLink {
                                    CoffeeDetailView(coffee: data)
                                        .navigationBarBackButtonHidden()
                                } label: {
                                    CoffeeCard(coffee: data)
                                }
                                
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                    .padding(.horizontal)
                }
                else{
                    Button {
                        Task{
                            await coffeeViewModel.fetchData()
                        }
                    } label: {
                        Text("Fetch Coffee")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.black)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .padding()
                    }
                    
                }
            }
            .sheet(isPresented: $isFilterSheetPresented) {
                FilterSheetView(selectedFlavor: $selectedFlavor, selectedGrind: $selectedGrind, data: coffeeViewModel.data ?? [])
                       }
            .task {
                await coffeeViewModel.fetchData()
            }
           
        }
    }

    
}
