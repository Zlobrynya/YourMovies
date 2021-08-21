//
//  Log.swift
//  YourMovies
//
//  Created by Nikita Nikitin on 11.07.2021.
//

import Foundation

private enum LogType: String {
    case error = "🔴"
    case debug = "🔵"
    case info = "🟢"
}

enum Log {
    static func error(_ value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
        debugPrint(type: .error, value: value, file: file, function: function, line: line)
    }

    static func debug(_ value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
        debugPrint(type: .debug, value: value, file: file, function: function, line: line)
    }

    static func info(_ value: Any?, file: String = #file, function: String = #function, line: Int = #line) {
        debugPrint(type: .info, value: value, file: file, function: function, line: line)
    }

    private static func debugPrint(
        type: LogType,
        value: Any?,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
        let className = file.split(separator: "/").last ?? ""
        let function = function.split(separator: "(").first ?? ""
        let date = Date().getFormattedDate(format: "HH:mm:ss.SSS")
        Swift.debugPrint("\(type.rawValue) \(className)[\(line)]  \(date) - \(function): \(String(describing: value))")
    }
}

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
