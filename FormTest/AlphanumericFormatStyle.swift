//
//  AlphanumericFormatStyle.swift
//  FormTest
//
//  Created by Henk on 20/09/2025.
//

// A FormatStyle that ensures the output string is alphanumeric and max 7 characters.

import Foundation



struct AlphanumericFormatStyle: FormatStyle {
    typealias FormatInput = String
    typealias FormatOutput = String

    var maxLength: Int = 7
      
    func format(_ value: String) -> String {
        // 1. Keep only alphanumeric chars
        let filtered = value.filter { $0.isLetter || $0.isNumber }

        // 2. Truncate or pad to exactly 7 chars
        if filtered.count >= 7 {
            return String(filtered.prefix(7))
        } else {
            // Pad with underscores (or any char you want)
            return filtered.padding(toLength: 7, withPad: "_", startingAt: 0)
        }
    }

    func maxLength(_ length: Int) -> Self {
        var copy = self
        copy.maxLength = length
        return copy
    }
}

extension FormatStyle where Self == AlphanumericFormatStyle {
    static var alphanumeric: AlphanumericFormatStyle { .init() }
}

extension AlphanumericFormatStyle: ParseableFormatStyle {
    struct Strategy: ParseStrategy {
        func parse(_ value: String) throws -> String {
            // Apply same formatting on input parse
            let filtered = value.filter { $0.isLetter || $0.isNumber }
            return String(filtered.prefix(7))
        }
    }

    var parseStrategy: Strategy { Strategy() }
}

