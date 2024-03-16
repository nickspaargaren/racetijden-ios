import SwiftUI


struct CircuitView: View {
    
    var flag: String
    var name: String
    var description: String
    var winner: String
    
    @ObservedObject var api = Api()
    @State private var isLoading = true

    var body: some View {
        NavigationView {
            Group {
                if isLoading {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .onAppear {
                            fetchCircuitDetails()
                        }
                } else {
                    if let firstCircuit = api.circuits.first {
                        VStack {
                            Image(firstCircuit.flag)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 70)
                                .shadow(radius: 1)
                            Text(firstCircuit.name)
                                .font(.title)
                            Text(firstCircuit.description).padding(.bottom)
                            if !firstCircuit.times.isEmpty {
                                ForEach(firstCircuit.times) { time in
                                    GroupBox {
                                        HStack{
                                            Text(time.gamertag)
                                            Spacer()
                                            Text(time.time).font(.system(.body, design: .monospaced))

                                        }
                                    }
                                   
                                }
                                
                            } else {
                                GroupBox {
                                    Text("No times set")
                                }
                            }
                            Spacer()
                        }
                    } else {
                        Text("No circuit details available")
                    }
                }
            }.padding(20)
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

