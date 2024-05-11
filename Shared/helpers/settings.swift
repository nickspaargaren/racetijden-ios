import Foundation

class UserSettings: ObservableObject {
    @Published var showWinners: Bool {
        didSet {
            UserDefaults.standard.set(showWinners, forKey: "showWinners")
        }
    }

    @Published var gamertag: String {
        didSet {
            UserDefaults.standard.set(gamertag, forKey: "gamertag")
        }
    }

    init() {
        self.showWinners = UserDefaults.standard.bool(forKey: "showWinners")
        self.gamertag = UserDefaults.standard.string(forKey: "gamertag") ?? ""
    }
}
