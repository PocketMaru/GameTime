import Foundation
import SQLiteData

struct GameTimerClient {
    var fetchAll: @Sendable () throws -> [GameTimerRecord]
    var create: @Sendable (_ name: String, _ timer: Int) throws -> GameTimerRecord
    var updateName: @Sendable (_ id: UUID, _ name: String) throws -> Void
    var delete: @Sendable (_ id: UUID) throws -> Void
}

extension GameTimerClient: DependencyKey {
    static let liveValue: GameTimerClient = {
        let repository = GameTimeRepository()
        
        return GameTimerClient(
            fetchAll: {
                try repository.fetchAll()
            },
            create: { name, timer in
                try repository.create(
                    name: name,
                    timer: timer
                )
            },
            updateName: { id, name in
                try repository.updateName(
                    id: id,
                    name: name
                )
            },
            delete: { id in
                try repository.delete(id: id)
            }
        )
    }()
}

extension DependencyValues {
    var gameTimerClient: GameTimerClient {
        get { self[GameTimerClient.self] }
        set { self[GameTimerClient.self] = newValue }
    }
}
