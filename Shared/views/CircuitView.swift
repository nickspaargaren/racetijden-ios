import SwiftUI

struct CircuitView: View {

    var flag: String
    var name: String
    var description: String
    var winner: String

    @ObservedObject var api = Api()
    @State private var isLoading = true
    @State private var newTimeText = ""
    @State private var showAlert = false

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .onAppear {
                        fetchCircuitDetails()
                    }
            } else {
                List {
                    if let firstCircuit = api.circuits.first {
                        HStack {
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
                                    HStack {
                                        Text(time.gamertag)
                                        Spacer()
                                        Text(time.time).font(.system(.body, design: .monospaced))
                                    }
                                }
                            } else {
                                Text("No times")
                            }
                        }
                        Section(header: Text("New time")) {
                        TextField("00:00.000", text: $newTimeText).font(.system(.body, design: .monospaced))
                        Button(action: {
                            setNewTime()
                        }) {
                            Text("Set Time")
                        }
                    }
                    } else {
                        Text("No circuit details available")
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Success"), message: Text("New time set successfully"), dismissButton: .default(Text("OK")))
        }
    }

    private func fetchCircuitDetails() {
        Task {
            await api.fetchCircuitDetails(circuitName: name)
            isLoading = false
        }
    }

    private func setNewTime() {
        showAlert = true
    }
}

struct CircuitView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitView(flag: "nld", name: "Dutch GP", description: "Circuit Zandvoort", winner: "CSI-SNIPER")
    }
}
