import Foundation
import SQLiteData

struct MissingRecordError: Error {}
struct GameTimeRepository {
    @Dependency(\.defaultDatabase) private var database
    
    func create(
        name: String,
        timer: Int
    ) throws -> GameTimer {
        let record = try database.write { db in
            try GameTimerRecord
                .insert {
                    GameTimerRecord.Draft(
                        name: name,
                        timer: timer
                    )
                }
                .returning { $0 }
                .fetchOne(db)
        }
        guard let record else {
            throw MissingRecordError()
        }
        return GameTimer(record)
    }
    
    func updateName(
        id: GameTimer.ID,
        name: String
    ) {
        withErrorReporting {
            try database.write { db in
                try GameTimerRecord
                    .where { $0.id.eq(id) }
                    .update {
                        $0.name = name
                    }
                    .execute(db)
            }
        }
    }
    
    func delete(id: GameTimer.ID) {
        withErrorReporting {
            try database.write { db in
                try GameTimerRecord
                    .where { $0.id.eq(id) }
                    .delete()
                    .execute(db)
            }
        }
    }
    
    func deleteMany(ids: Set<GameTimer.ID>) {
        withErrorReporting {
            try database.write { db in
                try GameTimerRecord
                    .where { $0.id.in(ids) }
                    .delete()
                    .execute(db)
            }
        }
    }
}
