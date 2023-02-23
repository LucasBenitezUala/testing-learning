//
//  LogManager.swift
//  UalaUtils_Example
//
//  Created by Andrés Abraham Bonilla Gómex on 20/09/21.
//  Copyright © 2021 Ualá. All rights reserved.
//

import Foundation

// swiftlint:disable no_print
public class LogManager: NSObject {
    
    public static let shared: LogManager = LogManager()
    
    override init() { }
    
    public var showLogs: Bool = false
    
    public func debugError(error: Error?, type: Any, fileName: String = #file, lineNumber: Int = #line) {
        if let error: Error = error, showLogs {
            print("\n<\((fileName as NSString).lastPathComponent)> [#\(lineNumber)] ‼️ \nError \(type): \(error.localizedDescription)\n")
        }
    }
    
    public func debug(info: Any, detailed: Bool = true, fileName: String = #file, lineNumber: Int = #line) {
        if showLogs {
            if detailed {
                print("\n<\((fileName as NSString).lastPathComponent)> [#\(lineNumber)] ✳️ \n\(info)\n")
            } else {
                print("\n\(info)")
            }
        }
    }
}
