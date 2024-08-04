//
//  CircuitItemView.swift
//
//  Created by Nick Spaargaren on 03/09/2023.
//

import SwiftUI

struct CircuitItemView: View {

    @ObservedObject var settings = UserSettings()

    var flag: String
    var name: String
    var slug: String
    var description: String
    var winner: String

    var body: some View {
        NavigationLink(destination: CircuitView(flag: flag, name: name, slug: slug, description: description, winner: winner), label: {
            HStack {
                Image(flag).resizable().aspectRatio(contentMode: .fit).frame(width: 30).shadow(radius: 1)
                VStack(alignment: .leading) {
                    Text(name).fontWeight(.semibold).lineLimit(1)
                    Text(description).font(.system(size: 14)).foregroundColor(.gray).lineLimit(1)
                }.padding([.leading, .trailing], 2)
                Spacer()
                if settings.showWinners {
                    Text(winner).font(.subheadline)
                }

            }
        })
    }
}

struct CircuitItemView_Previews: PreviewProvider {
    static var previews: some View {
        CircuitItemView(flag: "nld", name: "Dutch GP", slug: "dutch-gp", description: "Circuit Zandvoort", winner: "CSI-SNIPER")
    }
}
