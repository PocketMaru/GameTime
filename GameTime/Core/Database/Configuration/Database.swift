import OSLog
import SQLiteData

func appDatabase() throws -> any DatabaseWriter {
    @Dependency(\.context) var context
    
    var config = Configuration()
    
#if DEBUG
    config.prepareDatabase { db in
        db.trace(options: .profile) {
            if context == .preview {
                print("\($0.expandedDescription)")
            } else {
                logger.debug("\($0.expandedDescription)")
            }
        }
    }
#endif
    
    let db = try defaultDatabase(
        configuration: config
    )
    
    var migrator = DatabaseMigrator()
    
#if DEBUG
    migrator.eraseDatabaseOnSchemaChange = true
#endif
    
    migrator.registerMigration("Create game timers") { db in
        try #sql(
            """
            CREATE TABLE "gameTimerRecords" (
                "id" TEXT PRIMARY KEY NOT NULL ON CONFLICT REPLACE DEFAULT (uuid()),
                "name" TEXT NOT NULL,
                "timer" INTEGER NOT NULL
            ) STRICT
            """
        )
        .execute(db)
    }
    
    try migrator.migrate(db)
    
    logger.info("Opened database at `\(db.path)`")
    
    return db
}

private let logger = Logger(
    subsystem: "GameTime",
    category: "Database"
)
