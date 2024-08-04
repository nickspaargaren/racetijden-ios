import Foundation

struct APIResponse: Codable {
    let success: Bool
    let data: APIData
}

struct APIData: Codable {
    let circuits: [Circuit]
}

struct Circuit: Identifiable, Codable {
    let id = UUID()
    let name: String
    let slug: String
    let description: String
    let flag: String
    let times: [Time]
}

struct Time: Identifiable, Codable {
    let id = UUID()
    let time: String
    let gamertag: String
}
