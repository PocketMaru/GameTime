import Foundation
import SQLiteData

struct GameTimeRepository {
    @Dependency(\.defaultDatabase) private var database
    
    func fetchAll() throws -> [GameTimerRecord] {
        try database.read { db in
            try GameTimerRecord.all.fetchAll(db)
        }
    }
    
    func create(
        name: String,
        timer: Int
    ) throws -> GameTimerRecord {
        try database.write { db in
            try GameTimerRecord
                .insert {
                    GameTimerRecord.Draft(
                        name: name,
                        timer: timer
                    )
                }
                .returning { $0 }
                .fetchOne(db)!
        }
    }
    
    func updateName(
        id: UUID,
        name: String
    ) throws {
        try database.write { db in
            try GameTimerRecord
                .where { $0.id.eq(id) }
                .update {
                    $0.name = name
                }
                .execute(db)
        }
    }
    
    func delete(id: UUID) throws {
        try database.write { db in
            try GameTimerRecord
                .where { $0.id.eq(id) }
                .delete()
                .execute(db)
        }
    }
}
