//
//  Task+Extension.swift
//  UalaCore
//
//  Created by Uala on 20/07/22.
//

import Foundation

public extension Task where Failure == Error {
    @discardableResult
    public static func withDelay(
        priority: TaskPriority? = nil,
        delaySeconds: TimeInterval = 5,
        operation: @Sendable @escaping () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            let oneSecond = TimeInterval(1_000_000_000)
            let delay = UInt64(oneSecond * delaySeconds)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            
            try Task<Never, Never>.checkCancellation()
            return try await operation()
        }
    }
}
