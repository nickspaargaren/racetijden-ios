//
//  CircuitItemView.swift
//  racetijden-ios (iOS)
//
//  Created by Nick Spaargaren on 03/09/2023.
//

import SwiftUI

struct CircuitItemView: View {
    
    var flag: String
    var name: String
    var description: String
    var winner: String
    
    var body: some View {
        NavigationLink(destination: CircuitView(flag: flag, name: name, description: description, winner: winner), label: {
            HStack {
                Image(flag).resizable().aspectRatio(contentMode: .fit).frame(width: 30).shadow(radius: 1)
                VStack(alignment: .leading) {
                    Text(name).fontWeight(.semibold).lineLimit(1)
                    Text(description).font(.system(size: 14)).foregroundColor(.gray).lineLimit(1)
                }.padding([.leading, .trailing], 2)
                Spacer()
                Text(winner).font(.subheadline)
                
            }
        })
    }
}

struct CircuitItemView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitItemView(flag: "nld", name: "Dutch GP", description: "Circuit Zandvoort", winner: "CSI-SNIPER")
    }
}
