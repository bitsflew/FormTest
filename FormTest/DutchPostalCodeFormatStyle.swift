//
//  DutchPostalCodeFormatStyle.swift
//  FormTest
//
//  Created by Henk on 06/10/2025.
//

import Foundation

private let regex = /^[1-9][0-9]{3}[A-Z]{2}$/

private func normalized(_ value: String) -> String {
    value.uppercased().replacingOccurrences(of: " ", with: "")
}

struct DutchPostalCodeFormatStyle: FormatStyle {
    typealias FormatInput = String
    typealias FormatOutput = String

    var previousValue: String?

    func format(_ value: String) -> String {
        let normalized = normalized(value)
        print("--format", normalized)
        return normalized
    }
}

extension FormatStyle where Self == DutchPostalCodeFormatStyle {
    static var dutchPostalCode: DutchPostalCodeFormatStyle { .init() }
}

extension DutchPostalCodeFormatStyle: ParseableFormatStyle {
    struct Strategy: ParseStrategy {
        enum ParseError: Error {
            case invalidPostalCode
        }

        func parse(_ value: String) throws -> String {
            let normalized = normalized(value)
            guard normalized.wholeMatch(of: regex) != nil else {
                print("--parse failed", normalized)
                throw ParseError.invalidPostalCode
            }
            // Apply same formatting on input parse
            print("--parse", normalized)
            return normalized
        }
    }

    var parseStrategy: Strategy { Strategy() }
}
