//
//  Utility.swift
//  Utility
//
//  Created by Nikita Nikitin on 21.08.2021.
//

import Foundation

func inMainActor(_ operation: @escaping () -> Void) {
    Task {
        await MainActor.run {
            operation()
        }
    }
}
