import SwiftUI

struct SettingsView: View {
    
    @ObservedObject var userSettings = UserSettings()

    var body: some View {
        NavigationView {
            Form {
                Toggle("Show winners", isOn: $userSettings.showWinners)
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
