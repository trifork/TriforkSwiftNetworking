import Foundation
import os.log

final class Logger {
    static func log(_ message: String) {
        if #available(iOS 10.0, watchOS 3.0, macOS 10.12, tvOS 10.0, *) {
            os_log("%@", log: OSLog(subsystem: "TriforkSwiftNetworking", category: "Networking"), type: .debug, message)
        } else {
            print("%@", message)
        }
    }
}
