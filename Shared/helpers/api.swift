import Foundation

class Api: ObservableObject {
    let baseURL = "https://f1.racetijden.nl/api"

    @Published var circuits: [Circuit] = []

    func fetchCircuits() {
        guard let url = URL(string: baseURL + "/circuits") else {
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
