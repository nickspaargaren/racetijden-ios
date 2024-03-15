import Foundation

class UserSettings: ObservableObject {
    @Published var showWinners: Bool {
        didSet {
            UserDefaults.standard.set(showWinners, forKey: "showWinners")
        }
    }

    init() {
        self.showWinners = UserDefaults.standard.bool(forKey: "showWinners")
    }
}
