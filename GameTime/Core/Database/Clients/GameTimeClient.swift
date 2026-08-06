import Foundation
import SQLiteData

struct GameTimeClient {
    var fetchAll: @Sendable () throws -> [GameTimer]
    var create: @Sendable (_ name: String, _ timer: Int) throws -> GameTimer
    var updateName: @Sendable (_ id: GameTimer.ID, _ name: String) throws -> Void
    var delete: @Sendable (_ id: GameTimer.ID) throws -> Void
    var deleteMany: @Sendable (_ ids: [GameTimer.ID]) throws -> Void
}

extension GameTimeClient: DependencyKey {
    static let liveValue: GameTimeClient = {
        let repository = GameTimeRepository()
        
        return GameTimeClient(
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
            },
            deleteMany: { ids in
                try repository.deleteMany(ids: ids)
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
