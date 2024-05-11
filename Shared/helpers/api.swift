import Foundation

class Api: ObservableObject {
    let baseURL = "https://f1.racetijden.nl/api"

    @Published var circuits: [Circuit] = []

    func fetchCircuits() async {
        guard let url = URL(string: "\(baseURL)/circuits") else {
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                self.circuits = response.data.circuits
            }
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }

    func fetchCircuitDetails(circuitName: String) async {
        guard let url = URL(string: "\(baseURL)/circuits/\(circuitName)") else {
            return
        }
        print(url)

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            let response = try decoder.decode(APIResponse.self, from: data)
            DispatchQueue.main.async {
                self.circuits = response.data.circuits
            }
        } catch {
            print("Error decoding JSON: \(error.localizedDescription)")
        }
    }
}
