import SwiftUI
import SQLiteData

@main
struct GameTimeApp: App {
    @State private var vm = GameTimerVM()
    
    init() {
        prepareDependencies {
            $0.defaultDatabase = try! appDatabase()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            GameTimeView(vm: vm)
        }
    }
}
