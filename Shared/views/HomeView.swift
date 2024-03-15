import SwiftUI

struct HomeView: View {
    
    @ObservedObject var api = Api()
    @State private var searchQuery = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(api.circuits.filter {
                    searchQuery.isEmpty ||
                    $0.name.localizedCaseInsensitiveContains(searchQuery) ||
                    $0.description.localizedCaseInsensitiveContains(searchQuery)
                }, id: \.id) { circuit in
                    CircuitItemView(flag: circuit.flag, name: circuit.name, description: circuit.description, winner: !circuit.times.isEmpty ? circuit.times[0].gamertag : "")
                }
            }
            .navigationTitle("Circuits")
            .searchable(text: $searchQuery)
            .onAppear {
                Task {
                    await api.fetchCircuits()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
