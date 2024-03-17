import SwiftUI

struct CircuitView: View {
    
    var flag: String
    var name: String
    var description: String
    var winner: String
    
    @ObservedObject var api = Api()
    @State private var isLoading = true
    @State private var newTimeText = ""
    
    var body: some View {
        List {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        fetchCircuitDetails()
                    }
            } else {
                if let firstCircuit = api.circuits.first {
                    HStack{
                        Spacer()
                        VStack(alignment: .center) {
                            Image(firstCircuit.flag)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70)
                                .shadow(radius: 1)
                            Text(firstCircuit.name)
                                .font(.title)
                            Text(firstCircuit.description)
                        }
                        Spacer()
                    }.listRowBackground(Color.clear)
                    Section {
                        if !firstCircuit.times.isEmpty {
                            ForEach(firstCircuit.times) { time in
                                HStack{
                                    Text(time.gamertag)
                                    Spacer()
                                    Text(time.time).font(.system(.body, design: .monospaced))
                                }
                            }
                        } else {
                            Text("No times")

                        }
                    }
                } else {
                    Text("No circuit details available")
                }
            }
        }
    }
    
    private func fetchCircuitDetails() {
        Task {
            await api.fetchCircuitDetails(circuitName: name)
            isLoading = false
        }
    }
}

struct CircuitView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitView(flag: "nld", name: "Dutch GP", description: "Circuit Zandvoort", winner: "CSI-SNIPER")
    }
}
