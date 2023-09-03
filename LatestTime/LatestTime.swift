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

struct TextWidgetEntry: TimelineEntry {
    let date: Date
    var flag: String
    var circuit: String
    var time: String
    var gamertag: String
    var when: String
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TextWidgetEntry {
        TextWidgetEntry(date: Date(), flag: "nld", circuit: "Dutch GP", time: "01:21.323", gamertag: "CSI-SNIPER", when: "1 dag geleden")
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TextWidgetEntry) -> ()) {
        let entry = TextWidgetEntry(date: Date(), flag: "nld", circuit: "Dutch GP", time: "01:21.323", gamertag: "CSI-SNIPER", when: "1 dag geleden")
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TextWidgetEntry>) -> ()) {
        let entry = TextWidgetEntry(date: Date(), flag: "nld", circuit: "Dutch GP", time: "01:21.323", gamertag: "CSI-SNIPER", when: "1 dag geleden")
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct TextWidgetView: View {
    var entry: Provider.Entry
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.white, .gray.opacity(0.5)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Image(entry.flag).resizable().aspectRatio(contentMode: .fill).frame(width: 30, height: 30).clipShape(Circle()).shadow(radius: 1)
                    
                    VStack(alignment: .leading) {
                        Text(entry.circuit).font(.system(size: 14)).fontWeight(.semibold).lineLimit(1)
                        Text(entry.when).font(.system(size: 12)).foregroundColor(.gray).lineLimit(1)
                    }
                }.padding(.vertical, 10)
                Divider()
                VStack(spacing: 4) {
                    Text(entry.gamertag).font(.subheadline).fontWeight(.semibold).lineLimit(1)
                    HStack {
                        Image(systemName:  "timer").resizable().scaledToFit().frame(height: 12)
                        Text(entry.time).font(.system(size: 14))
                    }
                }.padding(.vertical, 10)
                
            }.padding()
        }
    }
}


struct TextWidget_Previews: PreviewProvider {
    static var previews: some View {
        TextWidgetView(entry: TextWidgetEntry(date: Date(), flag: "nld", circuit: "Dutch GP", time: "01:21.323", gamertag: "CSI-SNIPER", when: "1 dag geleden"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
