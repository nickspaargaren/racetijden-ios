import SwiftUI

struct CircuitView: View {
    
    var flag: String
    var name: String
    var description: String
    var winner: String
    
    var body: some View {
        VStack {
            Image(flag).resizable().aspectRatio(contentMode: .fit).frame(width: 70).shadow(radius: 1)
            Text(name).font(.title)
            Text(description)
        }
    }
}

struct CircuitView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitView(flag: "nld", name: "Dutch GP", description: "Circuit Zandvoort", winner: "CSI-SNIPER")
    }
}
