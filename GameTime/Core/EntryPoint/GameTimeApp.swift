import SwiftUI

@main
struct GameTimeApp: App {
    @State private var vm = GameTimerVM()
    var body: some Scene {
        WindowGroup {
            GameTimeView(vm: vm)
        }
    }
}
