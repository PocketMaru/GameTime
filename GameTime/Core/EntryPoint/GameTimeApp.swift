import SwiftUI
import SQLiteData

@main
struct GameTimeApp: App {
    
    init() {
        prepareDependencies {
            $0.defaultDatabase = try! appDatabase()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            GameTimeView()
        }
    }
}
