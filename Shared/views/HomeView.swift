import SwiftUI

struct HomeView: View {
    
    @ObservedObject var api = Api()
    
    var body: some View {
        NavigationView {
            List(api.circuits) { circuit in
                CircuitItemView(flag: circuit.flag, name: circuit.name, description: circuit.description, winner: !circuit.times.isEmpty ? circuit.times[0].gamertag : "")
            }.navigationTitle("Circuits")
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
