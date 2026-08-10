import SwiftUI
import SQLiteData

@main
struct GameTimeApp: App {
    static private var vm = GameTimerVM()
    init() {
        prepareDependencies {
            $0.defaultDatabase = try! appDatabase()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            GameTimeView(vm: Self.vm)
        }
    }
}
