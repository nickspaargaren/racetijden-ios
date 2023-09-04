import SwiftUI
import WidgetKit

@main
struct TextWidget: Widget {
    private let kind: String = "TextWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TextWidgetView(entry: entry)
        }
        .configurationDisplayName("Latest time")
        .description("View the latest time set")
    }
}

struct Model: TimelineEntry {
    var date: Date
    var widgetData: LatestTimeModel
}

struct LatestTimeModel: Decodable {
    var success: Bool
    var data: Times
}

struct Times: Decodable {
    var times: [Time]
}

struct Time: Decodable {
    var time: String
    var gamertag: String
    var createdAt: String
    var updatedAt: String
    var circuitId: Int
    var circuit: Circuit
    var id: Int
}

struct Circuit: Decodable {
    var name: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> Model {
        let placeholderData = LatestTimeModel(success: true, data: Times(times: []))
        return Model(date: Date(), widgetData: placeholderData)
    }

    func getSnapshot(in context: Context, completion: @escaping (Model) -> ()) {
        let snapshotData = LatestTimeModel(success: true, data: Times(times: []))
        let entry = Model(date: Date(), widgetData: snapshotData)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Model>) -> ()) {
        guard let url = URL(string: "https://f1.racetijden.nl/api/times/latest") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            var entries: [Model] = []

            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let latestTimeData = try decoder.decode(LatestTimeModel.self, from: data)
                    let entry = Model(date: Date(), widgetData: latestTimeData)
                    entries.append(entry)
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }

            let nextUpdateDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
            let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))
            completion(timeline)
        }.resume()
    }
}

struct TextWidgetView: View {
    var entry: Model

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Image(systemName: "sun.max.circle.fill").resizable().aspectRatio(contentMode: .fill).frame(width: 30, height: 30).clipShape(Circle()).shadow(radius: 1)
                    
                    VStack(alignment: .leading) {
                        Text(entry.widgetData.data.times.first?.circuit.name ?? "Italian GP").font(.system(size: 14)).fontWeight(.semibold).lineLimit(1)
                        Text(entry.widgetData.data.times.first?.updatedAt ?? "1 dag geleden..").font(.system(size: 12)).foregroundColor(.gray).lineLimit(1)
                    }
                }.padding(.vertical, 10)
                Divider()
                VStack(spacing: 4) {
                    Text(entry.widgetData.data.times.first?.gamertag ?? "CSI-SNIPER").font(.subheadline).fontWeight(.semibold).lineLimit(1)
                    HStack {
                        Image(systemName: "clock.fill").resizable().scaledToFit().frame(height: 12)
                        Text(entry.widgetData.data.times.first?.time ?? "01:21.323").font(.system(size: 14))
                    }
                }.padding(.vertical, 10)
                
            }.padding()
        }
    }
}


struct TextWidget_Previews: PreviewProvider {
    static var previews: some View {
        TextWidgetView(entry: Model(date: Date(), widgetData: LatestTimeModel(success: true, data: Times(times: []))))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
