import Foundation
import SQLiteData

struct GameTimeClient {
    var create: @Sendable (_ name: String, _ timer: Int) throws -> GameTimer
    var updateName: @Sendable (_ id: GameTimer.ID, _ name: String) -> Void
    var delete: @Sendable (_ id: GameTimer.ID) -> Void
    var deleteMany: @Sendable (_ ids: Set<GameTimer.ID>) -> Void
}

extension GameTimeClient: DependencyKey {
    static let liveValue: GameTimeClient = {
        let repository = GameTimeRepository()
        
        return GameTimeClient(
            create: { name, timer in
                try repository.create(
                    name: name,
                    timer: timer
                )
            },
            updateName: { id, name in
                repository.updateName(
                    id: id,
                    name: name
                )
            },
            delete: { id in
                repository.delete(id: id)
            },
            deleteMany: { ids in
                repository.deleteMany(ids: ids)
            }
        )
    }()
}

extension DependencyValues {
    var gameTimeClient: GameTimeClient {
        get { self[GameTimeClient.self] }
        set { self[GameTimeClient.self] = newValue }
    }
}
