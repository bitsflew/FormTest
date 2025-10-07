//
//  NoOpFormatStyle.swift
//  NoOpFormatStyle
//
//  Created by Henk on 03/10/2025.
//

import Foundation

struct NoOpFormatStyle: ParseableFormatStyle {
    typealias FormatInput = String
    typealias FormatOutput = String

    func format(_ value: String) -> String {
        value
    }

    var parseStrategy: NoOpParseStrategy { NoOpParseStrategy() }

    struct NoOpParseStrategy: ParseStrategy {
        func parse(_ value: String) throws -> String {
            return value
        }
    }
}

/*
 if s.wholeMatch(of: regex) != nil {
         print("✅ Partial or full match: \(s)")
     } else {
         print("❌ Invalid prefix: \(s)")
     }
 */



