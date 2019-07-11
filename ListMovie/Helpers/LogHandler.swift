//
//  LogHandler.swift
//  FlickFeedTestMVVM
//
//  Created by Maheep on 06/06/19.
//  Copyright © 2019 Maheep. All rights reserved.
//

import UIKit
import XCGLogger

let appDelegate = UIApplication.shared.delegate
let log: XCGLogger = {
    
    let log = XCGLogger.default
    log.remove(destinationWithIdentifier: XCGLogger.Constants.baseConsoleDestinationIdentifier)
    log.add(destination: AppleSystemLogDestination(identifier: XCGLogger.Constants.systemLogDestinationIdentifier))
    log.logAppDetails()
    
    
    #if DEBUG_STAGING
    log.outputLevel = .debug
    #elseif DEBUG_PROD
    log.outputLevel = .debug
    #elseif DEBUG_DEV
    log.outputLevel = .debug
    #elseif DEBUG_DOCKER
    log.outputLevel = .debug
    #elseif RELEASE_STAGING
    log.outputLevel = .none
    #elseif RELEASE_PROD
    log.outputLevel = .none
    #else
    log.outputLevel = .debug
    #endif
    
    
    // Setup XCGLogger (Advanced/Recommended Usage)
    // Create a logger object with no destinations
    
    //******************************************************************************************//
    /*
     let log = XCGLogger(identifier: "advancedLogger", includeDefaultDestinations: false)
     
     // Create a destination for the system console log (via NSLog)
     let systemDestination = AppleSystemLogDestination(identifier: "advancedLogger.appleSystemLogDestination")
     
     // Optionally set some configuration options
     
     #if DEBUG_DEV
     systemDestination.outputLevel = .verbose
     #else
     systemDestination.outputLevel = .severe
     #endif
     systemDestination.showLogIdentifier = false
     systemDestination.showFunctionName = false
     systemDestination.showThreadName = false
     systemDestination.showLevel = true
     systemDestination.showFileName = false
     systemDestination.showLineNumber = true
     
     // Add the destination to the logger
     log.add(destination: systemDestination)
     
     // Create a file log destination
     let logPath: URL = cacheDirectory.appendingPathComponent("XCGLogger_Log.txt")
     let autoRotatingFileDestination = AutoRotatingFileDestination(writeToFile: logPath, identifier: "advancedLogger.fileDestination", shouldAppend: true,
     attributes: [.protectionKey: FileProtectionType.completeUntilFirstUserAuthentication], // Set file attributes on the log file
     maxFileSize: 1024 * 5, // 5k, not a good size for production (default is 1 megabyte)
     maxTimeInterval: 60, // 1 minute, also not good for production (default is 10 minutes)
     targetMaxLogFiles: 20) // Default is 10, max is 255
     
     // Optionally set some configuration options
     autoRotatingFileDestination.outputLevel = .debug
     autoRotatingFileDestination.showLogIdentifier = false
     autoRotatingFileDestination.showFunctionName = false
     autoRotatingFileDestination.showThreadName = false
     autoRotatingFileDestination.showLevel = true
     autoRotatingFileDestination.showFileName = false
     autoRotatingFileDestination.showLineNumber = true
     autoRotatingFileDestination.showDate = false
     
     // Process this destination in the background
     autoRotatingFileDestination.logQueue = XCGLogger.logQueue
     // Add basic app info, version info etc, to the start of the logs
     log.logAppDetails()
     
     // Alternatively, you can use emoji to highlight log levels (you probably just want to use one of these methods at a time).*/
    
    //******************************************************************************************//
    
    
    let emojiLogFormatter = PrePostFixLogFormatter()
    emojiLogFormatter.apply(prefix: "🗯🗯🗯 ", postfix: " 🗯🗯🗯", to: .verbose)
    emojiLogFormatter.apply(prefix: "🔹🔹🔹 ", postfix: " 🔹🔹🔹", to: .debug)
    emojiLogFormatter.apply(prefix: "ℹ️ℹ️ℹ️ ", postfix: " ℹ️ℹ️ℹ️", to: .info)
    emojiLogFormatter.apply(prefix: "⚠️⚠️⚠️ ", postfix: " ⚠️⚠️⚠️", to: .warning)
    emojiLogFormatter.apply(prefix: "‼️‼️‼️ ", postfix: " ‼️‼️‼️", to: .error)
    emojiLogFormatter.apply(prefix: "💣💣💣 ", postfix: " 💣💣💣", to: .severe)
    log.formatters = [emojiLogFormatter]
    
    return log
}()

let documentsDirectory: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.endIndex - 1]
}()

let cacheDirectory: URL = {
    let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
    return urls[urls.endIndex - 1]
}()

class HPBLogHandler: NSObject {
    
    
    
}


//// Create custom tags for your logs
//extension Tag {
//    static let sensitive = Tag("sensitive")
//    static let ui = Tag("ui")
//    static let data = Tag("data")
//}
//
//// Create custom developers for your logs
//extension Dev {
//    static let dave = Dev("dave")
//    static let sabby = Dev("sabby")
//}

