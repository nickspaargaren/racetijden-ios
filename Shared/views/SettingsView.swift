import SwiftUI

struct SettingsView: View {

    @ObservedObject var userSettings = UserSettings()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User settings")) {
                    HStack {
                        TextField("Your Gamertag", text: $userSettings.gamertag)
                        if !userSettings.gamertag.isEmpty {
                            Button(action: {
                                userSettings.gamertag = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                Section(header: Text("App settings")) {
                    Toggle("Show winners", isOn: $userSettings.showWinners)
                }

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
