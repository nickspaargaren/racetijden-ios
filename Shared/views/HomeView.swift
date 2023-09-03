import SwiftUI

struct HomeView: View {
    @State private var circuits: [Circuit] = []
    
    var body: some View {
        NavigationView {
            List(circuits) { circuit in
                CircuitItemView(flag: circuit.flag, name: circuit.name, description: circuit.description, winner: !circuit.times.isEmpty ? circuit.times[0].gamertag : "")
                
            }.navigationTitle("Circuits")
                .onAppear(perform: fetchCircuits)
        }
    }
    
    func fetchCircuits() {
        guard let url = URL(string: "https://f1.racetijden.nl/api/circuits") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(APIResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.circuits = response.data.circuits
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

struct APIResponse: Codable {
    let success: Bool
    let data: APIData
}

struct APIData: Codable {
    let circuits: [Circuit]
}

struct Circuit: Identifiable, Codable {
    let id = UUID()
    let name: String
    let description: String
    let flag: String
    let times: [Time]
}

struct Time: Codable {
    let time: String
    let gamertag: String
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
