import SwiftUI

struct HomeView: View {

    @ObservedObject var api = Api()
    @State private var searchQuery = ""
    @State private var isLoading = false

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .onAppear {
                            Task {
                                await api.fetchCircuits()
                                isLoading = false
                            }
                        }
                } else {
                    List {
                        ForEach(api.circuits.filter {
                            searchQuery.isEmpty ||
                            $0.name.localizedCaseInsensitiveContains(searchQuery) ||
                            $0.description.localizedCaseInsensitiveContains(searchQuery)
                        }, id: \.id) { circuit in
                            CircuitItemView(flag: circuit.flag, name: circuit.name, slug: circuit.slug, description: circuit.description, winner: !circuit.times.isEmpty ? circuit.times[0].gamertag : "")
                        }
                    }
                }
            }
            .navigationTitle("Circuits")
            .searchable(text: $searchQuery)
            .onAppear {
                isLoading = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
