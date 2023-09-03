//
//  ContentView.swift
//  Shared
//
//  Created by Nick Spaargaren on 03/09/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            List {
                CircuitItemView(flag: "ita", name: "Italian GP", description: "Monza", winner: "CSI-SNIPER")
                
                CircuitItemView(flag: "mco", name: "Monaco GP", description: "Monte Carlo", winner: "CSI-SNIPER")
                
                CircuitItemView(flag: "bra", name: "Brazilian GP", description: "Interlagos, São Paulo", winner: "nickspaargaren25")
                
                CircuitItemView(flag: "nld", name: "Dutch GP", description: "Circuit Zandvoort", winner: "CSI-SNIPER")
                
            }.navigationTitle("Circuits")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
